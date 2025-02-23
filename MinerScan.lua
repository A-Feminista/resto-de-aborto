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
button1.Text = "Checar Minerais"
button1.Size = UDim2.new(0, 150, 0, 50)
button1.Position = UDim2.new(0, 10, 0, 0)
button1.TextSize = 10
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.BackgroundColor3 = Color3.fromRGB(220, 160, 220)

local function checkMinerals()
    local mineralsFolder = workspace:FindFirstChild("Minerals")
    if mineralsFolder then
        local itemsCount = {}
        local unknownItems = {}
        for _, item in pairs(mineralsFolder:GetChildren()) do
            if item:IsA("BasePart") then
                if table.find(mineralPriority, item.Name) then
                    if itemsCount[item.Name] then
                        itemsCount[item.Name] = itemsCount[item.Name] + 1
                    else
                        itemsCount[item.Name] = 1
                    end
                else
                    if unknownItems[item.Name] then
                        unknownItems[item.Name] = unknownItems[item.Name] + 1
                    else
                        unknownItems[item.Name] = 1
                    end
                end
            end
        end
        print("Items encontrados:")
        for _, mineral in ipairs(mineralPriority) do
            if itemsCount[mineral] then
                print(itemsCount[mineral] .. "x " .. mineral)
            end
        end
        if next(unknownItems) ~= nil then
            print("Itens desconhecidos:")
            for unknownItem, count in pairs(unknownItems) do
                print(count .. "x " .. unknownItem)
            end
        end
    else
        print("Pasta 'Minerals' não encontrada. ❌")
    end
end
print("Hi ^-^")
button1.MouseButton1Click:Connect(checkMinerals)
