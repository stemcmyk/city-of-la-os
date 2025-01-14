local calls = {}
local callCount = 0

-- Functions
exports('GetDispatchCalls', function()
    return calls
end)

RegisterServerEvent("wasabi_ambulance:onPlayerDistress", function ()
    local player = ESX.GetPlayerFromId(source) 
    if (exports.stem_common:tableContains(Config.Jobs, player.job.name)) then
        TriggerClientEvent("ps-dispatch:client:officerdown", player.source)
    end
end)

-- Events
RegisterServerEvent('ps-dispatch:server:notify', function(data)
    callCount = callCount + 1
    data.id = callCount
    data.time = os.time() * 1000
    data.units = {}
    data.responses = {}

    if #calls >= Config.MaxCallList then
        table.remove(calls, 1)
    end

    calls[#calls + 1] = data

    TriggerClientEvent('ps-dispatch:client:notify', -1, data)
end)

RegisterServerEvent('ps-dispatch:server:attach', function(id, player)
    attachUnit(id, player)
end)

function attachUnit(id, player) 
    for i=1, #calls do
        if calls[i]['id'] == id then
            for j = 1, #calls[i]['units'] do
                if calls[i]['units'][j]['cid'] == player.cid then
                    return
                end
            end
            calls[i]['units'][#calls[i]['units'] + 1] = player
            return #calls[i]['units']
        end
    end
end

exports("attachUnit", attachUnit)

RegisterServerEvent('ps-dispatch:server:detach', function(id, player)
    for i = #calls, 1, -1 do
        if calls[i]['id'] == id then
            if calls[i]['units'] and (#calls[i]['units'] or 0) > 0 then
                for j = #calls[i]['units'], 1, -1 do
                    if calls[i]['units'][j]['cid'] == player.cid then
                        table.remove(calls[i]['units'], j)
                    end
                end
            end
            return
        end
    end
end)

ESX.RegisterServerCallback("ps-dispatch:getData", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)
    cb({
        duty = player.getMeta("duty:"..player.job.name) or 0,
        callsign = player.getMeta("callsign"..player.job.name)
    })
end)

-- Callbacks
lib.callback.register('ps-dispatch:callback:getLatestDispatch', function(source)
    return calls[#calls]
end)

lib.callback.register('ps-dispatch:callback:getCalls', function(source)
    return calls
end)

-- Commands
lib.addCommand('dispatch', {
    help = locale('open_dispatch')
}, function(source, raw)
    TriggerClientEvent("ps-dispatch:client:openMenu", source, calls)
end)

lib.addCommand('911', {
    help = 'Send a message to 911',
    params = { { name = 'message', type = 'string', help = '911 Message' }},
}, function(source, args, raw)
    local fullMessage = raw:sub(5)
    TriggerClientEvent('ps-dispatch:client:sendEmergencyMsg', source, fullMessage, "911", false)
end)
lib.addCommand('911a', {
    help = 'Send an anonymous message to 911',
    params = { { name = 'message', type = 'string', help = '911 Message' }},
}, function(source, args, raw)
    local fullMessage = raw:sub(5)
    TriggerClientEvent('ps-dispatch:client:sendEmergencyMsg', source, fullMessage, "911", true)
end)