print("CHAMANDO RAYFIELD")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({ Name = "ShiroHub v2" })

print("Carregando Tabs...")
local Tabs = {}

Tabs.Exploits = Window:CreateTab("Exploits")
Tabs.Inject   = Window:CreateTab("Injection")
Tabs.Logs     = Window:CreateTab("Logs")

print("Tabs Carregadas")

print("Exploits...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua"))()(Tabs.Exploits)
print("[OK]")
print("Inject...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua"))()(Tabs.Inject)
print("[OK]")
print("Logs")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Logs.lua"))()(Tabs.Logs)
print("Módulos carregados")