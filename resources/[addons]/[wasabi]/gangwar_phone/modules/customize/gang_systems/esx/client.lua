-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end
if Config.GangSystem ~= 'esx' or wsb.framework == 'qb' then return end

RegisterNetEvent('esx_gangs:UpdateClient', function(gang, rank)
    local data = {name = gang.name or nil, rank = rank.ranking or nil}
    TriggerServerEvent('esx_gangs:server:OnGangUpdate', data)
end)