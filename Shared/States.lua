local State = {
    Idle = {
        antiIdleActive = false,
        idleConnection = nil
    },

    ESP = {
        Enabled = false,
        MaxDistance = 1000,
        Cache = {}
    },

    Movement = {
        Speed = false,
        Jump = false,
        Fly = false,
        Noclip = false
    },

    Loaded = {
        Dex = false,
        Spy = false,
        Key = false,
        Inf = false
    }
}

return State