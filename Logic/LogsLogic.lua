return function(Tab)
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Size = UDim2.new(1, 0, 0.8, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
    ScrollingFrame.ScrollBarThickness = 6
    ScrollingFrame.Parent = Tab:GetContentFrame() -- Adiciona na aba

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ScrollingFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)

    local LogsLogic = {}

    function LogsLogic.PrintLine(msg)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -10, 0, 20)
        Label.BackgroundTransparency = 1
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 14
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Text = msg
        Label.Parent = ScrollingFrame

        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end

    -- Teste
    LogsLogic.PrintLine("ShiroHub Logs iniciado!")
    LogsLogic.PrintLine("Logs vão aparecer aqui...")

    return LogsLogic
end