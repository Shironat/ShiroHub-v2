return function(Tab)
    local Logic = loadstring(
        game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua")
    )()

    local brainrots = {}
    local selectedSlot = nil
    local DropdownRef = nil

    local function LoadBrainrots()
        brainrots = Logic.GetBrainrots() or {}

        local options = {}
        for _, b in ipairs(brainrots) do
            table.insert(options, b.Name)
        end

        if not DropdownRef then
            DropdownRef = Tab:CreateDropdown({
                Name = "Selecionar Brainrot",
                Options = options,
                Callback = function(selected)
                    print("selecionado:", selected, "Slot:", selectedSlot)
                    selectedSlot = nil
                    for _, b in ipairs(brainrots) do
                        if b.Name == selected then
                            selectedSlot = b.Slot
                            print("[Tsunami] Slot selecionado:", selectedSlot)
                            break
                        end
                    end
                end
            })
            return
        end

        if DropdownRef.Refresh then
            DropdownRef:Refresh(options)
            selectedSlot = nil
        else
            warn("Dropdown não suporta Refresh()")
        end
    end

    Tab:CreateButton({
        Name = "Reset Base",
        Callback = Logic.ResetBase
    })

    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = function(state)
            Logic.ToggleMoney(state)

            if state then
                task.delay(0.4, LoadBrainrots)
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


    Tab:CreateButton({
        Name = "Atualizar Brainrots",
        Callback = LoadBrainrots
    })

Tab:CreateToggle({
    Name = "Auto Upgrade Brainrot",
    Callback = function(state)
        if not state then
            Logic.ToggleUpgrade(false, nil)
            return
        end

        if not selectedSlot then
            warn("[Tsunami] Selecione um Brainrot primeiro")
            return
        end

        Logic.ToggleUpgrade(true, selectedSlot)
    end
})
end