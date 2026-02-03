return function(Tab)

    local Dex = false,
    local Spy = false,
    local Ket = false,
    local Inf = false

    -- Dex
    Tab:CreateButton({
        Name = "Dex Explorer",
        Callback = function()
            if Dex then return end
            loaded = true
            loadstring(game:HttpGet("https://nescoroco.lat/NDexV01.txt"))()
        end
    })

    -- Ketamine
    Tab:CreateButton({
        Name = "KetamineSpy",
        Callback = function()
            if Ket then return end
            loaded = true
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))()
       end
    })

    -- SimpleSpy
    Tab:CreateButton({
        Name = "SimpleSpy",
        Callback = function()
            if Spy then return end
            loaded = true
                    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
        end
    })

    -- Infinite Yield
    Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            if Inf then return end
            loaded = true
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })

    -- Custom script
    Tab:CreateInput({
        Name = "Custom script here...",
        Callback = function()
        end
    })
end