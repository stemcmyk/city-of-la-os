-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end
if Config.GangSystem ~= 'rcore' then return end

local oldGang

RegisterNetEvent('rcore_gangs:client:set_gang', function(gangData)
    local data = {}
    if not gangData then
        data.name = nil data.rank = nil
    else
        data.name = gangData.name or nil
        data.rank = gangData.rank or nil
    end
    if oldGang and oldGang == data then return end
    oldGang = data
    TriggerServerEvent('rcore_gangs:server:onGangUpdate', data)
end)

