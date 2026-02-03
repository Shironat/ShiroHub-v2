return function(Tab)

    Tab:CreateButton({
        Name = "DexExplorer",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateButton({
        Name = "KetamineSpy",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateButton({
        Name = "SimpleSpy",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            print("Botão clicado")
        end
    })

    Tab:CreateInput({
        Name = "Custom script here...",
        Callback = function()
            print("Botão clicado")
        end
    })
end