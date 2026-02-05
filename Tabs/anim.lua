return function(Tab)

    local Logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/AnimLogic.lua"))()

    Tab:CreateToggle({
        Name = "Auto TP",
        CurrentValue = false,
        Callback = function(state)
            if state then
                Logic.Start()
            else
                Logic.Stop()
            end
        end
})
end