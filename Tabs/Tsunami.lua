return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

Tab:CreateToggle({
    Name = "Reset Base",
    Callback = function(_)
        -- O underscore ignora qualquer argumento passado pelo toggle
        if Logic and Logic.ResetBase then
            pcall(Logic.ResetBase)
        else
            warn("Logic.ResetBase não existe!")
        end
    end
})

Tab:CreateToggle({
    Name = "Auto Collect",
    Callback = function(enabled)
        if Logic and Logic.ToggleMoney then
            pcall(function()
                Logic.ToggleMoney(enabled)
            end)
        else
            warn("Logic.ToggleMoney não existe!")
        end
    end
})
end