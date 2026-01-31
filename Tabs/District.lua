local S = require(script.Parent.Parent.Shared.Services)
local State = require(script.Parent.Parent.Shared.State)

local District = {}

function District.Init(Window, Tab)
    Tab:CreateToggle({
        Name = "Ataque - District",
        Callback = function(v)
            State.Attacking = v
            if v then
                task.spawn(function()
                    while State.Attacking do
                        S.ReplicatedStorage.Remotes.Attacks.BasicAttack:FireServer()
                        task.wait()
                    end
                end)
            end
        end
    })
end

return District