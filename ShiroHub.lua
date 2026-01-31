local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "ShiroHub v2"
})

local Tabs = {
    Exploits = Window:CreateTab("Exploits"),
    Inject = Window:CreateTab("Injection"),
    Logs = Window:CreateTab("Logs")
    District = Window:CreateTab("District")
    Tsunami = Window:CreateTab("Tsunami")
}

local Modules = {
    Exploits = require(script.Modules.Tabs.Exploits),
    Inject   = require(script.Modules.Tabs.Inject),
    Logs = require(script.Modules.Tabs.Logs),
    District = require(script.Modules.Tabs.District)
    Tsunami = require(script.Modules.Tabs.Tsunami)
}

for name, module in pairs(Modules) do
    module.Init(Window, Tabs[name])
end