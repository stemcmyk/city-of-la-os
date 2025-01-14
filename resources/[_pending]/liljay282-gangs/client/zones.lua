local ActiveZones = { }
local CurrentZone = nil
local ZonesBlips = { }

function StartPolyZoneChecks()
    for key, zone in pairs(ActiveZones) do
        zone.polyHandle:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            if isPointInside then
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    TriggerServerEvent('liljay282-gangs:enterZone', zone.name)
                end
                if zone.isClaimed then
                    SendNUIMessage({ type = 'ShowNotification', text = ('%s - %s'):format(zone.name, zone.claimedGang.Name) })
                else
                    SendNUIMessage({ type = 'ShowNotification', text = ('%s - unclaimed'):format(zone.name) })
                end
                SendNUIMessage({ type = 'ShowTimer' })
                CurrentZone = zone
            else
                TriggerServerEvent('liljay282-gangs:leaveZone', zone.name)
                SendNUIMessage({ type = 'HideNotification' })
                SendNUIMessage({ type = 'HideTimer' })
                CurrentZone = nil
            end
        end)
    end
end

function CreateZones()
    local tmepIsClaimed = nil
    local tempGang = nil
    for key, blip in pairs(ZonesBlips) do RemoveBlip(blip) end
    for key, zone in pairs(ActiveZones) do zone.polyHandle:destroy() end
    ActiveZones = { }
    ZonesBlips = { }
    SendNUIMessage({ type = 'HideNotification' })
    CurrentZone = nil
    local counter = 0
    for key, data in pairs(Config.Zones) do
        ESX.TriggerServerCallback('liljay282-gangs:isZoneClaimed', function(isClaimed, gang)
            tmepIsClaimed = isClaimed
            tempGang = gang
        end, data.Name)
        repeat Wait(0) until tmepIsClaimed ~= nil
        repeat Wait(0) until tempGang ~= nil
        local centerX = (data.Zone.x1 + data.Zone.x2) / 2
        local centerY = (data.Zone.y1 + data.Zone.y2) / 2
        local distance = math.sqrt(((data.Zone.x2 - data.Zone.x1) ^ 2) + ((data.Zone.y2 - data.Zone.y1) ^ 2))
        local blipHandle = AddBlipForArea(centerX, centerY, 0.0, distance, distance)
        SetBlipAlpha(blipHandle, 150)
        if tmepIsClaimed then
            SetBlipColour(blipHandle, tempGang.Color)
        else
            SetBlipColour(blipHandle, 39)
        end
        SetBlipDisplay(blipHandle, 3)
        table.insert(ZonesBlips, blipHandle)
        local PolyHandle = BoxZone:Create(vector3(centerX, centerY, 0.0), distance, distance, {
            name = data.Name,
            offset = { 0.0, 0.0, 0.0 },
            scale = { 1.0, 1.0, 1.0 },
            debugPoly = false
        })
        table.insert(ActiveZones, { name = data.Name, center = vector3(centerX, centerY, 0.0), polyHandle = PolyHandle, isClaimed = tmepIsClaimed, claimedGang = tempGang })
        tmepIsClaimed = nil
        tempGang = nil
        counter = counter + 1
    end
    repeat Wait(0) until counter == #Config.Zones
    StartPolyZoneChecks()
end

RegisterNuiCallback('abandonTerritory', function(data, cb)
    if not CurrentZone then return end
    TriggerServerEvent('liljay282-gangs:abandonTerritory', CurrentZone)
end)

RegisterNetEvent('liljay282-gangs:createZones', function()
    CreateZones()
end)

RegisterNetEvent('liljay282-gangs:updateTimer', function(timer)
    SendNUIMessage({ type = 'UpdateTimer', time = timer })
end)

RegisterNetEvent('liljay282-gangs:hideTimer', function()
    SendNUIMessage({ type = 'ResetTimer' })
end)

RegisterNuiCallback('declareWar', function(data, cb)
    TriggerServerEvent('liljay282-gangs:declareWar', data.gang)
end)

RegisterNetEvent('liljay282-gangs:warNotificationInit', function()
    TriggerServerEvent('liljay282-gangs:showWarMessage')
end)

RegisterNetEvent('liljay282-gangs:showWarMessage', function(gang)
    SendNUIMessage({ type = 'ShowWarNotification', text = gang })
end)

RegisterNetEvent('baseevents:onPlayerDied', function()
    TriggerServerEvent('liljay282-gangs:removeDead', CurrentZone.name)
    SendNUIMessage({ type = 'HideNotification' })
    SendNUIMessage({ type = 'HideTimer' })
    CurrentZone = nil
end)

RegisterNetEvent('baseevents:onPlayerKilled', function()
    TriggerServerEvent('liljay282-gangs:removeDead', CurrentZone.name)
    SendNUIMessage({ type = 'HideNotification' })
    SendNUIMessage({ type = 'HideTimer' })
    CurrentZone = nil
end)

RegisterNetEvent('baseevents:onPlayerWasted', function()
    TriggerServerEvent('liljay282-gangs:removeDead', CurrentZone.name)
    SendNUIMessage({ type = 'HideNotification' })
    SendNUIMessage({ type = 'HideTimer' })
    CurrentZone = nil
end)