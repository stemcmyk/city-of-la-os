RegisterNetEvent("s_FirstAid_ConfigSet", function (config) 
    TriggerClientEvent("c_FirstAid_ConfigSet", source, config)
end)