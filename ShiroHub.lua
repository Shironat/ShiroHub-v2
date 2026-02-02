local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "ShiroHub v2"
})

local Tabs = {
    Exploits = Window:CreateTab("Exploits"),
    Inject = Window:CreateTab("Injection"),
    Logs = Window:CreateTab("Logs"),
    District = Window:CreateTab("District"),
    Tsunami = Window:CreateTab("Tsunami")
}

local Modules = {
    Exploits = require(script.Parent.Tabs.Exploits),
    Inject   = require(script.Parent.Tabs.Inject),
    Logs = require(script.Parent.Tabs.Logs),
    District = require(script.Parent.Tabs.District),
    Tsunami = require(script.Parent.Tabs.Tsunami)
}

for name, module in pairs(Modules) do
    module.Init(Window, Tabs[name])
end