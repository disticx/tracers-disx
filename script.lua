local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Exunys Developer";
        Text = "Tracer script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })
    return
end

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")
local TestService = game:GetService("TestService")

local Typing = false

_G.SendNotifications = true
_G.DefaultSettings = false
_G.TeamCheck = false

_G.FromMouse = false
_G.FromCenter = false
_G.FromBottom = true

_G.TracersVisible = true
_G.TracerColor = Color3.fromRGB(255, 80, 10)
_G.TracerThickness = 1
_G.TracerTransparency = 0.7

_G.ModeSkipKey = Enum.KeyCode.E
_G.DisableKey = Enum.KeyCode.Q

local function CreateTracers()
    for _, v in next, Players:GetPlayers() do
        if v ~= Players.LocalPlayer then
            local TracerLine = Drawing.new("Line")

            RunService.RenderStepped:Connect(function()
                if v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)

                    TracerLine.Thickness = _G.TracerThickness
                    TracerLine.Transparency = _G.TracerTransparency
                    TracerLine.Color = _G.TracerColor

                    if _G.FromBottom then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    elseif _G.FromCenter then
                        TracerLine.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    elseif _G.FromMouse then
                        local m = UserInputService:GetMouseLocation()
                        TracerLine.From = Vector2.new(m.X, m.Y)
                    end

                    if onscreen then
                        TracerLine.To = Vector2.new(pos.X, pos.Y)
                        TracerLine.Visible = _G.TracersVisible
                    else
                        TracerLine.Visible = false
                    end
                else
                    TracerLine.Visible = false
                end
            end)
        end
    end
end

pcall(CreateTracers)
