
-- Handle extra toggle event
RegisterNetEvent('extras:toggle')
AddEventHandler('extras:toggle', function(data)
    local vehicle = data.vehicle
    local extra = data.extra
    local state = data.state
    TriggerClientEvent('extras:toggle', -1, { vehicle = vehicle, extra = extra, state = state })
end)

-- Handle set livery event
RegisterNetEvent('extras:setLivery')
AddEventHandler('extras:setLivery', function(data)
    local vehicle = data.vehicle
    local livery = data.livery
    TriggerClientEvent('extras:setLivery', -1, { vehicle = vehicle, livery = livery })
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb({
            job = xPlayer.getJob(),
            group = xPlayer.getGroup()
        })
    else
        cb(nil)
    end
end)
