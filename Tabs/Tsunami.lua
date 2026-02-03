return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

    Tab:CreateButton({
        Name = "Reset Base",
        Callback = function(enabled)
        pcall(function()
            Logic.ResetBase()
        end)
    })

    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = function(enabled)
        pcall(function()
            Logic.ToggleMoney(enabled)
        end)
    })
end