-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
DisableKeys, VehicleKeys = nil, {}

if not wsb then return print((Strings.no_wsb):format(GetCurrentResourceName())) end

CreateThread(function()
    Wait(1000)
    TriggerServerEvent('wasabi_carlock:initializePlayer')
end)

RegisterNetEvent('wasabi_bridge:playerLoaded', function()
    TriggerServerEvent('wasabi_carock:initializePlayer')
end)

RegisterNetEvent('wasabi_carlock:lockpickVehicle', function()
    LockpickVehicle()
end)

RegisterNetEvent('wasabi_carlock:bLoop', function()
    BreakVehicleLoop()
end)

RegisterNetEvent('vehiclekeys:client:SetOwner', function(plate) -- qb-vehiclekeys compatibility event
    BreakVehicleLoop()
    GiveKeys(plate)
end)

if Config.manageKeys and Config.manageKeys.enabled then
    AddEventHandler('wasabi_carlock:manageKey', function(plate)
        local hasKey = HasKey(plate)
        if not hasKey then return end

        lib.registerMenu({
            id = 'manage_key_menu',
            title = (Strings.manage_key):format(plate),
            position = Config.manageKeys.menuPosition,
            options = {
                {
                    icon = 'key',
                    label = Strings.give_key,
                    description = '',
                    args = { action = 'give', plate = plate }
                },
                {
                    icon = 'key',
                    label = Strings.remove_key,
                    description = '',
                    args = { action = 'remove', plate = plate }
                }
            }
        }, function(selected, _, args)
            if selected then
                if args.action == 'give' then
                    GiveKeyMenu(plate)
                elseif args.action == 'remove' then
                    local alert = lib.alertDialog({
                        header = Strings.are_you_sure,
                        content = (Strings.are_you_sure_desc):format(plate),
                        centered = true,
                        cancel = true
                    })
                    if alert ~= 'confirm' then
                        TriggerEvent('wasabi_bridge:notify', Strings.cancelled_action, Strings.cancelled_action_desc,
                            'error')
                        return
                    end
                    RemoveKeys(plate)
                    TriggerEvent('wasabi_bridge:notify', Strings.keys_removed, (Strings.keys_removed_desc):format(plate),
                        'success')
                end
            end
        end)
        lib.showMenu('manage_key_menu')
    end)
end


lib.onCache('vehicle', function(vehicle)
    if not vehicle then return end
    while IsPedGettingIntoAVehicle(cache.ped) do Wait(0) end
    local plate = GetVehicleNumberPlateText(vehicle)
    if HasKey(plate, false) or IsHotwired(plate) or not AreKeysRequired(GetEntityModel(vehicle), plate) or (Config.NoKeyJobs[ESX.PlayerData.job.name] and GetVehicleClass(vehicle) == 18) then
        StartEngine(vehicle)
        return
    end

    StopEngine(vehicle)
    
    if Config.hotwire.enabled or Config.searchingVehicle.enabled then
        local vehInfo = lib.callback.await('wasabi_carlock:getVehInfo', 100, plate)
        if vehInfo.hotwired then
            StartEngine(vehicle)
            return
        end
        StartVehicleLoop(vehicle, plate, vehInfo)
    end
end)

if Config.robPedKeys.enabled then
    CreateThread(function() StartRobPedLoop() end)
end

