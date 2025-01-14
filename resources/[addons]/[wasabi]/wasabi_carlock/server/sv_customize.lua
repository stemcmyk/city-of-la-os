-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end

---@diagnostic disable: undefined-global
-- How keys are awarded on server start up to ensure owned keys already granted
CreateThread(function()
    while not wsb or not wsb?.framework do Wait(750) end
    if wsb.framework == 'esx' then
        MySQL.ready(function()
            MySQL.Async.fetchAll('SELECT owner, plate FROM owned_vehicles', {}, function(result)
                if result then
                    for _, v in pairs(result) do
                        if not VehicleKeys[v.owner] then VehicleKeys[v.owner] = {} end
                        VehicleKeys[v.owner][v.plate] = true
                    end
                end
            end)
        end)
    elseif wsb.framework == 'qb' then
        MySQL.ready(function()
            MySQL.Async.fetchAll('SELECT citizenid, plate FROM player_vehicles', {}, function(result)
                if result then
                    for _, v in pairs(result) do
                        if not VehicleKeys[v.citizenid] then VehicleKeys[v.citizenid] = {} end
                        VehicleKeys[v.citizenid][v.plate] = true
                    end
                end
            end)
        end)
    end
end)
