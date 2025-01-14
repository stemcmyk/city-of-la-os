-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end
ESX = nil
if wsb.framework == 'esx' then ESX = exports.es_extended:getSharedObject() end
-- Customizing revive event?
RegisterNetEvent('wasabi_adminmenu:revive', function()
    if GetResourceState('wasabi_ambulance') ~= 'missing' then
        Wait(2000)
        return TriggerEvent('wasabi_ambulance:revive')
    elseif GetResourceState('esx_ambulancejob') ~= 'missing' then
        return TriggerEvent('esx_ambulancejob:revive')
    elseif GetResourceState('qb-ambulancejob') ~= 'missing' then
        return TriggerEvent('hospital:client:Revive')
    else
        return print(GetCurrentResourceName() .. 'Tried to trigger wasabi_adminmenu:revive, but no event was found.. please edit this in client/modifyme.lua') -- Replace this line with custom revive event
        -- REMOVE THE LINE ABOVE AND ADD YOUR OWN TRIGGER HERE IF NOT USING RESOURCES ABOVE!
    end
end)

-- Customizing heal event?
RegisterNetEvent('wasabi_adminmenu:heal', function()
    if GetResourceState('wasabi_ambulance') ~= 'missing' then
        TriggerEvent('wasabi_ambulance:heal', true, false)
    elseif GetResourceState('esx_basicneeds') ~= 'missing' then
        return TriggerEvent('esx_basicneeds:healPlayer')
    elseif GetResourceState('qb-ambulancejob') ~= 'missing' then
        return TriggerEvent('hospital:client:adminHeal')
    else
        return SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))-- Replace this line with custom heal event
         -- REMOVE THE LINE ABOVE AND ADD YOUR OWN TRIGGER HERE IF NOT USING RESOURCES ABOVE!
    end
end)

-- Customizing skin menu?
RegisterNetEvent('wasabi_adminmenu:skinmenu', function()
    if Config.SkinMenu == 'esx_skin' then
        TriggerEvent('esx_skin:openSaveableMenu')
    elseif Config.SkinMenu == 'fivem-appearance' then
        exports['fivem-appearance']:startPlayerCustomization()
    elseif Config.SkinMenu == 'qb' then
        TriggerEvent('qb-clothing:client:openMenu')
    elseif Config.SkinMenu == 'custom' then
        print('[wasabi_adminmenu] - WARNING: Config.SkinMenu was defined as \'custom\' however it was never set up in modifyme.lua')
        -- Add your own event/export here.
    elseif Config.SkinMenu == '' or Config.SkinMenu == 'change_me' then
        print('[wasabi_adminmenu] - WARNING: Config.SkinMenu not configured')
    end
end)

GiveVehKeys = function(plate, model, vehicle) -- Customizing giving key function?
     if Config.UsingVehicleKeys == 'wasabi' then
        exports['wasabi_carlock']:GiveKeys(plate)
     elseif Config.UsingVehicleKeys == 'qb' then
        TriggerEvent('vehiclekeys:client:SetOwner', plate)
     elseif Config.UsingVehicleKeys == 'jaksam' then
        TriggerServerEvent('vehicles_keys:selfGiveVehicleKeys', plate)
     elseif Config.UsingVehicleKeys == 'custom' then
        -- Add your own here
     end
end

OpenPlyInv = function(target) -- Customize searching players inventory?
    if Config.Inventory == 'ox' then
        ExecuteCommand('viewinv '..tostring(target))
    elseif Config.Inventory == 'mf' then
        ESX.TriggerServerCallback('esx:getOtherPlayerData', function(data)
            if type(data) ~= 'table' or not data.identifier then
                return
            end
            exports['mf-inventory']:openOtherInventory(data.identifier)
        end, target)
    elseif Config.Inventory == 'qs' or Config.Inventory == 'qb' then
        TriggerServerEvent('inventory:server:OpenInventory', 'otherplayer', target)
    elseif Config.Inventory == 'cheeza' then
        TriggerEvent('inventory:openPlayerInventory', target, true)
    elseif Config.Inventory == 'custom' then
        -- Add custom inventory logic here
    else
        print('No Inventory Found.. Check your config.lua')
    end
end

GetFuelLevel = function(Vehicle) -- Custom fuel script?
    if Config.FuelSystem == 'legacyfuel' then
        return exports['LegacyFuel']:GetFuel(Vehicle)
    else
        return GetVehicleFuelLevel(Vehicle)
    end
end

SetMaxFuel = function(Vehicle) -- Custom fuel script?
    if Config.FuelSystem == 'legacyfuel' then
        return exports['LegacyFuel']:SetFuel(Vehicle, 100)
    elseif Config.FuelSystem == 'ox' then
        TriggerServerEvent('wasabi_adminmenu:setFuel', VehToNet(Vehicle))
    else
        return SetVehicleFuelLevel(Vehicle, 100)
    end
end

AdminMenu = function(perms) -- Edit/modify admin main menu
    local perms = perms
    if not perms then
        perms = lib.callback.await('wasabi_adminmenu:checkPerms', 2000)
    end
    if not perms then return end
    local Options = {
        {
            icon = 'fa-person',
            label = Strings.self_options,
            description = Strings.self_options_desc,
            args = {SelfOptions = true}
        },
        {
            icon = 'fa-people-arrows',
            label = Strings.player_options_title,
            description = Strings.player_options_desc,
            args = {PlayerOptions = true}
        },
    }
    if perms.vehicles or perms.allPerms then
        Options[#Options + 1] = {
            icon = 'fa-car',
            label = Strings.vehicle_options,
            description = Strings.vehicle_options_desc,
            args = {VehicleOptions = true}
        }
    end
    Options[#Options + 1] = {
        icon = 'fa-globe',
        label = Strings.server_options,
        description = Strings.server_options_desc,
        args = {ServerOptions = true}
    }
    if perms.zones or perms.allPerms then
        Options[#Options + 1] = {
            icon = 'fa-street-view',
            label = Strings.admin_zone_options,
            description = Strings.admin_zone_options_desc,
            args = {AdminZoneMenu = true}
        }
    end
    Options[#Options + 1] = {
        icon = 'fa-screwdriver-wrench',
        label = Strings.developer_options,
        description = Strings.developer_options_desc,
        args = {DeveloperOptions = true}
    }
    lib.registerMenu({
        id = 'admin_menu_main',
        title = Strings.main_title,
        position = Config.MenuPosition,
        options = Options
    }, function(selected, scrollIndex, args)
        if selected and args?.SelfOptions then
            SelfOptions(perms)
        elseif selected and args?.PlayerOptions then
            PlayerOptions(perms)
        elseif selected and args?.VehicleOptions then
            VehicleOptions()
        elseif selected and args?.ServerOptions then
            ServerOptions(perms)
        elseif selected and args?.AdminZoneMenu then
            AdminZoneMenu(perms)
        elseif selected and args?.DeveloperOptions then
            DeveloperOptions(perms)
        end
    end)
    lib.showMenu('admin_menu_main')
end
