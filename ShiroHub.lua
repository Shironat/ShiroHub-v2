local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "ShiroHub v2"
})

local Tabs = {
    Exploits = Window:CreateTab("Exploits"),
    Inject   = Window:CreateTab("Injection"),
    Logs     = Window:CreateTab("Logs"),
    District = Window:CreateTab("District"),
    Tsunami  = Window:CreateTab("Tsunami")
}

local Root = script.Parent

local Modules = {
    Exploits = require(Root.Tabs.Exploits),
    Inject   = require(Root.Tabs.Inject),
    Logs     = require(Root.Tabs.Logs),
    District = require(Root.Tabs.District),
    Tsunami  = require(Root.Tabs.Tsunami)
}

for name, module in pairs(Modules) do
    if module.Init then
        module.Init(Tabs[name])
    end
end