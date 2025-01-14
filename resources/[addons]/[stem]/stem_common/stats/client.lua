
statsLoaded = false

function ShowStatFeedNotification(title, lastValue, newValue)
    if Config_Skills.Messages[title] then
        if GetResourceKvpInt(title) == 0 then
            SetResourceKvpInt(title, 1)
            ESX.ShowHelpNotification(Config_Skills.Messages[title])
        end
    end

    local handle = RegisterPedheadshot(PlayerPedId())
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Citizen.Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)

    -- Add the notification text
    BeginTextCommandThefeedPost("PS_UPDATE")
    AddTextComponentInteger(newValue)

    -- Set the notification title and progress
    -- local title = "PSF_STAMINA"
    local title = title
    local p1 = 14
    local lastProgress = lastValue
    local newProgress = newValue
    EndTextCommandThefeedPostStats(title, p1, newProgress - lastProgress, lastProgress, false, txd, txd)

    -- Draw the notification
    local showInBrief = true
    local blink = false -- blink doesn't work when using icon notifications.
    EndTextCommandThefeedPostTicker(blink, showInBrief)

    -- Cleanup after yourself!
    UnregisterPedheadshot(handle)

    TriggerServerEvent("stem_common:stats:dbSave")
end

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(1000)
        end

        while not statsLoaded do
            Wait(1000)
        end

        AddStateBagChangeHandler(
            "stats",
            nil,
            function(bagName, key, value, _reserved, replicated)
                if not replicated then
                    return
                end

                local player = GetPlayerFromStateBagName(bagName)
                if player == 0 or player ~= PlayerId() then -- We don't care about other players for now
                    return
                end

                local _, stamina = StatGetInt(GetHashKey("MP0_STAMINA"), 0)
                if value.dist_running ~= nil and ((value.dist_running / 1000) > 0) then
                    local newStamina = math.floor(value.dist_running / 1000) * 5
                    if newStamina > stamina and newStamina > 0 and newStamina <= 100 then
                        StatSetInt(GetHashKey("MP0_STAMINA"), newStamina, true)
                        ShowStatFeedNotification("PSF_STAMINA", stamina, newStamina)
                    end
                elseif value.dist_running == 0 then
                    StatSetFloat(GetHashKey("MP0_DIST_RUNNING"), 0, true)
                    StatSetInt(GetHashKey("MP0_STAMINA"), 0, true)
                end

                local _, strength = StatGetInt(GetHashKey("MP0_STRENGTH"), 0)
                if value.exercises_completed ~= nil and ((value.exercises_completed / 10) > 0) then
                    local newStrength = math.floor(value.exercises_completed / 10) * 5

                    if newStrength > strength and newStrength > 0 and newStrength <= 100 then
                        StatSetInt(GetHashKey("MP0_STRENGTH"), newStrength, true)
                        local multiplier = 0.07 + (0.23 * (newStrength / 100))
                        SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), multiplier)

                        local meleeMultiplier = 0.2 + (0.2 * (newStrength / 100))
                        SetPlayerMeleeWeaponDamageModifier(PlayerId(), meleeMultiplier)

                        ShowStatFeedNotification("PSF_STRENGTH", strength, newStrength)
                    end
                elseif value.exercises_completed == 0 then
                    StatSetInt(GetHashKey("MP0_STRENGTH"), 0, true)
                    SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 0.07)
                    SetPlayerMeleeWeaponDamageModifier(PlayerId(), 0.2)
                end

                local _, stealth = StatGetInt(GetHashKey("MP0_STEALTH_ABILITY"), 0)
                if value.stealth_kills ~= nil and ((value.stealth_kills % 5) == 0) then
                    local newStealth = math.floor(value.stealth_kills) * 4

                    if newStealth > stealth and newStealth > 0 and newStealth <= 100 then
                        local noiseMult = (1.0 - (ToFloat(newStealth) / 100.0))
                        if noiseMult < 0 then
                            noiseMult = 0.01
                        end
                        if noiseMult > 1 then
                            noiseMult = 1.0
                        end
                        SetPlayerNoiseMultiplier(PlayerId(), noiseMult)
                        SetPlayerSneakingNoiseMultiplier(PlayerId(), noiseMult)
                        SetPlayerStealthPerceptionModifier(PlayerId(), noiseMult)

                        StatSetInt(GetHashKey("MP0_STEALTH_ABILITY"), newStealth, true)
                        ShowStatFeedNotification("PSF_STEALTH", stealth, newStealth)
                    end
                elseif value.stealth_kills == 0 then
                    StatSetInt(GetHashKey("MP0_STEALTH_ABILITY"), 0, true)
                    SetPlayerNoiseMultiplier(PlayerId(), 0)
                    SetPlayerSneakingNoiseMultiplier(PlayerId(), 0)
                    SetPlayerStealthPerceptionModifier(PlayerId(), 0)
                end
            end
        )

        local MP0_DIST_RUNNING = GetHashKey("MP0_DIST_RUNNING")
        local _, old_dist_running = StatGetFloat(MP0_DIST_RUNNING, 0)

        while true do
            local plyPed = PlayerPedId()

            if IsPedOnFoot(plyPed) and IsPedSprinting(plyPed) and not LocalPlayer.state.drugged then
                local _, dist_running = StatGetFloat(MP0_DIST_RUNNING, 0)


                if dist_running - old_dist_running > 16.0 then
                    old_dist_running = dist_running

                    local stats = LocalPlayer.state.stats or Config_base_stats
                    stats.dist_running = dist_running

                    LocalPlayer.state:set("stats", stats, true)
                end
            end

            Wait(1000)
        end
    end
)

