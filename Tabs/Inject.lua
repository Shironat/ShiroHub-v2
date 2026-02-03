return function(Tab)

    -- Dex
    Tab:CreateButton({
        Name = "Dex Explorer",
        Callback = function()
            if Dex then return end
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