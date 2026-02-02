print("CHAMANDO RAYFIELD")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({ Name = "ShiroHub v2" })

print("Carregando Tabs...")
local Tabs = {}

Tabs.Exploits = Rayfield:CreateTab("Exploits")
Tabs.Inject   = Rayfield:CreateTab("Injection")
Tabs.Logs     = Rayfield:CreateTab("Logs")

print("Tabs Carregadas")

print("Carregando Módulos...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua"))()(Tabs.Exploits)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua"))()(Tabs.Inject)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Logs.lua"))()(Tabs.Logs)
print("Módulos carregados")