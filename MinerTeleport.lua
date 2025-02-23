local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mineralPriority = {
    "Uranium", "Plutonium", "Emerald", "Sapphire", "Quartz", "Diamond",
    "Iridium", "Obsidian", "Mercury", "Jade", "Lithium", "Cobalt",
    "Gold", "Ruby", "Titanium", "Silver", "Aluminium", "Coal",
    "Limestone", "Copper", "Bronze", "Nickel", "Iron"
}

local function createButton(text, position, callback)
    local buttonTp = Instance.new("TextButton")
    buttonTp.Parent = ScreenGui
    buttonTp.Text = text
    buttonTp.Size = UDim2.new(0, 150, 0, 50)
    buttonTp.Position = position
    buttonTp.TextSize = 10
    buttonTp.TextColor3 = Color3.fromRGB(255, 255, 255)
    buttonTp.BackgroundColor3 = Color3.fromRGB(220, 160, 220)
    buttonTp.MouseButton1Click:Connect(callback)
end

local function teleportMineral(reverse)
    local mineralsFolder = workspace:FindFirstChild("Minerals")
    if not mineralsFolder then
        print("Pasta 'Minerals' não encontrada. ❌")
        return
    end
    local mineralParts = mineralsFolder:GetChildren()
    local start, stop, step = reverse and #mineralPriority or 1, reverse and 1 or #mineralPriority, reverse and -1 or 1
    for i = start, stop, step do
        local mineral = mineralPriority[i]
        for _, mineralPart in pairs(mineralParts) do
            if mineralPart.Name == mineral then
                if not mineralPart:FindFirstChild("Fire") then
                    local camera = game.Workspace.CurrentCamera
                    mineralPart.CFrame = camera.CFrame

                    local fire = Instance.new("Fire")
                    fire.Parent = mineralPart
                    fire.Size = 10
                    fire.Heat = 20
                    fire.Color = Color3.fromRGB(255, 0, 255)
                    fire.SecondaryColor = Color3.fromRGB(255, 200, 255)

                    local billboard = Instance.new("BillboardGui")
                    billboard.Parent = mineralPart
                    billboard.Size = UDim2.new(3, 0, 1, 0)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Name = "MineralLabel"

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboard
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = mineral
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextStrokeTransparency = 0
                    textLabel.TextSize = 20
                    textLabel.Font = Enum.Font.SourceSansBold

                    print(mineral .. " teleportado. ✅")
                    return
                end
            end
        end
    end
end

createButton("Teleportar Bom", UDim2.new(0, 10, 0, 50), function()
    teleportMineral(false)
end)

createButton("Teleportar Ruim", UDim2.new(0, 10, 0, 100), function()
    teleportMineral(true)
end)
