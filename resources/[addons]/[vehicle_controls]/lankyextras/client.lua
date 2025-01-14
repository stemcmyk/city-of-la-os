
local isInLocation = false
local notificationId = nil
local notificationDuration = 60000 -- 1 minute duration

local keyMapping = {
    [29] = "B", -- Add more key mappings as needed
}

function showNotification()
    local key = Config.Keys.key2
    local keyName = "SHIFT + " .. (keyMapping[key] or "?")
    local message = "Press " .. keyName .. " to open the menu or use /extras"

    print("Showing notification with message:", message)  -- Debugging

    notificationId = exports.ox_lib:notify({
        title = 'Vehicle Customization',
        description = message,
        type = 'info',
        duration = notificationDuration -- 1 minute duration
    })

    print("Notification shown with ID:", notificationId)
end

function hideNotification()
    if notificationId then
        exports.ox_lib:removeNotification(notificationId)
        print("Notification hidden with ID:", notificationId)
        notificationId = nil
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local inLocation = false

        for _, location in pairs(Config.Locations) do
            if GetDistanceBetweenCoords(coords, location.coords, true) < location.radius then
                inLocation = true
                if not isInLocation then
                    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
                        if (data.job.name == location.job or exports.stem_common:tableContains(location.job, data.job.name)) and IsPedInAnyVehicle(player, false) then
                            print("Player has entered the location and meets all requirements.") -- Debugging
                            showNotification()
                            isInLocation = true
                        end
                    end)
                end
            end
        end
        
        if not inLocation and isInLocation then
            print("Player has left the location or no longer meets the requirements.") -- Debugging
            hideNotification()
            isInLocation = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(0, 21) and IsControlJustPressed(0, Config.Keys.key2) then
            ExecuteCommand(Config.Command)
        end
    end
end)

-- Function to open extras menu
function openExtrasMenu(playerId, vehicle, menuName)
    local options = {}
    for i = 1, 20 do  -- Assuming max 20 extras
        if DoesExtraExist(vehicle, i) then
            local extraState = IsVehicleExtraTurnedOn(vehicle, i)
            local colorIndicator = extraState and '🟢' or '🔴'
            local extraLabel = ('Extra %d %s'):format(i, colorIndicator)
            table.insert(options, {
                title = extraLabel,
                description = 'Toggle this extra',
                event = 'extras:toggle',
                args = { vehicle = VehToNet(vehicle), extra = i, state = not extraState },
                close = false
            })
        end
    end

    local liveryCount = GetVehicleLiveryCount(vehicle)
    for i = 0, liveryCount - 1 do
        local liveryLabel = ('Livery %d'):format(i)
        table.insert(options, {
            title = liveryLabel,
            description = 'Apply this livery',
            event = 'extras:setLivery',
            args = { vehicle = VehToNet(vehicle), livery = i },
            close = false
        })
    end

    local alignment = Config.MenuAlignment or 'right'

    exports.ox_lib:registerContext({
        id = 'extras_menu',
        title = menuName,
        options = options,
        position = alignment
    })

    exports.ox_lib:showContext('extras_menu')
end

-- Admin command to open extras menu for a specific player
RegisterCommand(Config.AdminCommand, function(source, args, rawCommand)
    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
        if data.group == Config.AdminGroup then
            local playerId = tonumber(args[1])
            if playerId then
                local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                if vehicle and vehicle ~= 0 then
                    local menuName = "Admin Extras Menu"
                    openExtrasMenu(playerId, vehicle, menuName)
                else
                    print("The specified player is not in a vehicle.")
                end
            else
                print("Please specify a valid player server ID.")
            end
        else
            ESX.ShowNotification("You do not have permission to use this command.")
        end
    end, GetPlayerServerId(PlayerId()))
end, true)

-- Function to check player job
function checkPlayerJob(requiredJob, callback)
    ESX.TriggerServerCallback('esx:getPlayerData', function(data)
        callback(data.job.name == requiredJob or exports.stem_common:tableContains(requiredJob, data.job.name))
    end)
end

-- Function to open the customization menu
function OpenCustomizationMenu(menuName)
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)

    if vehicle and vehicle ~= 0 then
        openExtrasMenu(PlayerId(), vehicle, menuName)
    else
        ESX.ShowNotification("You must be in a vehicle to use this.")
    end
end

-- Command to open the extras menu if all requirements are met
RegisterCommand(Config.Command, function()
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)

    for _, location in pairs(Config.Locations) do
        if GetDistanceBetweenCoords(coords, location.coords, true) < location.radius then
            checkPlayerJob(location.job, function(hasJob)
                if hasJob and IsPedInAnyVehicle(player, false) then
                    OpenCustomizationMenu(location.menuName)
                elseif not IsPedInAnyVehicle(player, false) then
                    ESX.ShowNotification("You must be in a vehicle to use this.")
                elseif not hasJob then
                    ESX.ShowNotification("You do not have the required job to use this.")
                end
            end)
            return
        end
    end

    ESX.ShowNotification("You are not in the correct location to use this.")
end, false)

-- Event handlers for the context menu
RegisterNetEvent('extras:toggle')
AddEventHandler('extras:toggle', function(data)
    local vehicle = NetToVeh(data.vehicle)
    local extra = data.extra
    local state = data.state
    SetVehicleExtra(vehicle, extra, state and 0 or 1)
    openExtrasMenu(PlayerId(), vehicle, data.menuName)
end)

RegisterNetEvent('extras:setLivery')
AddEventHandler('extras:setLivery', function(data)
    local vehicle = NetToVeh(data.vehicle)
    local livery = data.livery
    SetVehicleLivery(vehicle, livery)
    openExtrasMenu(PlayerId(), vehicle, data.menuName)
end)