-- Rob ped for keys loop
function StartRobPedLoop()
    CreateThread(function()
        local firstAnim, targetVeh, targetPlate, breakThread, robbingPed, timerSet, vehicleStopped, pedBlocked
        while true do
            local sleep = 1500
            if breakThread then
                StartRobPedLoop()
                break
            end
            if not IsPedInAnyVehicle(cache.ped, false) and IsPlayerFreeAiming(PlayerId()) then
                local aim, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
                if aim then
                    if DoesEntityExist(target) and (IsPedInAnyVehicle(target, false) or DoesEntityExist(targetVeh)) and not IsPedAPlayer(target) and IsPedArmed(cache.ped, 7) then
                        sleep = 0
                        if IsPedInAnyVehicle(target, false) then targetVeh = GetVehiclePedIsIn(target, false) end
                        if targetVeh then
                            local possiblePlate = GetVehicleNumberPlateText(targetVeh)
                            if possiblePlate then targetPlate = possiblePlate end
                            local dist = #(GetEntityCoords(cache.ped) - GetEntityCoords(target))
                            if dist < 15 and (IsPedFacingPed(target, cache.ped, 60.0) or vehicleStopped) then
                                if not vehicleStopped then
                                    SetVehicleForwardSpeed(targetVeh, 0)
                                    TaskLeaveVehicle(target, targetVeh, 256)
                                    vehicleStopped = true
                                end
                                while IsPedInAnyVehicle(target, false) do
                                    Wait(0)
                                end
                                lib.requestAnimDict('missfbi5ig_22', 100)
                                if not pedBlocked then
                                    ResetPedLastVehicle(target)
                                    SetBlockingOfNonTemporaryEvents(target, true)
                                    SetPedFleeAttributes(target, 0, false)
                                    SetPedCombatAttributes(target, 17, true)
                                    SetPedAlertness(target, 0)
                                    SetPedHearingRange(target, 0.0)
                                    SetPedSeeingRange(target, 0.0)
                                    pedBlocked = true
                                end
                                if not timerSet then
                                    CreateThread(function()
                                        local _target = target
                                        Wait(15000)
                                        SetBlockingOfNonTemporaryEvents(_target, false)
                                        ClearPedTasks(_target)
                                        TaskReactAndFleePed(_target, cache.ped)
                                        SetPedKeepTask(_target, true)
                                        breakThread = true
                                    end)
                                    timerSet = true
                                end
                                SetPedDropsWeaponsWhenDead(target, false)
                                TaskPlayAnim(target, 'missfbi5ig_22', 'hands_up_anxious_scientist', 8.0, 8.0, -1, 3, 0,
                                    false, false, false)
                                firstAnim = true
                                if firstAnim and not IsEntityPlayingAnim(target, 'missfbi5ig_22', 'hands_up_anxious_scientist', 3) then
                                    TaskPlayAnim(target, 'missfbi5ig_22', 'hands_up_anxious_scientist', 8.0, 8.0, -1, 3,
                                        0, false, false, false)
                                end
                                if dist <= 4.5 and not IsEntityDead(target) then
                                    TaskTurnPedToFaceEntity(target, cache.ped, 3.0)
                                    firstAnim = false
                                    if not robbingPed then
                                        robbingPed = true
                                        lib.requestAnimDict('mp_common', 100)
                                        ClearPedTasks(target)
                                        TaskPlayAnim(target, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 3, 0, false, false,
                                            false)
                                        if lib.progressCircle({
                                                label = Config.robPedKeys.label,
                                                duration = Config.robPedKeys.timeToRob * 1000,
                                                position = 'bottom',
                                                useWhileDead = false,
                                                canCancel = true,
                                                disable = {
                                                    car = true,
                                                },
                                            }) then
                                            GiveKeys(targetPlate, false)
                                            TriggerEvent('wasabi_bridge:notify', Strings.handed_keys,
                                                Strings.handed_keys_desc, 'success')
                                            TaskReactAndFleePed(target, cache.ped)
                                            SetPedKeepTask(target, true)
                                            robbingPed = false
                                            StartRobPedLoop()
                                            break
                                        else
                                            breakThread = true
                                            TriggerEvent('wasabi_bridge:notify', Strings.cancelled_action,
                                                Strings.cancelled_action_desc, 'error')
                                            TaskReactAndFleePed(target, cache.ped)
                                            SetPedKeepTask(target, true)
                                            robbingPed = false
                                            StartRobPedLoop()
                                            break
                                        end
                                        RemoveAnimDict('missfbi5ig_22')
                                        RemoveAnimDict('mp_common')
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

---@diagnostic disable-next-line: param-type-mismatch
AddStateBagChangeHandler('vehicleKeys', nil, function(bagName, _, value)
    local player = GetPlayerFromStateBagName(bagName)
    if player ~= PlayerId() then return end
    VehicleKeys = {}
    if value and #value > 0 then
        for i = 1, #value do VehicleKeys[value[i]] = true end
    end
end)

-- Commands, keymapping, etc
if Config.givingKeys.enabled then
    RegisterCommand(Config.givingKeys.command, function()
        GiveKeyMenu()
    end, false)
end

if Config.manageKeys and Config.manageKeys.enabled and Config.manageKeys.command then
    RegisterCommand(Config.manageKeys.command, function()
        ManageKeysMenu()
    end, false)
end

RegisterCommand('toggleCarLock', function()
    ToggleLock()
end)

TriggerEvent('chat:removeSuggestion', '/toggleCarLock')

RegisterKeyMapping('toggleCarLock', Strings.toggle_keymap_desc, 'keyboard', Config.toggleLockKey)
