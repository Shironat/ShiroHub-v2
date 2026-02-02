print("Logs.lua carregando")

return function(Tab)
    print("Logs inicializada")

    -- Se precisar de lógica externa
    -- local Logic = loadstring(game:HttpGet("LINK_DA_LOGICA.lua"))()

    Tab:CreateButton({
        Name = "Exemplo Botão2",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateToggle({
        Name = "Exemplo Toggle2",
        Callback = function(state)
            print("Toggle:", state)
        end
    })
end