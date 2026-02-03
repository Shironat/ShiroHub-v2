return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

    Tab:CreateToggle({
        Name = "Reset Base",
        Callback = Logic.ResetBase
    })

    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = Logic.ToggleMoney
    })
end