local Players = game:GetService("Players")
local player = Players.LocalPlayer

local TsunamiFolder = workspace:WaitForChild("ActiveTsunamis")
local SectionFolder = workspace:WaitForChild("SectionsHitbox")
local GapsFolder = workspace:WaitForChild("DefaultMap_SharedInstances"):WaitForChild("Gaps")

local GAP_ORDER = {
    "Gap1","Gap2","Gap3","Gap4","Gap5",
    "Gap6","Gap7","Gap8","Gap9"
}

local GAP_NAMES = {
    Gap1 = "Common",
    Gap2 = "Uncommon",
    Gap3 = "Rare",
    Gap4 = "Epic",
    Gap5 = "Legendary",
    Gap6 = "Mythical",
    Gap7 = "Cosmic",
    Gap8 = "Secret",
    Gap9 = "Celestial"
}

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- Verifica se uma tsunami está dentro de um section
local function sectionHasTsunami(section)
    for _, tsunami in ipairs(TsunamiFolder:GetChildren()) do
        if tsunami:IsA("Model") then
            local cf, size = tsunami:GetBoundingBox()
            if (cf.Position - section.Position).Magnitude <= (section.Size.Magnitude / 2) then
                return true
            end
        end
    end
    return false
end

-- Descobre em qual GAP o jogador está (usando Mud)
local function getCurrentGap()
    local hrp = getHRP()
    for _, gap in ipairs(GapsFolder:GetChildren()) do
        local mud = gap:FindFirstChild("Mud")
        if mud and mud:IsA("BasePart") then
            if (hrp.Position - mud.Position).Magnitude <= (mud.Size.Magnitude / 2) then
                return gap
            end
        end
    end
end

-- Retorna o próximo gap
local function getNextGap(currentGap)
    for i, name in ipairs(GAP_ORDER) do
        if currentGap.Name == name then
            return GapsFolder:FindFirstChild(GAP_ORDER[i + 1])
        end
    end
end

-- Teleporte SEGURO (linha reta, sem soma incremental)
local function teleportToGap(gap)
    local hrp = getHRP()
    local mud = gap:FindFirstChild("Mud")
    if not mud then return end

    local targetPos = Vector3.new(
        mud.Position.X,
        mud.Position.Y + 5,
        mud.Position.Z
    )

    hrp.CFrame = CFrame.new(targetPos)
    print("[TP] Gap:", gap.Name, "-", GAP_NAMES[gap.Name])
end

-- Loop principal
local running = false

local function start()
    running = true
    task.spawn(function()
        while running do
            task.wait(0.5)

            local currentGap = getCurrentGap()
            if not currentGap then continue end

            local section = SectionFolder:FindFirstChild(currentGap.Name)
            if not section then continue end

            if sectionHasTsunami(section) then
                print("[BLOCK] Tsunami no Section:", section.Name)
                continue
            end

            local nextGap = getNextGap(currentGap)
            if nextGap then
                teleportToGap(nextGap)
            end
        end
    end)
end

local function stop()
    running = false
end

return {
    Start = start,
    Stop = stop
}