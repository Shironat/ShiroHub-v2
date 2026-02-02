print("Carregando ShiroHub...")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
print("RAYFIELD: 200[OK]")

local Window = Rayfield:CreateWindow({ Name = "ShiroHub v2" })

print("Carregando Tabs...")
local Tabs = {}

Tabs.Exploits = Window:CreateTab("Exploits")
Tabs.Inject   = Window:CreateTab("Injection")
Tabs.Logs     = Window:CreateTab("Logs")
Tabs.Tsunami  = Window:CreateTab("Tsunami")

print("Carregadando módulos...")

loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua"))()(Tabs.Exploits)
print("EXPLOITS: 200[OK]")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua"))()(Tabs.Inject)
print("INJECT: 200[OK]")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Logs.lua"))()(Tabs.Logs)
print("LOGS: 200[OK]")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Tsunami.lua"))()(Tabs.Tsunami)
print("TSUNAMI: 200[OK]")

print("ShiroHub carregado!")