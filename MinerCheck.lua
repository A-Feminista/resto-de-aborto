local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mineralPriority = {
    "Uranium", "Plutonium", "Emerald", "Sapphire", "Quartz", "Diamond",
    "Iridium", "Obsidian", "Mercury", "Jade", "Lithium", "Cobalt",
    "Gold", "Ruby", "Titanium", "Silver", "Aluminium", "Coal",
    "Limestone", "Copper", "Bronze", "Nickel", "Iron"
}

local button1 = Instance.new("TextButton")
button1.Parent = ScreenGui
button1.Text = "Checar Minerais T"
button1.Size = UDim2.new(0, 150, 0, 50)
button1.Position = UDim2.new(0, 5, 0, 0)
button1.TextSize = 10
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local function checkMinerals()
    local mineralsFolder = workspace:FindFirstChild("Minerals")
    if mineralsFolder then
        local mineralsCount = {}
        local unknowMinerals = {}
        for _, Mineral in pairs(mineralsFolder:GetChildren()) do
            if Mineral:IsA("BasePart") then
                if table.find(mineralPriority, Mineral.Name) then
                    if mineralsCount[Mineral.Name] then
                        mineralsCount[Mineral.Name] = mineralsCount[Mineral.Name] + 1
                    else
                        mineralsCount[Mineral.Name] = 1
                    end
                else
                    if unknowMinerals[Mineral.Name] then
                        unknowMinerals[Mineral.Name] = unknowMinerals[Mineral.Name] + 1
                    else
                        unknowMinerals[Mineral.Name] = 1
                    end
                end
            end
        end
        print("Minerais encontrados: 📜")
        for _, mineral in ipairs(mineralPriority) do
            if mineralsCount[mineral] then
                print(mineralsCount[mineral] .. "x " .. mineral)
            end
        end
        if next(unknowMinerals) ~= nil then
            print("Minerais desconhecidos encontrados: 📜")
            for unknowMineral, count in pairs(unknowMinerals) do
                print(count .. "x " .. unknowMineral)
            end
        end
    else
        print("Pasta 'Minerals' não encontrada. ❌")
    end
end

button1.MouseButton1Click:Connect(checkMinerals)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        checkMinerals()
    end
end)
