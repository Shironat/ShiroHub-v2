-- TsunamiGapLogic.lua

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
    Gap1="Common", Gap2="Uncommon", Gap3="Rare", Gap4="Epic",
    Gap5="Legendary", Gap6="Mythical", Gap7="Cosmic",
    Gap8="Secret", Gap9="Celestial"
}

print("[Logic] TsunamiGapLogic carregado")

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart")
end

-- GAP atual (via Mud)
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

-- SECTION atual
local function getCurrentSection()
    local hrp = getHRP()
    for _, section in ipairs(SectionFolder:GetChildren()) do
        if section:IsA("BasePart") then
            if (hrp.Position - section.Position).Magnitude <= (section.Size.Magnitude / 2) then
                return section
            end
        end
    end
end

-- Tsunami na Section?
local function sectionHasTsunami(section)
    for _, tsunami in ipairs(TsunamiFolder:GetChildren()) do
        if tsunami:IsA("Model") then
            local cf, _ = tsunami:GetBoundingBox()
            if (cf.Position - section.Position).Magnitude <= (section.Size.Magnitude / 2) then
                return true
            end
        end
    end
    return false
end

-- Próximo Gap
local function getNextGap(currentGap)
    for i, name in ipairs(GAP_ORDER) do
        if currentGap.Name == name then
            return GapsFolder:FindFirstChild(GAP_ORDER[i + 1])
        end
    end
end

-- Teleporte seguro
local function teleportToGap(gap)
    local hrp = getHRP()
    local mud = gap:FindFirstChild("Mud")
    if not mud then return end

    hrp.CFrame = CFrame.new(
        mud.Position.X,
        mud.Position.Y + 5,
        mud.Position.Z
    )

    print("[TP]", gap.Name, "-", GAP_NAMES[gap.Name])
end

-- ===== LOOP PRINCIPAL =====

local running = false
local lastGapProcessed = nil

local function start()
    if running then return end
    running = true
    lastGapProcessed = nil

    task.spawn(function()
        while running do
            task.wait(0.5)

            local currentGap = getCurrentGap()
            if not currentGap then continue end

            -- 🔒 BLOQUEIO DE LOOP
            if lastGapProcessed == currentGap then
                continue
            end

            local section = getCurrentSection()
            if not section then continue end

            if sectionHasTsunami(section) then
                print("[BLOCK] Tsunami na Section:", section.Name)
                continue
            end

            local nextGap = getNextGap(currentGap)
            if nextGap then
                teleportToGap(nextGap)
                lastGapProcessed = currentGap
            end
        end
    end)
end

local function stop()
    running = false
    lastGapProcessed = nil
end

return {
    Start = start,
    Stop = stop
}