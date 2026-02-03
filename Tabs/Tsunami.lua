return function(Tab)
    local Logic = loadstring(
        game:HttpGet("https://raw.githubusercontent.com/Shironat/ShiroHub-v2/main/Logic/TsunamiLogic.lua")
    )()

    -- Estado
    local brainrots = {}
    local selectedSlot = nil
    local BrainrotDropdown = nil

    -- Função de refresh
    local function RefreshBrainrots()
        brainrots = Logic.GetBrainrots() or {}

        local options = {}
        for _, b in ipairs(brainrots) do
            table.insert(options, b.Name)
        end

        selectedSlot = nil

        if BrainrotDropdown then
            BrainrotDropdown:Set(options)
        end

        print("[Tsunami] Brainrots encontrados:", #brainrots)
        for _, b in ipairs(brainrots) do
            print("Slot:", b.Slot, "Brainrot:", b.Name)
        end
    end

    -- Auto Collect
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

    -- Dropdown (criado vazio)
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

    -- Botão manual de refresh (opcional, mas recomendado)
    Tab:CreateButton({
        Name = "Atualizar Brainrots",
        Callback = function()
            RefreshBrainrots()
        end
    })

    -- Auto Upgrade
    Tab:CreateToggle({
        Name = "Auto Upgrade Brainrot",
        Callback = function(state)
            if state then
                if selectedSlot then
                    Logic.ToggleUpgrade(true, selectedSlot)
                else
                    warn("[Tsunami] Nenhum slot selecionado")
                end
            else
                Logic.ToggleUpgrade(false, nil)
            end
        end
    })
end