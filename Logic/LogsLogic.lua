local LogsLogic = {}

function LogsLogic.CreateTerminal(Tab)
    local TerminalBox = Tab:CreateTextBox({
        Name = "Console",
        Text = "",
        PlaceholderText = "Logs do ShiroHub...",
        MultiLine = true,
        ClearTextOnFocus = false,
        TextSize = 14,
        TextColor = Color3.fromRGB(255,255,255),
        BackgroundColor = Color3.fromRGB(30,30,30),
        ScrollBarThickness = 6,
        Size = UDim2.new(1, 0, 0.8, 0), -- 80% da aba
        Callback = function(value)
            print("Comando", value)
        end
    })

    function LogsLogic.PrintLine(msg)
        TerminalBox.Text = TerminalBox.Text .. msg .. "\n"
        TerminalBox.CursorPosition = #TerminalBox.Text + 1
    end

    return TerminalBox
end

return LogsLogic