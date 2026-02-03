return function(Tab)
    local LogsLogic = {}

    local InputBox = Tab:CreateInput({
        Name = "Logs Terminal",
        PlaceholderText = "Logs aparecerão aqui...",
        RemoveTextAfterFocus = false, -- importante para não apagar
        Callback = function() end -- input não precisa de callback
    })

    -- Modifica o InputBox interno para parecer um terminal
    InputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.TextXAlignment = Enum.TextXAlignment.Left
    InputBox.TextYAlignment = Enum.TextYAlignment.Top
    InputBox.ClearTextOnFocus = false
    InputBox.MultiLine = true
    InputBox.TextWrapped = true
    InputBox.Size = UDim2.new(1, 0, 0, 200)

    function LogsLogic.PrintLine(msg)
        InputBox.Text = InputBox.Text .. "\n" .. msg
        -- Rola para o final
        local textBox = InputBox:FindFirstChildWhichIsA("TextBox", true)
        if textBox then
            textBox.CanvasPosition = Vector2.new(0, textBox.TextBounds.Y)
        end
    end

    -- Teste
    LogsLogic.PrintLine("ShiroHub Logs iniciado!")
    LogsLogic.PrintLine("Terminal pronto para receber mensagens...")

    return LogsLogic
end