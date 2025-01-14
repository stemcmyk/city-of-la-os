-- VARIABLES --

local config = {}

local neverFatal = {
    [-842959696] = true,
    [-10959621] = true,
    [1936677264] = true
}

local currentHospital = {
    hosOutX,
    hosOutY,
    hosOutZ,
    hosOutH
}

local didPlayerDie = false

-- DEBUG INFO --

function FirstAidDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

-- GET CONFIG --

RegisterNetEvent("c_FirstAid_ConfigSet")
AddEventHandler(
    "c_FirstAid_ConfigSet",
    function(configSent)
        config = configSent
        FirstAidDebug(
            "c_FirstAid_ConfigSet",
            "Config sent, debug status: ",
            "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug)
        )
    end
)

-- DEATH --
AddEventHandler(
    "playerDiedFromMalpractice",
    function()
        didPlayerDie = true
    end
)

function IsPlayerFatal(boneInfo)
    if boneInfo.Fatal then
        return true
    end

    if boneInfo.Artery then
        local ArteryOdds = boneInfo.ArteryOdds
        if math.random(ArteryOdds.Odd1, ArteryOdds.Odd2) <= ArteryOdds.Odd1 then
            return true
        end
    end

    return false
end

-- HOSPITAL AID --

function HospitalAid(hospital)
    LocalPlayer.state.inHospital = true
    local ped = PlayerPedId()
    local RandomMalpractice = math.random(1, 100000)
    local RandomLossAndRevival = math.random(1, 10)
    didPlayerDie = false

    local origArmor = GetPedArmour(ped)

    FirstAidDebug("HospitalAid", "Triggering BlackScreen.", "")
    TriggerEvent("client_effects_blackscreen", true)

    FirstAidDebug("HospitalAid", "Freezing player.", "")
    FreezeEntityPosition(ped, true)

    FirstAidDebug("HospitalAid", "Making player invisible.", "")
    SetEntityVisible(ped, false, false)

    DetachEntity(ped, true, false)
    TriggerEvent("esx_ambulancejob:forceUndrag")

    if RandomMalpractice == 1 then
        FirstAidDebug("HospitalAid", "Triggering Heartbeat Monitor Beeping.", "Malpractice in play.")
        TriggerEvent("client_effects_heartmonitor", true, true, 1000, true)
        didPlayerDie = true
        Citizen.CreateThread(function() 
            Wait(config.HopistalWorkTime)
            TriggerServerEvent("wasabi_ambulance:hospitalResult", hospital, false)
            exports["mythic_notify"]:SendAlert("error", "You died to medical malpractice.", 5000)
        end)
    else
        local deathCause = GetPedCauseOfDeath(ped)
        local hit, bone = GetPedLastDamageBone(ped)
        local boneInfo = exports["GunshotWound"]:getBoneFromTable(bone)
        local timerPercentRm = exports["wasabi_ambulance"]:getCheckInTimer()

        local baseChance = 0.25
        local survivability = baseChance + timerPercentRm
        if survivability > 1.0 then
            survivability = 0.9
        end

        if
            not neverFatal[deathCause] and (boneInfo ~= nil and IsPlayerFatal(boneInfo)) or (math.random() >= math.min(survivability, 0.9)) or
                LocalPlayer.state.isFatal
            then
            FirstAidDebug("HospitalAid", "Triggering Heartbeat Monitor Beeping.", "Fatal wounds in play.")
            TriggerEvent("client_effects_heartmonitor", true, false, math.random(1000, 1250), true)
            didPlayerDie = true
            Citizen.CreateThread(function() 
                Wait(config.HopistalWorkTime)
                TriggerServerEvent("wasabi_ambulance:hospitalResult", hospital, false)
                lib.notify({
                    type = "error",
                    title =  "You died to your injuries at the hospital.",
                    duration = 30000
                })
            end)
        else
            FirstAidDebug("HospitalAid", "Triggering Heartbeat Monitor Beeping.", "Nothing in play.")
            TriggerEvent("client_effects_heartmonitor", true, false, math.random(1000, 1250), false)
            Citizen.CreateThread(function() 
                Wait(config.HopistalWorkTime)
                TriggerServerEvent("wasabi_ambulance:hospitalResult",  hospital, true)
                if origArmor > 0 then
                    SetPedArmour(PlayerPedId(), origArmor)
                end
            end)
        end
    end

    Citizen.CreateThread(
        function()
            local maxTime = GetGameTimer() + config.HopistalWorkTime
            while GetGameTimer() < maxTime do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
        end
    )

    Wait(config.HopistalWorkTime)

    if didPlayerDie == true then
        SetEntityCoords(ped, 293.57, -1350.19, 24.54, false, false, false, false)
        SetEntityHeading(ped, 321.18)

        SetEntityVisible(ped, true, false)

        FreezeEntityPosition(ped, false)

        TriggerEvent("esx_policejob:unrestrain")
        TriggerEvent("client_effects_blackscreen", false)
        TriggerEvent("client_effects_heartmonitor", false, false, 600, false)
        TriggerServerEvent("esx_ambulancejob:setDeathStatus", true)

        Wait(config.HospitalUsageDelay)
    else
        SetEntityHealth(ped, 200)

        SetEntityCoords(ped, currentHospital.hosOutX, currentHospital.hosOutY, currentHospital.hosOutZ, false, false, false, false)
        SetEntityHeading(ped, currentHospital.hosOutH)

        NetworkResurrectLocalPlayer(currentHospital.hosOutX, currentHospital.hosOutY, currentHospital.hosOutZ, currentHospital.hosOutH, true, false)

        TriggerEvent("playerSpawned", currentHospital.hosOutX, currentHospital.hosOutY, currentHospital.hosOutZ)

        -- StopScreenEffect("DeathFailOut")
        AnimpostfxStopAll()

        ClearPedBloodDamage(ped)

        SetEntityVisible(ped, true, false)

        FreezeEntityPosition(ped, false)

        TriggerEvent("client_effects_blackscreen", false)
        TriggerEvent("client_effects_heartmonitor", false, false, 600, false)
        TriggerServerEvent("sysValueReset")

        Citizen.CreateThread(function() 
            Wait(config.HopistalWorkTime)

            TriggerServerEvent("esx_ambulancejob:setDeathStatus", false)
        end)

        Wait(config.HospitalUsageDelay)
    end

    LocalPlayer.state.inHospital = false
