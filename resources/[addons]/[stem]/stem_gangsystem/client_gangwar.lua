local markedPlayerBlips = {}

local function createBlipForPlayer(playerId, enemy, coords) 
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipDisplay(blip, 2)
    SetBlipScale(blip, 0.8)
    SetBlipSprite(blip, 630)

    if (enemy) then
        SetBlipColour(blip, 1)
    else
        SetBlipColour(blip, 2)
    end

    SetBlipFlashes(blip, true)
    SetBlipHighDetail(blip, true)
    SetBlipAsShortRange(blip, false)

    BeginTextCommandSetBlipName("STRING")
    if (enemy) then
        AddTextComponentString("Target")
    else
        AddTextComponentString( "Friend")
    end
    EndTextCommandSetBlipName(blip)

    markedPlayerBlips[tostring(playerId)] = blip
    
    SetTimeout(300000, function()
        if  DoesBlipExist(blip) then
            RemoveBlip(blip)
            markedPlayerBlips[playerId] = nil
        end
    end)
end 

RegisterNetEvent("stem_gangsystem:warUpdate", function(data, creator_mug)
    local setBlip = false;
    for key, player in pairs(data) do
        local existingBlip = markedPlayerBlips[tostring(player.id)]
        if (not player.active and existingBlip) then
            RemoveBlip(existingBlip)
            markedPlayerBlips[tostring(player.id)] = nil;
            return 
        end
        if (not player.active) then return end;
        if (existingBlip) then
            SetBlipCoords(existingBlip, player.coords)
            if (player.enemy) then
                SetBlipColour(existingBlip, 1)
            else
                SetBlipColour(existingBlip, 2)
            end
        else
            createBlipForPlayer(tostring(player.id), player.enemy, player.coords)
        end
    end
    if (setBlip and #data > 0) then
        ESX.ShowHelpNotification(
            string.format("Friendlies are marked ~HUD_COLOUR_GREEN~~BLIP_BAT_ASSASSINATE~~s~. Enemies are marked ~HUD_COLOUR_RED~~BLIP_BAT_ASSASSINATE~~s~. Kill your targets. (These will hide in %s min)", math.ceil(Config.hideBlipsTime / 60))
        )
    end
end)


AddStateBagChangeHandler(
    "gangWar",
    nil,
    function(bagName, key, value, _reserved, replicated)
        local plySource = GetPlayerFromStateBagName(bagName)
        if plySource == 0 then
            return
        end

        if plySource ~= PlayerId() then -- Ignore state changes from other players
            return
        end

        if type(value) == "table" then
            PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
            
            exports["mythic_notify"]:PersistentAlert("START", "GANG_WAR_PERSISTENT_NOTIFY", "error",
                "⚔️ Active Gang War: " .. value.display)
        else
            PlaySoundFrontend(-1, "MP_AWARD", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
            exports["mythic_notify"]:PersistentAlert("END", "GANG_WAR_PERSISTENT_NOTIFY")
        end
    end
)

RegisterNetEvent("stem_gangsystem:warFInished", function (isWinner) 

end)


ESX.RegisterClientCallback("stem_gangsystem:isInGangWarZone", function (cb) 
    local playerCoords = GetEntityCoords(PlayerPedId())
    local zoneName = GetNameOfZone(playerCoords)

    local postal = exports["nearest-postal"]:getPostal()
    if postal ~= nil and Config.nonGangWarZones[postal] then
        return cb(false)
    end

    if zoneName == "CHAMH" or zoneName == "DAVIS" or zoneName == "STRAW" or zoneName == "RANCHO" then
        return cb(true)
    else
        return cb(false)
    end
end)

ESX.RegisterClientCallback("stem_gangsystem:getKillInfo", function (cb, data)
    local weapon = exports.ox_inventory:getCurrentWeapon()

    cb({ weaponModel = weapon?.label })
end)
