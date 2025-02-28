local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Parent = ScreenGui
button.Text = "Modificar Mapa"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0, 10, 1, -40)
button.AnchorPoint = Vector2.new(0, 1)
button.TextSize = 10
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

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
                        obj.CastShadow = false
                        obj.CanCollide = false
                        obj.CanQuery = false
                        obj.CanTouch = false
                        obj.Transparency = 0.4
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

local function modRefinery()
    local map = workspace:FindFirstChild("map")
    if map then
        local refinery = map:FindFirstChild("Refinery")
        if refinery then
            local interactive = refinery:FindFirstChild("Interactive")
            if interactive then
                local refineryPart = interactive:FindFirstChild("RefineryStaging")
                if refineryPart and refineryPart:IsA("Part") then
                    refineryPart.CastShadow = false
                    refineryPart.Color = Color3.fromRGB(255, 0, 255)
                    refineryPart.Material = Enum.Material.Neon
                    refineryPart.Transparency = 1
                    refineryPart.Size = Vector3.new(450, 25, 225)
                end
            end
        end
    end
end

button.MouseButton1Click:Connect(function()
    modIncinerator()
    modRefinery()
end)
