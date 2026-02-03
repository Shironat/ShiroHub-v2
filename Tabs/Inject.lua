local Dex = false
local Spy = false
local Ket = false
local Inf = false
local loaded = false

return function(Tab)
    -- Segurança: verifica se o Tab é válido
    if not Tab or type(Tab.CreateButton) ~= "function" or type(Tab.CreateInput) ~= "function" then
        warn("Inject.lua: Tab inválido ou métodos ausentes!")
        return
    end

    local function safeLoadScript(url, name)
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("Erro ao executar "..name..": "..tostring(err))
        end
    end

    local scripts = {
        {Name = "Dex Explorer", URL = "https://nescoroco.lat/NDexV01.txt", Flag = "Dex"},
        {Name = "KetamineSpy", URL = "https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua", Flag = "Ket"},
        {Name = "SimpleSpy", URL = "https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua", Flag = "Spy"},
        {Name = "Infinite Yield", URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", Flag = "Inf"},
    }

    for _, scriptData in ipairs(scripts) do
        local flagName = scriptData.Flag
        Tab:CreateButton({
            Name = scriptData.Name,
            Callback = function()
                -- Verifica se já foi carregado
                if _G[flagName] then return end
                loaded = true
                safeLoadScript(scriptData.URL, scriptData.Name)
                _G[flagName] = true
            end
        })
    end

    -- Botão Input custom
    Tab:CreateInput({
        Name = "Custom script here...",
        PlaceholderText = "Cole seu código aqui",
        RemoveTextAfterFocusLost = false,
        Callback = function(inputText)
            if inputText and inputText ~= "" then
                -- Primeiro tenta compilar
                local func, err = loadstring(inputText)
                if not func then
                    warn("Erro de sintaxe no script custom: "..tostring(err))
                    return
                end
                -- Executa com segurança
                local success, runtimeErr = pcall(func)
                if not success then
                    warn("Erro ao executar script custom: "..tostring(runtimeErr))
                end
            end
        end
    })
end