local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button1 = Instance.new("TextButton")
button1.Parent = ScreenGui
button1.Text = "Ativar Massless"
button1.Size = UDim2.new(0, 150, 0, 50)
button1.Position = UDim2.new(0, 0, 1, -90)
button1.AnchorPoint = Vector2.new(0, 1)
button1.TextSize = 10
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local inputX = Instance.new("TextBox")
inputX.Parent = ScreenGui
inputX.Size = UDim2.new(0, 50, 0, 30)
inputX.Position = UDim2.new(0, 0, 1, -140)
inputX.AnchorPoint = Vector2.new(0, 1)
inputX.PlaceholderText = "X"

local inputY = Instance.new("TextBox")
inputY.Parent = ScreenGui
inputY.Size = UDim2.new(0, 50, 0, 30)
inputY.Position = UDim2.new(0, 60, 1, -140)
inputY.AnchorPoint = Vector2.new(0, 1)
inputY.PlaceholderText = "Y"

local inputZ = Instance.new("TextBox")
inputZ.Parent = ScreenGui
inputZ.Size = UDim2.new(0, 50, 0, 30)
inputZ.Position = UDim2.new(0, 120, 1, -140)
inputZ.AnchorPoint = Vector2.new(0, 1)
inputZ.PlaceholderText = "Z"

local function activateMassless()
    local trucksFolder = workspace:FindFirstChild("Trucks")
    if trucksFolder then
        local tugCount = 0
        local sizeX = tonumber(inputX.Text) or 80
        local sizeY = tonumber(inputY.Text) or 10
        local sizeZ = tonumber(inputZ.Text) or 5

        for _, model in pairs(trucksFolder:GetChildren()) do
            if model:IsA("Model") and model.Name == "Tug" then
                tugCount = tugCount + 1
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if part.Name ~= "Weight" then
                            part.Massless = true
                        end
                        if part.Name == "DrillTouch" then
                            part.Size = Vector3.new(sizeX, sizeY, sizeZ)
                            part.Transparency = 0.8
                            part.Color = Color3.fromRGB(255, 105, 180) -- Rosa
                            part.Material = Enum.Material.Neon
                            for _, child in pairs(part:GetChildren()) do
                                if child:IsA("SpecialMesh") or child:IsA("Mesh") or child:IsA("CylinderMesh") or child.Name == "Mesh" then
                                    child:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end
        print(tugCount .. " modelos Tug processados.")
    else
        print("Pasta 'Trucks' não encontrada. ❌")
    end
end

button1.MouseButton1Click:Connect(activateMassless)
