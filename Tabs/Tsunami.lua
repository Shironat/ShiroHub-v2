return function(Tab)
    local Logic = loadstring(
        game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua")
    )()

    local brainrots = {}
    local selectedSlot = nil
    local BrainrotDropdown = nil

    local function RefreshBrainrots()
        brainrots = Logic.GetBrainrots() or {}

        local options = {}
        for _, b in ipairs(brainrots) do
            table.insert(options, b.Name)
        end

        selectedSlot = nil

        if BrainrotDropdown then
            BrainrotDropdown:Refresh(options)
        end
        end
    end
    print("refresh criado")
    Tab:CreateToggle({
        Name = "Auto Collect",
        Callback = function(state)
            Logic.ToggleMoney(state)

            if state then
                task.wait(0.3)
                RefreshBrainrots()
            end
        end
    })
    print("Collect criado")
    BrainrotDropdown = Tab:CreateDropdown({
        Name = "Selecionar Brainrot",
        Options = {},
        Callback = function(selected)
            for _, b in ipairs(brainrots) do
                if b.Name == selected then
                    selectedSlot = b.Slot
                    print("[Tsunami] Slot selecionado:", selectedSlot)
                    break
                end
            end
        end
    })
    print("DropDown criado")
    Tab:CreateButton({
        Name = "Atualizar",
        Callback = function()
            RefreshBrainrots()
        end
    })

    Tab:CreateToggle({
        Name = "Auto Upgrade Brainrot",
        Callback = function(state)
            if state then
                if selectedSlot then
                    Logic.ToggleUpgrade(true, selectedSlot)
                else
                    warn("Nenhum slot selecionado")
                end
            else
                Logic.ToggleUpgrade(false, nil)
            end
        end
    })
    print("final criado")
end