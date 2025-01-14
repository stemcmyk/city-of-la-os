function rocketLauncherTick()
    local plyPed = PlayerPedId()
    local weapon = GetSelectedPedWeapon(plyPed)


    if weapon ~= `WEAPON_FIREWORK` and weapon ~= `WEAPON_MUSKET` and weapon ~= `WEAPON_DOUBLEACTION` then
        SetPedInfiniteAmmo(PlayerPedId(), true, weapon)
    end
end

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
    function()
        TriggerServerEvent("shit_purge:isActive")
        while not IsEntityDead(PlayerPedId()) do
            rocketLauncherTick()
    
            Wait(0)
        end
    end
)

RegisterNetEvent("shit_purge:respawn")
AddEventHandler("shit_purge:respawn", function () 
    DoScreenFadeOut(500)
    Wait(500)

    local coords = GetEntityCoords(PlayerPedId())
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, 500.00, false, false, true)
    ClearPedTasksImmediately(PlayerPedId())
    ClearPedTasks(PlayerPedId())
    

    SetPlayerHomingRocketDisabled(PlayerId(), true)
    

    SetTimeout(2000, function()
        while IsEntityInAir(PlayerPedId()) and GetPedParachuteState(PlayerPedId()) == -1 do
            GiveWeaponToPed(PlayerPedId(), `GADGET_PARACHUTE`, 1, false, false)
            SetPlayerHasReserveParachute(PlayerId())
            Wait(0)
        end
        DoScreenFadeIn(200)

        SetPlayerParachuteTintIndex(PlayerId(), 4)
        SetPlayerReserveParachuteTintIndex(PlayerId(), math.random(1, 12))
        SetPlayerCanLeaveParachuteSmokeTrail(PlayerId(), true)
        if math.random() < 0.5 then
            SetPlayerParachuteSmokeTrailColor(PlayerId(), 255, 0, 0)
        else
            SetPlayerParachuteSmokeTrailColor(PlayerId(), 0, 0, 255)
        end

        while IsEntityInAir(PlayerPedId()) do
            local chuteState = GetPedParachuteState(PlayerPedId())
            if chuteState < 2 then
                AddTextEntry('parachuteHelp', "Press ~INPUT_PARACHUTE_DEPLOY~ to deploy parachute.")
                DisplayHelpTextThisFrame('parachuteHelp', false)
            elseif chuteState == 2 then
                AddTextEntry('parachuteHelp',
                    "Press ~INPUT_PARACHUTE_DETACH~ to cut parachute.~n~Press ~INPUT_PARACHUTE_SMOKE~ to deploy smoke trail.")
                DisplayHelpTextThisFrame('parachuteHelp', false)
            end
            Wait(0)
        end
    end)

    local maxTime = GetGameTimer() + 5000
    while HasPedGotWeapon(PlayerPedId(), `WEAPON_FIREWORK`, false) and GetGameTimer() < maxTime do
        RemoveWeaponFromPed(PlayerPedId(), `WEAPON_FIREWORK`)
        Wait(0)
    end

    Citizen.SetTimeout(
        5000,
        function()
            GiveWeaponToPed(PlayerPedId(), `WEAPON_FIREWORK`, math.random(4, 8), false, false)
        end
    )

    while not IsEntityDead(PlayerPedId()) do
        rocketLauncherTick()
        Wait(0)
    end
end)

RegisterNetEvent("shit_purge:EASNotification")
AddEventHandler(
    "shit_purge:EASNotification",
    function()
        Citizen.CreateThread(
            function()
                SetPlayerHomingRocketDisabled(PlayerId(), true)
                GiveWeaponToPed(PlayerPedId(), `WEAPON_FIREWORK`, math.random(4, 8), false, false)

                while not IsEntityDead(PlayerPedId())  do
                    local plyPed = PlayerPedId()
                    local weapon = GetSelectedPedWeapon(plyPed)

                    if weapon ~= `WEAPON_FIREWORK` and weapon ~= `WEAPON_MUSKET` and weapon ~= `WEAPON_DOUBLEACTION` then
                        SetPedInfiniteAmmo(PlayerPedId(), true, weapon)
                    end

                    Wait(0)
                end
            end
        )

        SendNUIMessage(
            {
                type = "alert",
                enable = true,
                issuer = "U.S. Government",
                message =
                "This is not a test. This is your Emergency Broadcast System. Announcing the commencement of the annual purge sanctioned by the U.S. Government.",
                volume = Config.EAS.Volume
            }
        )
    end
)
