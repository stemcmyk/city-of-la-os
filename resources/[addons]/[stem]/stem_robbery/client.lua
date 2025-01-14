local ESXLoaded = false
local robbing = false

Citizen.CreateThread(function ()
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local peds = {}
local objects = {}

RegisterNetEvent('loffe_robbery:onPedDeath')
AddEventHandler('loffe_robbery:onPedDeath', function(store)
    SetEntityHealth(peds[store], 0)
end)

RegisterNetEvent('loffe_robbery:msgPolice')
AddEventHandler('loffe_robbery:msgPolice', function(store, robber)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))
	ESX.ShowAdvancedNotification(Config.Shops[store].name, Translation[Config.Locale]['robbery'], Translation[Config.Locale]['cop_msg'], mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
    while true do
        local name = GetCurrentResourceName() .. math.random(999)
        AddTextEntry(name, '~INPUT_CONTEXT~ ' .. Translation[Config.Locale]['set_waypoint'] .. '\n~INPUT_FRONTEND_RRIGHT~ ' .. Translation[Config.Locale]['hide_box'])
        DisplayHelpTextThisFrame(name, false)
        if IsControlPressed(0, 38) then
            SetNewWaypoint(Config.Shops[store].coords.x, Config.Shops[store].coords.y)
            return
        elseif IsControlPressed(0, 194) then
            return
        end
        Wait(0)
    end
end)

RegisterNetEvent('loffe_robbery:removePickup', function(coords, netId)
    print(NetToObj(netId))
    local interior = GetInteriorAtCoords(coords)
    for _, v in pairs(GetGamePool("CObject")) do
        print(GetInteriorFromEntity(v), GetEntityModel(v))
        if GetInteriorFromEntity(v) == interior then
            if (GetEntityModel(v) == -1194335261) then
                SetEntityAsMissionEntity(v, true, true)
                DeleteObject(v)
                DeleteEntity(v)
                return 
            end
        end
    end
end)

RegisterNetEvent('loffe_robbery:robberyOver')
AddEventHandler('loffe_robbery:robberyOver', function()
    robbing = false
end)

RegisterNetEvent('loffe_robbery:talk')
AddEventHandler('loffe_robbery:talk', function(store, text, time)
    robbing = false
    local endTime = GetGameTimer() + 1000 * time
    while endTime >= GetGameTimer() do
        local x = GetEntityCoords(peds[store])
        DrawText3D(vector3(x.x, x.y, x.z + 1.0), text)
        Wait(0)
    end
end)

RegisterCommand('animation', function(source, args)
    if args[1] and args[2] then
        loadDict(args[1])
        TaskPlayAnim(PlayerPedId(), args[1], args[2], 8.0, -8.0, -1, 2, 0, false, false, false)
    end
end)

RegisterNetEvent('loffe_robbery:rob')
AddEventHandler('loffe_robbery:rob', function(i, owner)
    if not IsPedDeadOrDying(peds[i]) then
        SetEntityCoords(peds[i], Config.Shops[i].coords)
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
        while not IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end
        local timer = GetGameTimer() + 10800
        while timer >= GetGameTimer() do
            if IsPedDeadOrDying(peds[i]) then
                break
            end
            Wait(0)
        end

        if not IsPedDeadOrDying(peds[i]) then
            local cashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01'))
            if DoesEntityExist(cashRegister) then
                CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
            end

            timer = GetGameTimer() + 200 
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end

            local model = GetHashKey('prop_poly_bag_01')
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end
            local bag = CreateObject(model, GetEntityCoords(peds[i]), 1, 0)
                        
            AttachEntityToEntity(bag, peds[i], GetPedBoneIndex(peds[i], 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
            timer = GetGameTimer() + 10000
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end
            if not IsPedDeadOrDying(peds[i]) then
                DetachEntity(bag, true, false)
                timer = GetGameTimer() + 75
                while timer >= GetGameTimer() do
                    if IsPedDeadOrDying(peds[i]) then
                        break
                    end
                    Wait(0)
                end
                SetEntityHeading(bag, Config.Shops[i].heading)
                ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                table.insert(objects, {bank = i, object = bag})
                Citizen.CreateThread(function()
                    while true do
                        Wait(5)
                        if DoesEntityExist(bag) and GetPlayerServerId(PlayerId()) == owner then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 1.5 then
                                PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                TriggerServerEvent('loffe_robbery:pickUp', i, ObjToNet(bag))
                                DeleteEntity(bag)
                                robbing = false
                                break
                            end
                        else
                            break
                        end
                    end
                end)
            else
                DeleteObject(bag)
            end
        end
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
        timer = GetGameTimer() + 2500
        while timer >= GetGameTimer() do Wait(0) end
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
        local stop = GetGameTimer() + 120000
        while stop >= GetGameTimer() do
            Wait(50)
        end
        if IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "cower_loop", 3) then
            ClearPedTasks(peds[i])
        end
    end
end)

RegisterNetEvent('loffe_robbery:resetStore')
AddEventHandler('loffe_robbery:resetStore', function(i)
    while not ESXLoaded do Wait(0) end
    if DoesEntityExist(peds[i]) then
        DeletePed(peds[i])
    end
    Wait(250)
    peds[i] = _CreatePed(Config.Shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
    local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, GetHashKey('prop_till_01_dam'))
    if DoesEntityExist(brokenCashRegister) then
        CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, GetHashKey('prop_till_01_dam'), GetHashKey('prop_till_01'), false)
    end
end)

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

