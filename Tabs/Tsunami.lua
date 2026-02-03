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

    local brainrots = Logic.GetBrainrots()

    local options = {}
       for _, b in ipairs(brainrots) do
          table.insert(options, b.Name)
    end

    print("Brainrots retornados:", #Logic.GetBrainrots())
    for _, b in ipairs(Logic.GetBrainrots()) do
       print("Brainrot encontrado:", b.Name, "slot", b.Slot)
end

    Tab:CreateDropdown({
        Name = "Selecionar Brainrot",
        Options = options,
        Callback = function(selected)
            Logic.SetSelectedBrainrot(selected)
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