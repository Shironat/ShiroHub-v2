return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

    Tab:CreateButton({
        Name = "Reset Base",
        Callback = function(_)
           if Logic and Logic.ResetBase then
               pcall(Logic.ResetBase)
           else
               warn("Logic.ResetBase = nil")
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
              warn("Logic.ToggleMoney = nil")
           end
        end
    })

    Tab:CreateToggle({
        Name = "Auto Event Coins",
        Callback = function(enabled)
           pcall(function()
               Logic.ToggleMoney(enabled)
           end)
        end,
    })

    local selectedSlot = nil
    local options = {}
    local brainrots = Logic.GetBrainrots()
    for _, v in ipairs(brainrots) do
        table.insert(options, v.Name .. " | slot " .. v.Slot)
    end
    if #options > 0 then selectedSlot = brainrots[1].Slot end

    Tab:CreateDropdown({
        Name = "Selecionar Brainrot",
        Options = options,
        CurrentOption = options[1],
        Callback = function(option)
            local slot = tonumber(option:match("slot (%d+)"))
            selectedSlot = slot
        end
    })

    Tab:CreateToggle({
        Name = "Auto Upgrade Brainrot",
        Callback = function(state)
            if selectedSlot then
                Logic.ToggleUpgrade(state, selectedSlot)
            else
                warn("[Tsunami Tab] Nenhum slot selecionado!")
            end
        end
    })
end