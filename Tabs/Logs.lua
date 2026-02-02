return function(Tab)
    local Logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/LogsLogic.lua"))()
    
    Logic.CreateTerminal(Tab)
    
    Logic.PrintLine("ShiroHub Logs iniciado!")
end