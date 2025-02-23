local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local button2 = Instance.new("TextButton")
button2.Parent = ScreenGui
button2.Text = "Modificar todos os Tugs"
button2.Size = UDim2.new(0, 150, 0, 50)
button2.Position = UDim2.new(0, 10, 1, -90)
button2.AnchorPoint = Vector2.new(0, 1)
button2.TextSize = 10
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local inputX = Instance.new("TextBox")
inputX.Parent = ScreenGui
inputX.Size = UDim2.new(0, 50, 0, 30)
inputX.Position = UDim2.new(0, 10, 1, -140)
inputX.AnchorPoint = Vector2.new(0, 1)
inputX.Text = "X"
inputX.PlaceholderText = "X"
inputX.TextSize = 10
inputX.TextColor3 = Color3.fromRGB(255, 255, 255)
inputX.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local inputY = Instance.new("TextBox")
inputY.Parent = ScreenGui
inputY.Size = UDim2.new(0, 50, 0, 30)
inputY.Position = UDim2.new(0, 60, 1, -140)
inputY.AnchorPoint = Vector2.new(0, 1)
inputY.Text = "Y"
inputY.PlaceholderText = "Y"
inputY.TextSize = 10
inputY.TextColor3 = Color3.fromRGB(255, 255, 255)
inputY.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local inputZ = Instance.new("TextBox")
inputZ.Parent = ScreenGui
inputZ.Size = UDim2.new(0, 50, 0, 30)
inputZ.Position = UDim2.new(0, 110, 1, -140)
inputZ.AnchorPoint = Vector2.new(0, 1)
inputZ.Text = "Z"
inputZ.PlaceholderText = "Z"
inputZ.TextSize = 10
inputZ.TextColor3 = Color3.fromRGB(255, 255, 255)
inputZ.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local function modTug()
    local trucksFolder = workspace:FindFirstChild("Trucks")
    if trucksFolder then
        local tugCount = 0
        local sizeX = tonumber(inputX.Text) or 40
        local sizeY = tonumber(inputY.Text) or 20
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
                            part.Color = Color3.fromRGB(240, 120, 240)
                            part.Material = Enum.Material.Neon
                            part.Size = Vector3.new(sizeX, sizeY, sizeZ)
                            part.Transparency = 0.8
                            for _, child in pairs(part:GetChildren()) do
                                if child.Name == "Mesh" then
                                    child:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end
        print(tugCount .. " Tugs modificados. ✅")
    else
        print("Pasta 'Trucks' não encontrada. ❌")
    end
end

button2.MouseButton1Click:Connect(modTug)
