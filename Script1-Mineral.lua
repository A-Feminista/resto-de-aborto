local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local mineralPriority = {
    "Plutonium", "Uranium", "Emerald", "Mercury", "Jade", "Obsidian",
    "Sapphire", "Diamond", "Iridium", "Lithium", "Limestone", "Cobalt",
    "Quartz", "Gold", "Ruby", "Titanium", "Coal", "Silver",
    "Aluminium", "Copper", "Bronze", "Nickel", "Iron"
}

local mineralList = {}
for _, mineral in ipairs(mineralPriority) do
    mineralList[mineral] = true
end

local function createButton(text, position, btnFunction)
    local button = Instance.new("TextButton")
    button.Parent = ScreenGui
    button.Text = text
    button.TextSize = 10
    button.TextColor3 = Color3.new(0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(220, 160, 220)
    button.Size = UDim2.new(0, 150, 0, 50)
    button.Position = position
    button.MouseButton1Click:Connect(btnFunction)
end

local function printMinerals()
    local mineralsFolder = workspace:FindFirstChild("Minerals")
    if not mineralsFolder then
        return
    end
    local minerals = {}
    local unknownMinerals = {}
    for _, mineral in ipairs(mineralsFolder:GetChildren()) do
        if mineral:IsA("BasePart") then
            local countTable = mineralList[mineral.Name] and minerals or unknownMinerals
            countTable[mineral.Name] = (countTable[mineral.Name] or 0) + 1
        end
    end
    print("Minerals found: 📜")
    for _, mineral in ipairs(mineralPriority) do
        if minerals[mineral] then
            print(minerals[mineral] .. "x " .. mineral)
        end
    end
    if next(unknownMinerals) then
        print("Unknown minerals found: 📜")
        for unknowMineral, count in pairs(unknownMinerals) do
            print(count .. "x " .. unknowMineral)
        end
    end
end

local function teleportMineral(reversePriority)
    local mineralsFolder = workspace:FindFirstChild("Minerals")
    if not mineralsFolder then
        return
    end
    local start = reversePriority and #mineralPriority or 1
    local stop = reversePriority and 1 or #mineralPriority
    local step = reversePriority and -1 or 1
    for i = start, stop, step do
        local mineralName = mineralPriority[i]
        for _, mineralPart in ipairs(mineralsFolder:GetChildren()) do
            if mineralPart.Name == mineralName and not mineralPart:FindFirstChild("BillboardGui") then
                mineralPart.CFrame = workspace.CurrentCamera.CFrame

                local billboardGui = Instance.new("BillboardGui", mineralPart)
                billboardGui.Size = UDim2.new(3, 0, 1, 0)
                billboardGui.StudsOffset = Vector3.new(0, 3, 0)
                billboardGui.AlwaysOnTop = true

                local textLabel = Instance.new("TextLabel", billboardGui)
                textLabel.Text = mineralName
                textLabel.TextSize = 20
                textLabel.TextColor3 = mineralPart.BrickColor.Color
                textLabel.TextStrokeTransparency = 0
                textLabel.BackgroundTransparency = 1
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.Size = UDim2.new(1, 0, 1, 0)

                task.delay(300, function()
                    if billboardGui and billboardGui.Parent then billboardGui:Destroy() end
                end)
                return
            end
        end
    end
end

createButton("Print Minerals", UDim2.new(0, 10, 0, 5), printMinerals)
createButton("Teleport Best", UDim2.new(0, 10, 0, 60), function() teleportMineral(false) end)
createButton("Teleport Worst", UDim2.new(0, 10, 0, 110), function() teleportMineral(true) end)
