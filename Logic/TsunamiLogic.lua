-- Serviços
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Base do jogador
local Bases = workspace:WaitForChild("Bases")
local MinhaBase = nil

-- Função para encontrar a base
local function ResolverMinhaBase()
    for _, base in ipairs(Bases:GetChildren()) do
        if base:IsA("Model") then
            local PlayerName = base:FindFirstChild("PlayerName", true)
            if PlayerName and PlayerName:IsA("TextLabel") and 
               (PlayerName.Text == LocalPlayer.Name or PlayerName.Text == LocalPlayer.DisplayName) then
                MinhaBase = base
                return true
            end
        end
    end
    return false
end

-- Função utilitária para invokes que **precisam de base**
local function InvokeWithBase(actionName, param)
    if not MinhaBase then
        if not ResolverMinhaBase() then
            warn("[InvokeWithBase]: Base não encontrada!")
            return
        end
    end

    local args = { actionName, MinhaBase.Name, param }
    task.spawn(function()
        pcall(function()
            ReplicatedStorage:WaitForChild("Packages")
                :WaitForChild("Net")
                :WaitForChild("RF/Plot.PlotAction")
                :InvokeServer(unpack(args))
        end)
    end)
end

-- Função utilitária para invokes **sem base**
local function InvokeNoBase(remoteName, ...)
    task.spawn(function()
        pcall(function()
            ReplicatedStorage:WaitForChild("RemoteFunctions")
                :WaitForChild(remoteName)
                :InvokeServer(...)
        end)
    end)
end

-- === Exemplo de callbacks Rayfield ===
-- Toggle para upgrade automático usando Dropdown
local UpgradeOptions = {"Brainrot", "Strength", "Defense"}
local SelectedUpgrade = UpgradeOptions[1]

Tab:CreateDropdown({
    Name = "Selecionar Upgrade",
    Options = UpgradeOptions,
    CurrentOption = SelectedUpgrade,
    Callback = function(option)
        SelectedUpgrade = option
    end
})

Tab:CreateButton({
    Name = "Upgrade Base",
    Callback = function()
        InvokeWithBase("Upgrade Brainrot", SelectedUpgrade)
    end
})

-- Botão Rebirth (não precisa de base)
Tab:CreateButton({
    Name = "Rebirth",
    Callback = function()
        InvokeNoBase("Rebirth")
    end
})

-- Botão UpgradeSpeed (não precisa de base)
Tab:CreateButton({
    Name = "Upgrade Speed",
    Callback = function()
        InvokeNoBase("UpgradeSpeed", 1)
    end
})