return function(Tab)
    local Logic = loadstring(game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"))()

    local brainrots = Logic.GetBrainrots()

    print("Logic =", Logic)
    print("GetBrainrots =", Logic and Logic.GetBrainrots)

    local options = {}
    local selectedSlot = nil

    for _, b in ipairs(brainrots) do
        table.insert(options, b.Name)
    end

    Tab:CreateButton({
        Name = "Reset Base",
        Callback = Logic.ResetBase
    })

    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = Logic.ToggleMoney
    })


    Tab: CreateToggle((
        Name Auto Event Coins",
        Callback Logic. ToggleMoney
    })

    Tab:CreateDropdown({
        Name = "Selecionar Brainrot",
        Options = options,
        Callback = function(selected)
            for _, b in ipairs(brainrots) do
                if b.Name == selected then
                    selectedSlot = b.Slot
                    break
                end
            end
        end
    })

    Tab:CreateToggle({
        Name = "Auto Upgrade Brainrot",
        Callback = function(state)
            if selectedSlot then
                Logic.ToggleUpgrade(state, selectedSlot)
            else
                warn("[Tsunami] Nenhum slot selecionado")
            end
        end
    })
end