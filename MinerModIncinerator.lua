local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button1 = Instance.new("TextButton")
button1.Parent = ScreenGui
button1.Text = "Modificar Incenerador"
button1.Size = UDim2.new(0, 150, 0, 50)
button1.Position = UDim2.new(0, 0, 1, -90)
button1.AnchorPoint = Vector2.new(0, 1)
button1.TextSize = 10
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local function modIncinerator()
    local map = workspace:FindFirstChild("map")
    if map then
        local incinerator = map:FindFirstChild("Incinerator")
        if incinerator and incinerator:IsA("Model") then
            local console = incinerator:FindFirstChild("Console")
            for _, obj in ipairs(incinerator:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "Lava" then
                    local inConsole = console and obj:IsDescendantOf(console)
                    if not inConsole then
                        obj.CanCollide = false
                        obj.CanQuery = false
                        obj.CanTouch = false
                        obj.Transparency = 0.8
                        if obj.Material ~= Enum.Material.Neon then
                            obj.Material = Enum.Material.SmoothPlastic
                        end
                    end
                elseif obj:IsA("Decal") then
                    obj:Destroy()
                end
            end
        end
    end
end

button1.MouseButton1Click:Connect(modIncinerator)
