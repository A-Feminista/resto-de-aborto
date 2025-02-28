local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mineralPriority = {
    "Plutonium", "Uranium", "Emerald", "Mercury", "Jade", "Obsidian",
    "Sapphire", "Diamond", "Iridium", "Lithium", "Limestone", "Cobalt",
    "Quartz", "Gold", "Ruby", "Titanium", "Coal", "Silver",
    "Aluminium", "Copper", "Bronze", "Nickel", "Iron"
}

local button = Instance.new("TextButton")
button.Parent = ScreenGui
button.Text = "Checar Minerais"
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0, 10, 0, 0)
button.TextSize = 10
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

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

button.MouseButton1Click:Connect(checkMinerals)
