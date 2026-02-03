print("Carregando ShiroHub...")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
print("RAYFIELD: 200[OK]")

local Window = Rayfield:CreateWindow({
    Name = "ShiroHub v2",
    LoadingTitle = "Carregando...",
    LoadingSubtitle = "by Shiro",
    ShowText = "ShiroHub"
})

print("Carregando Tabs...")
local Tabs = {}

-- Cria as tabs
local function safeCreateTab(name)
    local ok, tab = pcall(function()
        return Window:CreateTab(name)
    end)
    if not ok or not tab then
        warn("Falha ao criar a Tab "..name)
        return {}
    end
    return tab
end

Tabs.Exploits = safeCreateTab("Exploits")
Tabs.Inject   = safeCreateTab("Injection")
Tabs.Tsunami  = safeCreateTab("Tsunami")

print("Carregando módulos...")

local function safeLoadModule(url, tab, moduleName)
    local ok, err = pcall(function()
        local moduleFunc, loadErr = loadstring(game:HttpGet(url))
        if moduleFunc then
            -- Isola execução do módulo em outro pcall
            pcall(moduleFunc, tab)
        else
            warn(moduleName.." falhou ao compilar: "..tostring(loadErr))
        end
    end)
    if ok then
        print(moduleName..": 200[OK]")
    else
        warn("Erro ao executar "..moduleName..": "..tostring(err))
    end
end

-- Carrega cada módulo com isolamento completo
safeLoadModule("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Exploits.lua", Tabs.Exploits, "EXPLOITS")
safeLoadModule("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Inject.lua", Tabs.Inject, "INJECT")
safeLoadModule("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Tabs/Tsunami.lua", Tabs.Tsunami, "TSUNAMI")

print("ShiroHub carregado!")