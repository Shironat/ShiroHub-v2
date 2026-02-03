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
        PlaceholderText = "Cole seu código aqui",
        RemoveTextAfterFocusLost = false,
        Callback = function(inputText)
            if inputText and inputText ~= "" then
                local success, err = pcall(function()
                    loadstring(inputText)()
                end)
                if not success then
                    warn("Erro ao executar script custom: "..tostring(err))
                end
            end
        end
    })
end