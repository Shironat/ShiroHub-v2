local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local Remote = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("Net")
    :WaitForChild("RF/Plot.PlotAction")


local Bases = workspace:WaitForChild("Bases")

--Criar Lógica
local TsunamiLogic = {}

-- Estados internos
local Ativo = false
local MinhaBase = nil
local valorAtual = 1
local VALOR_MAX = 10
local intervalo = 0.4
local acumulador = 0

local function BuscarMinhaBase()
    for _, base in ipairs(Bases:GetChildren()) do
        if base:IsA("Model") then
            local PlayerName = base:FindFirstChild("PlayerName", true)

            if PlayerName
                and PlayerName:IsA("TextLabel")
                and (
                    PlayerName.Text == LocalPlayer.Name
                    or PlayerName.Text == LocalPlayer.DisplayName
                ) then

                MinhaBase = base
                print("Base:", MinhaBase.Name)
                return true
            end
        end
    end
    return false
end

local function ResolverBase()
    for tentativa = 1, 10 do
        if BuscarMinhaBase() then
            return true
        end
        task.wait(0.5)
    end

    warn("Base nao encontrada")
    return false
end

RunService.Heartbeat:Connect(function(dt)
    if not Ativo then return end
    if not MinhaBase then return end

    acumulador += dt
    if acumulador < intervalo then return end
    acumulador = 0

    local valor = tostring(valorAtual)

    task.spawn(function()
        pcall(function()
            Remote:InvokeServer(
                "Collect Money",
                MinhaBase.Name,
                valor
            )
        end)
    end)

    valorAtual += 1
    if valorAtual > VALOR_MAX then
        valorAtual = 1
    end
end)

function TsunamiLogic.ToggleMoney(state)
    Ativo = state

    if state then
        if not MinhaBase then
            ResolverBase()
        end
    else
    end
end

function TsunamiLogic.ResetBase()
    MinhaBase = nil
    ResolverBase()
end

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local DANGER_DISTANCE = 80
local CHECK_INTERVAL = 0.1
local TELEPORT_HEIGHT_OFFSET = 3
local TWEEN_DURATION = 0.15
local SAFE_ZONE_DISTANCE = 15
local isTweening = false
local lastCheck = 0
local renderConn = nil

local function getSafeGaps()
    local gaps = {}
    if not workspace:FindFirstChild("Misc") or not workspace.Misc:FindFirstChild("Gaps") then
        return gaps
    end
    for _, gap in pairs(workspace.Misc.Gaps:GetChildren()) do
        for _, child in pairs(gap:GetChildren()) do
            if child:IsA("BasePart") then
                table.insert(gaps, {
                    name = gap.Name,
                    part = child,
                    position = child.Position
                })
                break
            end
        end
    end
    return gaps
end

local function isInSafeZone()
    local gaps = getSafeGaps()
    local playerPos = humanoidRootPart.Position
    for _, gap in pairs(gaps) do
        if (gap.position - playerPos).Magnitude <= SAFE_ZONE_DISTANCE then
            return true, gap.name
        end
    end
    return false
end

local function fastTweenToSafety(targetPart)
    if isTweening then return end
    isTweening = true

    local targetPos = targetPart.Position + Vector3.new(0, TELEPORT_HEIGHT_OFFSET, 0)
    local tweenInfo = TweenInfo.new(TWEEN_DURATION, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetPos)})

    tween:Play()
    tween.Completed:Connect(function()
        isTweening = false
    end)
end

local function findBestGap()
    local gaps = getSafeGaps()
    if #gaps == 0 then return nil end

    local playerPosition = humanoidRootPart.Position
    local playerLookVector = humanoidRootPart.CFrame.LookVector

    local closestBehind = nil
    local closestBehindDist = math.huge

    for _, gap in pairs(gaps) do
        local directionToGap = (gap.position - playerPosition).Unit
        local dotProduct = playerLookVector:Dot(directionToGap)
        if dotProduct < 0 then
            local distance = (gap.position - playerPosition).Magnitude
            if distance < closestBehindDist then
                closestBehindDist = distance
                closestBehind = gap
            end
        end
    end

    if closestBehind then return closestBehind end

    local closest = gaps[1]
    local closestDist = (closest.position - playerPosition).Magnitude
    for i = 2, #gaps do
        local dist = (gaps[i].position - playerPosition).Magnitude
        if dist < closestDist then
            closest = gaps[i]
            closestDist = dist
        end
    end
    return closest
end

local function getActiveWaveHitboxes()
    local hitboxes = {}
    local activeTsunamis = workspace:FindFirstChild("ActiveTsunamis")
    if activeTsunamis then
        for _, tsunami in pairs(activeTsunamis:GetChildren()) do
            local hitbox = tsunami:FindFirstChild("Hitbox")
            if hitbox and hitbox:IsA("BasePart") then
                table.insert(hitboxes, {name = tsunami.Name, hitbox = hitbox})
            end
        end
    end
    return hitboxes
end

function TsunamiLogic.TsunamiEvade(enabled)
    if renderConn then
        renderConn:Disconnect()
        renderConn = nil
    end

    if enabled then
        renderConn = RunService.RenderStepped:Connect(function()
            local currentTime = tick()
            if currentTime - lastCheck < CHECK_INTERVAL then return end
            lastCheck = currentTime

            if not character or not character.Parent then
                character = LocalPlayer.Character
                if character then
                    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                else
                    return
                end
            end

            if isTweening then return end
            local inSafe, _ = isInSafeZone()
            if inSafe then return end

            local waves = getActiveWaveHitboxes()
            for _, wave in pairs(waves) do
                if (wave.hitbox.Position - humanoidRootPart.Position).Magnitude <= DANGER_DISTANCE then
                    local safeGap = findBestGap()
                    if safeGap then
                        fastTweenToSafety(safeGap.part)
                    else
                        warn("NO SAFE GAPS FOUND!")
                    end
                    break
                end
            end
        end)
    end
end

return TsunamiLogic