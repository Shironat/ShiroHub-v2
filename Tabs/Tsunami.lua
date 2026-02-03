return function(Tab)
    local Logic = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua"
    ))()

    local brainrots = {}
    local selectedSlot = nil
    local BrainrotDropdown = nil

    local function RefreshBrainrotDropdown()
        if BrainrotDropdown then
            BrainrotDropdown:Destroy()
            BrainrotDropdown = nil
        end

        brainrots = Logic.GetBrainrots()
        selectedSlot = nil

        local options = {}
        for _, b in ipairs(brainrots) do
            table.insert(options, b.Name)
        end

        BrainrotDropdown = Tab:CreateDropdown({
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
    end

    Tab:CreateSection("Reset(If it stops working)")

    Tab:CreateButton({
        Name = "Reset Base",
        Callback = function()
            Logic.ResetBase()
        end
    })

    Tab:CreateSection("AutoFarms")

    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = function(state)
            Logic.ToggleMoney(state)
        end
    })

    Tab:CreateToggle({
        Name = "Auto Event Coins",
        Callback = function(state)
            Logic.ToggleMoney(state)
        end
    })

    RefreshBrainrotDropdown()

    Tab:CreateToggle({
        Name = "Auto Upgrade Brainrot",
        Callback = function(state)
            if selectedSlot then
                Logic.ToggleUpgrade(state, selectedSlot)
            else
                warn("[Tsunami] Nenhum Brainrot selecionado")
            end
        end
    })
end