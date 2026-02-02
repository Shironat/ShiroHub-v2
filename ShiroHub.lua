print("CHAMANDO RAYFIELD")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({ Name = "ShiroHub v2" })

print("Carregando Tabs)
local Tabs = {
    Exploits = Window:CreateTab("Exploits"),
    Inject   = Window:CreateTab("Injection"),
    Logs     = Window:CreateTab("Logs"),
}

-- carrega módulos REMOTAMENTE
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua"))()(Tabs.Exploits)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua"))()(Tabs.Inject)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Logs.lua"))()(Tabs.Logs)
print("Módulos carregados")