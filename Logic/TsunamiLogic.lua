local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

local Remote = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("Net")
    :WaitForChild("RF/Plot.PlotAction")


local Bases = workspace:WaitForChild("Bases")

--Criar Lógica
local TsunamiLogic = {}

-- Estados internos
local MoneyEnabled = false
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

local EventCoinEnabled = false
local isTweening = false
local CHECK_INTERVAL = 2
local TWEEN_DURATION = 0.12

local function tweenToPosition(targetPos)
    if isTweening then return end
    isTweening = true

    local tweenInfo = TweenInfo.new(
        TWEEN_DURATION,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        0,
        false,
        0
    )

    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
    tween.Completed:Connect(function()
        isTweening = false
    end)
end

-- Função principal do auto-collector
local function collectCoins()
    local targets = {}

    local ufoParts = workspace:FindFirstChild("UFOEventParts")
    if ufoParts then
        for _, obj in ipairs(ufoParts:GetChildren()) do
            if obj:IsA("BasePart") then
                table.insert(targets, obj)
            end
        end
    end

    local goldParts = workspace:FindFirstChild("MoneyEventParts")
    if goldParts and goldParts:FindFirstChild("GoldBar") then
        local goldMain = goldParts.GoldBar:FindFirstChild("Main")
        if goldMain and goldMain:IsA("BasePart") then
            table.insert(targets, goldMain)
        end
    end

    for _, target in ipairs(targets) do
        tweenToPosition(target.Position)
        task.wait(TWEEN_DURATION + 0.05)
    end
end

RunService.RenderStepped:Connect(function(dt)
    if not AutoCollectEnabled then return end
    -- Checagem a cada CHECK_INTERVAL
    if not TsunamiLogic._lastCheck then TsunamiLogic._lastCheck = 0 end
    TsunamiLogic._lastCheck += dt
    if TsunamiLogic._lastCheck < CHECK_INTERVAL then return end
    TsunamiLogic._lastCheck = 0

    collectCoins()
end)


return TsunamiLogic