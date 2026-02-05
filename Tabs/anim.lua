return function(Tab)

local Logic = loadstring(game:HttpGet("https://githubraw.com/ShiroNat/ShiroHub-v2/main/GapLogic.lua"))()

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