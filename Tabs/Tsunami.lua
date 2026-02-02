return function(Tab)

    -- local Logic = loadstring(game:HttpGet("LINK_DA_LOGICA.lua"))()

    Tab:CreateButton({
        Name = "Exemplo Botão3",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateToggle({
        Name = "Exemplo Toggle3",
        Callback = function(state)
            print("Toggle:", state)
        end
    })
end