RegisterNetEvent(
    "stem_common:stats:playerLoaded",
    function(stats)
        if stats then
            StatSetFloat(GetHashKey("MP0_DIST_RUNNING"), stats.dist_running, true)
            local stamina = math.floor(stats.dist_running / 1000.0) * 5
            if stamina > 100 then
                stamina = 100
            end
            if stamina < 0 then
                stamina = 0
            end
            StatSetInt(GetHashKey("MP0_STAMINA"), stamina, true)

            local exercises_completed = stats.exercises_completed
            local strength = math.floor(exercises_completed / 10) * 5
            if strength > 100 then
                strength = 100
            end
            if strength < 0 then
                strength = 0
            end
            StatSetInt(GetHashKey("MP0_STRENGTH"), strength, true)
            local multiplier = 0.07 + (0.23 * (strength / 100))
            SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), multiplier)

            local meleeMultiplier = 0.2 + (0.2 * (strength / 100))
            SetPlayerMeleeWeaponDamageModifier(PlayerId(), meleeMultiplier)

            local stealth_kills = stats.stealth_kills
            local stealth = math.floor(stealth_kills) * 4
            if stealth > 100 then
                stealth = 100
            end
            if stealth < 0 then
                stealth = 0
            end
            StatSetInt(GetHashKey("MP0_STEALTH_ABILITY"), stealth, true)

            local noiseMult = (1.0 - (ToFloat(stealth) / 100.0))
            if noiseMult < 0 then
                noiseMult = 0.01
            end
            if noiseMult > 1 then
                noiseMult = 1.0
            end
            SetPlayerNoiseMultiplier(PlayerId(), noiseMult)
            SetPlayerSneakingNoiseMultiplier(PlayerId(), noiseMult)
            SetPlayerStealthPerceptionModifier(PlayerId(), noiseMult)

            statsLoaded = true
        end
    end
)

AddEventHandler(
    "gameEventTriggered",
    function(event, data)
        if event ~= "CEventNetworkEntityDamage" then
            return
        end

        local victim, attacker, victimDied, weaponHash = data[1], data[2], data[4], data[7]
        if not IsPedAPlayer(victim) or not IsPedAPlayer(attacker) then
            return
        end

        if victimDied then
            if NetworkGetPlayerIndexFromPed(attacker) == PlayerId() then
                if data[7] ~= GetHashKey("WEAPON_UNARMED") and (WasPedKilledByStealth(victim) or WasPedKilledByTakedown(victim)) then
                    local stats = LocalPlayer.state.stats or Config_base_stats
                    stats.stealth_kills = stats.stealth_kills + 

                    LocalPlayer.state:set("stats", stats, true)
                end
            end
        end
    end
)