function GetStreetAndZone(coords)
    local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords.x, coords.y, coords.z))
    return street .. ", " .. zone
end

RegisterNetEvent("stem_robbery:updateStoreData", function (storeId, store) 
    if (Config.Shops[storeId]) then
        Config.Shops[storeId] = store
    end
end)

Citizen.CreateThread(function()
    while not ESXLoaded do Wait(0) end
    
    for i = 1, #Config.Shops do
        local pedmodel = Config.Shops[i].pedmodel and Config.Shops[i].pedmodel or
        Config.Shopkeeper
        peds[i] = _CreatePed(pedmodel, Config.Shops[i].coords, Config.Shops[i].heading,
        Config.Shops[i].frozen)

        if Config.Shops[i].blip then
            local blip = AddBlipForCoord(Config.Shops[i].coords)
            SetBlipScale(blip, 0.8)
            SetBlipSprite(blip, 628)
            SetBlipDisplay(blip, 2)
            SetBlipPriority(blip, 9)
            -- SetBlipColour(blip, 75)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Store Robbery")
            EndTextCommandSetBlipName(blip)

            Config.Shops[i].blipHandle = blip
        end

        local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, `prop_till_01_dam`)
        if DoesEntityExist(brokenCashRegister) then
            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, `prop_till_01_dam`, `prop_till_01`, false)
        end
    end

    CreateThread(
        function()
            while true do
                for i = 1, #Config.Shops do
                    local copsRequired = Config.Shops[i].cops
                    local jurisdiction = Config.Shops[i].jurisdiction

                    if jurisdiction == "lspd" then
                        local cityPolice = (GlobalState.jobCount["lspd"] or 0) + (GlobalState.jobCount["lssd"] or 0)
                        local bAvailable = (cityPolice >= copsRequired) and
                            not GlobalState.forcedCooldown["lspd"] and GlobalState.cooldown["lspd"] == 0 and Config.Shops[i].robbed

                        local blip = Config.Shops[i].blipHandle
                        if DoesBlipExist(blip) then
                            ShowTickOnBlip(blip, bAvailable)
                        end
                    elseif jurisdiction == "sahp" then
                        local bAvailable = (GlobalState.jobCount["sahp"] >= copsRequired) and
                        not GlobalState.forcedCooldown["sahp"] and GlobalState.cooldown["sahp"] == 0 and Config.Shops[i].robbed

                        local blip = Config.Shops[i].blipHandle
                        if DoesBlipExist(blip) then
                            ShowTickOnBlip(blip, bAvailable)
                        end
                    end
                end

                Wait(5000)
            end
        end
    )

    Citizen.CreateThread(function()
        while true do
            for i = 1, #peds do
                if IsPedDeadOrDying(peds[i]) then
                    TriggerServerEvent('loffe_robbery:pedDead', i)
                end
            end
            Wait(5000)
        end
    end)

    while true do
        Wait(5)
        local me = PlayerPedId()
        if IsPedArmed(me, 7) then
            if IsPlayerFreeAiming(PlayerId()) then
                for i = 1, #peds do
                    if HasEntityClearLosToEntityInFront(me, peds[i], 19) and not IsPedDeadOrDying(peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 5.0 then
                        if not robbing then
                            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to rob the store clerk.", true)
                                if IsControlJustPressed(0, 51) then
                                local canRob = nil
                                ESX.TriggerServerCallback('loffe_robbery:canRob', function(cb)
                                    canRob = cb
                                end, i, GetInteriorFromEntity(me))
                                while canRob == nil do
                                    Wait(0)
                                end
                                if canRob == true then
                                    robbing = true
                                    Citizen.CreateThread(function()
                                        while robbing do
                                            local playerPed = PlayerPedId()
                                            local inDistance = #(GetEntityCoords(playerPed) - GetEntityCoords(peds[i])) <=
                                                Config.MaxRobbingDistance
                                            if inDistance and GetInteriorFromEntity(playerPed) ~= 0 and not IsPedDeadOrDying(playerPed) then
                                                if IsPedDeadOrDying(peds[i]) then
                                                    robbing = false
                                                    TriggerServerEvent("loffe_robbery:cancel", i)
                                                end
                                            else
                                                robbing = false
                                                TriggerServerEvent("loffe_robbery:cancel", i)
    
                                                local scaleform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
                                                while not HasScaleformMovieLoaded(scaleform) do
                                                    Citizen.Wait(0)
                                                end
    
                                                BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
                                                PushScaleformMovieMethodParameterString("ROBBERY CANCELLED")
                                                local reason = IsPedDeadOrDying(PlayerPedId()) and "You died." or
                                                    "You walked too far away."
                                                PushScaleformMovieMethodParameterString(reason)
                                                PushScaleformMovieMethodParameterInt(1)
                                                EndScaleformMovieMethod()
    
                                                PlaySoundFrontend(-1, "MP_Flash", "WastedSounds", 1)
    
                                                local endTimer = GetGameTimer() + 5000
                                                while GetGameTimer() < endTimer do
                                                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                                                    Citizen.Wait(0)
                                                end
                                            end
                                            Citizen.Wait(0)
                                        end
                                    end)
                                    
                                    loadDict('missheist_agency2ahands_up')
                                    TaskPlayAnim(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)


                                    if GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 7.5 then
                                        if not IsPedDeadOrDying(peds[i]) then
                                            TriggerServerEvent('loffe_robbery:rob', i, GetStreetAndZone(GetEntityCoords(PlayerPedId())))
                                            while robbing do Wait(0) if IsPedDeadOrDying(peds[i]) then robbing = false end end
                                        end
                                    else
                                        ClearPedTasks(peds[i])
                                        local wait = GetGameTimer()+5000
                                        while wait >= GetGameTimer() do
                                            Wait(0)
                                            DrawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), Translation[Config.Locale]['walked_too_far'])
                                        end
                                        robbing = false
                                    end
                                elseif canRob == "no_cops" then
                                    local wait = GetGameTimer() + 10000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        DrawText3D(
                                            GetOffsetFromEntityInWorldCoords(peds[i], 0.0, 0.0, 1.0),
                                            Translation[Config.Locale]["no_cops"]
                                        )
                                    end
                                elseif canRob == "on_duty" then
                                    local wait = GetGameTimer() + 10000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        DrawText3D(
                                            GetOffsetFromEntityInWorldCoords(peds[i], 0.0, 0.0, 1.0),
                                            "~r~You cannot commit a robbery on your current job.~s~"
                                        )
                                    end
                                elseif canRob == "cooldown_active" then
                                    local wait = GetGameTimer() + 10000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        DrawText3D(
                                            GetOffsetFromEntityInWorldCoords(peds[i], 0.0, 0.0, 1.0),
                                            "~r~Priority cooldown is active!~s~")
                                    end
                                else
                                    TriggerEvent('loffe_robbery:talk', i, '~g~*' .. Translation[Config.Locale]['shopkeeper'] .. '* ~w~' .. Translation[Config.Locale]['robbed'], 5)
                                    Wait(2500)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end
