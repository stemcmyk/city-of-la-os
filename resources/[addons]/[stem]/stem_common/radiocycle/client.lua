local CycleChannelAllowedJobs = {
    ["lspd"] = true,
    ["sahp"] = true,
    ["lscso"] = true,
    ["dispatch"] = true,
    ["mecano"] = true,
    ["amr"] = true
}

RegisterCommand(
    "decreaseradiofreq",
    function()
        if CycleChannelAllowedJobs[ESX?.PlayerData?.job?.name] then
            TriggerEvent("mm-radio:DecreaseFrequency")
        end
    end
)


RegisterCommand(
    "increaseradiofreq",
    function()
        if CycleChannelAllowedJobs[ESX?.PlayerData?.job?.name] then
            TriggerEvent("mm-radio:IncreaseFrequency")
        end
    end
)

RegisterKeyMapping("decreaseradiofreq", "Radio frequency: -1 MHz", "keyboard", "LBRACKET")
RegisterKeyMapping("increaseradiofreq", "Radio frequency: +1 MHz", "keyboard", "RBRACKET")
