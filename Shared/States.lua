local State = {
    Idle = {
        antiIdleActive = false
        idleConnection
    },

    ESP = {
        Enabled = true,
        MaxDistance = 400,
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
        Key = falar,
        Inf = false
    }
}

return State