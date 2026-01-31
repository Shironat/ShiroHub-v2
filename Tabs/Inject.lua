local State = require(script.Parent.Parent.Shared.State)

local Inject = {}

function Inject.Init(Window, Tab)
    Tab:CreateButton({
        Name = "Infinite Yield",
        Callback = function()
            if State.Loaded.Inf then return end
            State.Loaded.Inf = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end
    })
end

return Inject