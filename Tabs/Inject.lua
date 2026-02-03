return function(Tab)

    Dex = false,
    Spy = false,
    Ket = false,
    Inf = false

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
            loadstring(game:HttpGet("https://nescoroco.lat/NDexV01.txt"))()
    end
    })

    -- SimpleSpy
    Tab:CreateButton({
        Name = "SimpleSpy",
        Callback = function()
            if Spy then return end
            loaded = true
            loadstring(game:HttpGet("https://nescoroco.lat/NDexV01.txt"))()
    end
    })

    -- Infinite Yield
    Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            if Inf then return end
            loaded = true
            loadstring(game:HttpGet("https://nescoroco.lat/NDexV01.txt"))()
    end
    })

    -- Custom script
    Tab:CreateInput({
        Name = "Custom script here...",
        Callback = function()
        end
    })
end