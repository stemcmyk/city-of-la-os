ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    TriggerEvent('liljay282-gangs:warNotificationInit')    
    CreateZones()
    ESX.TriggerServerCallback('liljay282-gangs:getPlayerData', function(playerGang, playerJob)
        SendNUIMessage({ type = 'UpdateHud', gangData = playerGang, jobData = playerJob })
    end)
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.TriggerServerCallback('liljay282-gangs:getPlayerData', function(playerGang, playerJob)
        SendNUIMessage({ type = 'UpdateHud', gangData = playerGang, jobData = playerJob })
    end)
end)

RegisterNetEvent('liljay282-gangs:updateHud', function()
    ESX.TriggerServerCallback('liljay282-gangs:getPlayerData', function(playerGang, playerJob)
        SendNUIMessage({ type = 'UpdateHud', gangData = playerGang, jobData = playerJob })
    end)
end)

local function GetClosestPlayers()
    local closestPlayers = { }
    local tempName = nil
    local isInGang = nil
    for key, player in pairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if ped ~= PlayerPedId() and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped)) < 2.0 then
            ESX.TriggerServerCallback('liljay282-gangs:checkIfInGane', function(inGang)
                isInGang = inGang
            end, GetPlayerServerId(player))
            repeat Wait(0) until isInGang ~= nil
            if not isInGang then
                ESX.TriggerServerCallback('liljay282-gangs:getPlayerName', function(name)
                    tempName = name
                end, GetPlayerServerId(player))
                repeat Wait(0) until tempName ~= nil
                table.insert(closestPlayers, { Id = GetPlayerServerId(player), Name = tempName } )
                tempName = nil
            end
        end
    end
    return closestPlayers
end

RegisterNuiCallback('keyboardInput', function(data, cb)
    SetNuiFocusKeepInput(data.active)
end)

RegisterNuiCallback('close', function(data, cb)
    SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('withdrawMoney', function(data, cb)
    ESX.TriggerServerCallback('liljay282-gangs:withdrawMoney', function(result)
        cb(result)
    end, data.amount)
end)

RegisterNuiCallback('depositMoney', function(data, cb)
    ESX.TriggerServerCallback('liljay282-gangs:depositMoney', function(result)
        cb(result)
    end, data.amount)
end)

RegisterNuiCallback('recruitPlayer', function(data, cb)
    TriggerServerEvent('liljay282-gangs:recruitPlayer', data.player)
end)

RegisterNuiCallback('promotePlayer', function(data, cb)
    TriggerServerEvent('liljay282-gangs:promotePlayer', data.player, data.rank)
end)

RegisterNuiCallback('demotePlayer', function(data, cb)
    TriggerServerEvent('liljay282-gangs:demotePlayer', data.player, data.rank)
end)

RegisterNuiCallback('kickPlayer', function(data, cb)
    TriggerServerEvent('liljay282-gangs:kickPlayer', data.player)
end)

RegisterNetEvent('liljay282-gangs:updateGangData', function(gangData)
    SendNUIMessage({ type = 'UpdateData', gangData = gangData, closestPlayers = GetClosestPlayers() })
end)

local function GetGangColor(name)
    for key, gang in pairs(Config.Gangs) do
        if gang.Name == name then
            local tempBlip = AddBlipForCoord(0.0, 0.0, 0.0)
            SetBlipColour(tempBlip, gang.Color)
            local hudColor = GetBlipHudColour(tempBlip)
            RemoveBlip(tempBlip)
            local r, g, b, a = GetHudColour(hudColor)
            return { r = r, g = g, b = b, a = a }
        end
    end
    return nil
end

RegisterCommand('gangmenu', function()
    ESX.TriggerServerCallback('liljay282-gangs:getData', function(canOpen, gangData, gangs)
        if canOpen then
            SetNuiFocus(true, false)
            SetNuiFocusKeepInput(true)
            SendNUIMessage({ type = 'ShowMenu', gangData = gangData, closestPlayers = GetClosestPlayers(), gangs = gangs, gangColor = GetGangColor(gangData.name) })
        end
    end)
end)

RegisterKeyMapping('gangmenu', 'Open Gang Menu', 'keyboard', 'F6')

-- RegisterCommand('create', function()
--     CreateZones()
-- end)

-- RegisterCommand('showhud', function()
--     ESX.TriggerServerCallback('liljay282-gangs:getPlayerData', function(playerGang, playerJob)
--         SendNUIMessage({ type = 'UpdateHud', gangData = playerGang, jobData = playerJob })
--     end)
-- end)

CreateThread(function()
    while true do
        SendNUIMessage({ type = 'UpdatePauseMenu', active = IsPauseMenuActive() })
        Wait(500)
    end
end)