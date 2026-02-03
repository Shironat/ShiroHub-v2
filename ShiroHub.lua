print("Carregando ShiroHub...")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
print("RAYFIELD: 200[OK]")

local Window = Rayfield:CreateWindow({ Name = "ShiroHub v2", LoadingTitle = "Carregando...", LoadingSubtitle = "by Shiro", ShowText = "ShiroHub"})

print("Carregando Tabs...")
local Tabs = {}

Tabs.Exploits = Window:CreateTab("Exploits")
Tabs.Inject   = Window:CreateTab("Injection")
Tabs.Tsunami  = Window:CreateTab("Tsunami")

assert(Tabs.Tsunami, "Tab Tsunami não existe")
print("Carregadando módulos...")

loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua"))()(Tabs.Exploits)
print("EXPLOITS: 200[OK]")

local ok, e = pcall(function()
    do
    local ok, err = pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua"
        ))()(Tabs.Inject)
    end)

    if not ok then
        warn("INJECT falhou, ignorando erro:")
        warn(err)
    else
        print("INJECT: 200[OK]")
    end
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Tsunami.lua"))()(Tabs.Tsunami)
print("TSUNAMI: 200[OK]")

print("ShiroHub carregado!")