end

function GetClosestHospital()
    --FirstAidDebug("GetClosestHospital", "Getting closest hospital.", "")

    local ped = PlayerPedId()
    local plrCoords = GetEntityCoords(ped)

    for i, v in pairs(config.Hospitals) do
        local dist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], v.x, v.y, v.z, false)

        --FirstAidDebug("GetClosestHospital", "Distance: ", dist)

        if dist <= v.MaxDist then
            currentHospital.hosOutX = v.outX
            currentHospital.hosOutY = v.outY
            currentHospital.hosOutZ = v.outZ
            currentHospital.hosOutH = v.outH

            --FirstAidDebug("GetClosestHospital", "Player is within maximum distance to a hospital.", "")

            return true
        end
    end
end

function CheckInClosestPlayer()
    local myCoords = GetEntityCoords(PlayerPedId())
    local pool = GetGamePool("CPed")
    local closestPed, closestDist = nil, 10.0
    for i = 1, #pool do
        local ped = pool[i]
        if DoesEntityExist(ped) and IsPedAPlayer(ped) and IsPedDeadOrDying(ped, true) and IsEntityVisible(ped) and ped ~= PlayerPedId() then
            local dist = #(GetEntityCoords(ped) - myCoords)
            if dist < closestDist then
                closestDist = dist
                closestPed = ped
            end
        end
    end

    if closestPed then
        local player = NetworkGetPlayerIndexFromPed(closestPed)
        if player ~= PlayerId() then
            TriggerServerEvent("hospital:checkInPlayer", GetPlayerServerId(player))
        end
    else
        exports["mythic_notify"]:SendAlert("error", "No player nearby to check in.", 5000)
    end
end

RegisterNetEvent("FirstAid:CheckIn")
AddEventHandler(
    "FirstAid:CheckIn",
    function(hopsital)
        HospitalAid(hopsital)
    end
)
