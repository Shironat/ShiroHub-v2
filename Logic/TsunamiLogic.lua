local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local Remote = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("Net")
    :WaitForChild("RF/Plot.PlotAction")


local Bases = workspace:WaitForChild("Bases")

--Criar Lógica, coletar dinheir
local TsunamiLogic = {}

-- Estados internos
local Ativo = false
local MinhaBase = nil
local valorAtual = 1
local VALOR_MAX = 10
local intervalo = 0.1
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

return TsunamiLogic