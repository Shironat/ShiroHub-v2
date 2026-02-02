return function(Tab)

    -- local Logic = loadstring(game:HttpGet("LINK_DA_LOGICA.lua"))()

    Tab:CreateButton({
        Name = "Exemplo Botão",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateToggle({
        Name = "Exemplo Toggle",
        Callback = function(state)
            print("Toggle:", state)
        end
    })
end