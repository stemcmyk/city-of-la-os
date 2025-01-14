local zones = {}

function clearPlayerZones (cid) 
    print(#zones)
    for key, value in pairs(zones) do
        print(key, cid == value.identifier)
        if (value.identifier == cid) then
            local player = ESX.GetPlayerFromIdentifier(cid)
            if (player) then TriggerClientEvent("stem_common:nlr:removeBlip", player.source, value.zone.coords) end

            value.zone:remove()
            value[key] = nil
        end
    end
end


RegisterNetEvent("esx:onPlayerDeath", function (data)
    if (data.killerServerId ~= -1) then        
        Player(source).state.deathCoords = GetEntityCoords(GetPlayerPed(source))
    end 
end)

RegisterNetEvent("stem_common:nlr:registerDeath", function (src)
    local source = src or source
    if (not source) then return print("no nlr source") end
    local player = ESX.GetPlayerFromId(source)
    
    if (GlobalState.purgeActive) then
        Wait(16 * 1000)
        if (not player.hasItem("WEAPON_FIREWORK") or player.hasItem("WEAPON_FIREWORK").count <= 0) then
            player.addInventoryItem("WEAPON_FIREWORK", 1)
        end
        return TriggerClientEvent("shit_purge:respawn", player.source)
    end
    
    if (player.job.name == "lspd" or player.job.name == "lscso" or player.job.name == "sahp") then
        return TriggerClientEvent("stem_common:nlr:policeRespawn", player.source, player.job.name)
    end

    if (Player(player.source).state.nlrOnRespawn) then
        local coords = Player(player.source).state.deathCoords
        if (not coords) then return end;

        for key, value in pairs(Config_AntiNLR.hospitals) do
            if (#(vec2(coords.x, coords.y) - vec2(value.x, value.y)) < Config_AntiNLR.CannotReturnDist * 1.25) then
                return
            end
        end
    
        ESX.TriggerClientCallback(player.source, "stem_common:getZoneAtCoords",  function (zone) 
            if zone == "CHAMH" or zone == "DAVIS" or zone == "STRAW" or zone == "RANCHO" then
                return
            end
    
            TriggerClientEvent("stem_common:nlr:createBlip", player.source, coords)
    
            local zone = lib.zones.sphere({
                coords = coords,
                radius = Config_AntiNLR.CannotReturnDist,
                debug = true,
                onEnter = function (self) 
                    print(json.encode(self))
                end
            })
    
            table.insert(zones, {
                zone = zone,
                identifier = player.identifier,
                createdAt = os.time()
            })
    
            Player(player.source).state.nlrOnRespawn = false
        end, coords)
    end 
end)

RegisterNetEvent("esx:playerLoaded", function (source, player) 
    for key, value in pairs(zones) do
        if (value.identifier == player.identifier) then
            TriggerClientEvent("stem_common:nlr:createBlip", player.source, value.zone.coords)
        end
    end
end)

lib.cron.new("* * * * *", function () 
    for key, value in pairs(zones) do
        local player = ESX.GetPlayerFromIdentifier(value.identifier)

        if (os.time() > value.createdAt + 30 * 60) then
            if (player) then TriggerClientEvent("stem_common:nlr:removeBlip", player.source, value.zone.coords) end

            value.zone:remove()
            value[key] = nil
        end
    end
end)

SetInterval(function ()
    for key, value in pairs(zones) do
        local player = ESX.GetPlayerFromIdentifier(value.identifier)
        if (player and value.zone:contains(GetEntityCoords(GetPlayerPed(player.source))) and os.time() < value.createdAt + 30 * 60) then
            TriggerClientEvent("stem_common:nlr:violation", player.source)
        end
    end
end, 15000)
