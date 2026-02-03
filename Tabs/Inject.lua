return function(Tab)
    if not Tab then
        warn("Inject.lua: Tab é nil!")
        return
    end

    -- Variáveis locais
    local Dex = false
    local Spy = false
    local Ket = false
    local Inf = false
    local loaded = false

    -- Dex Explorer
    Tab:CreateButton({
        Name = "Dex Explorer",
        Callback = function()
            if Dex then return end
            loaded = true
            loadstring(game:HttpGet("https://nescoroco.lat/NDexV01.txt"))()
            Dex = true
        end
    })

    -- KetamineSpy
    Tab:CreateButton({
        Name = "KetamineSpy",
        Callback = function()
            if Ket then return end
            loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))()
            Ket = true
        end
    })

    -- SimpleSpy
    Tab:CreateButton({
        Name = "SimpleSpy",
        Callback = function()
            if Spy then return end
            loaded = true
            loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
            Spy = true
        end
    })

    -- Infinite Yield
    Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            if Inf then return end
            loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            Inf = true
        end
    })

    -- Custom script
    Tab:CreateInput({
        Name = "Custom script here...",
        PlaceholderText = "Cole seu código aqui",
        RemoveTextAfterFocusLost = false,
        Callback = function(inputText)
            if inputText and inputText ~= "" then
                local func, err = loadstring(inputText)
                if not func then
                    warn("Erro de sintaxe no script custom: "..tostring(err))
                    return
                end
                local success, runtimeErr = pcall(func)
                if not success then
                    warn("Erro ao executar script custom: "..tostring(runtimeErr))
                end
            end
        end
    })
end