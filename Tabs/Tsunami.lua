return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

    local selectedSlot = nil
    local brainrots = {}
    local BrainrotDropdown = nil

        Tab:CreateButton({
            Name = "Reset Base",
            Callback = function()
                Logic.ResetBase()
                RefreshBrainrotDropdown()
            end
        })

        RefreshBrainrotDropdown()

        Tab:CreateToggle({
            Name = "Auto Collect",
            Callback = Logic.ToggleMoney
        })

        Tab:CreateToggle({
            Name = "Auto Event Coins",
            Callback = Logic.ToggleMoney
        })

        brainrots = Logic.GetBrainrots()
        selectedSlot = nil

        local options = {}
        for _, b in ipairs(brainrots) do
            table.insert(options, b.Name)
        end

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
end