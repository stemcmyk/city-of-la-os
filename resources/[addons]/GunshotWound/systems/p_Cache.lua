-- CACHING --
local w_cache = {}
local a_cache = {}

-- EVENTS --
AddEventHandler("pCache_SetWeapons", function(table)
    w_cache = table
    Wait(100)
    TriggerEvent("pCache_SentWeapons", w_cache)
end)
AddEventHandler("pCache_SetArmor", function(table)
    a_cache = table
    Wait(100)
    TriggerEvent("pCache_SentArmor", a_cache)
end)
AddEventHandler("pCache_GetWeapons", function()
    Wait(100)
    TriggerEvent("pCache_SentWeapons", w_cache)
end)
AddEventHandler("pCache_GetArmor", function()
    Wait(100)
    TriggerEvent("pCache_SentArmor", a_cache)
end)
RegisterNetEvent("sysValueReset_Cache")
AddEventHandler("sysValueReset_Cache", function()
    a_cache = {}
    w_cache = {}
    TriggerEvent("pCache_SentWeapons", w_cache)
    TriggerEvent("pCache_SentArmor", a_cache)
end)