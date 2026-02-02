local S = loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Shared/Services.lua"))()
local Players = S.Players
local TeleportService = S.TeleportService

local Utils = {}

function Utils.Character(player)
    return player.Character or player.CharacterAdded:Wait()
end

function Utils.Humanoid(player)
    return Utils.Character(player):WaitForChild("Humanoid")
end

function Utils.HRP(player)
    return Utils.Character(player):WaitForChild("HumanoidRootPart")
end

function Utils.ForceReset(player)
    local hum = Utils.Humanoid(player)
    hum.Health = 0
end

function Utils.Rejoin(player)
    TeleportService:Teleport(game.PlaceId, player)
end

return Utils