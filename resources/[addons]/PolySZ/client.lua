local safezones = {
}

local HighCrimeZones = {
    BoxZone:Create(vector3(1447.2, 6362.37, 23.9), 291.79999999999, 118.0, {
        name = "MethZone",
        heading = 74,
        -- debugPoly=true
    }),
    CircleZone:Create(
        vector3(4840.94, -5123.38, 10.15),
        1200.0,
        {
            name = "CayoPerico",
            useZ = false
        }
    ),
    CircleZone:Create(
        vector3(3040.2, -4683.16, 15.26),
        400.0,
        {
            name = "AircraftCarrier",
            useZ = true
            --debugPoly=true
        }
    ),
}

local EmoteDisabledZones = {
}

local DrugZones = {
}

local morguePZ =
    BoxZone:Create(
        vector3(292.26, -1348.43, 24.54),
        14.0,
        19.2,
        {
            name = "MorgueInterior",
            heading = 230
            --debugPoly=true
        }
    )

local inSafeZone = false
local recentlyShot = false
local firstSpawn = true
local lastShotTime = 0
GangWarNotificationDisplayed = false

function loadZones()
    if firstSpawn then
        lastShotTime = GetGameTimer() - 300000
        for i = 1, #safezones, 1 do
            safezones[i]:onPlayerInOut(
                function(isPointInside, point)
                    if GlobalState.purgeActive then
                        return
                    end

                    if not firstSpawn then
                        if GetGameTimer() - lastShotTime < 300000 then
                            recentlyShot = true
                        else
                            recentlyShot = false
                        end

                        inSafeZone = isPointInside

                        if inSafeZone then
                            if recentlyShot or safezones[i].isDisabled then
                                exports["mythic_notify"]:PersistentAlert(
                                    "start",
                                    "Safezone_" .. i,
                                    "error",
                                    recentlyShot and "⚠️ Safezone Inactive - Recently Shot" or
                                    "⚠️ Safezone Inactive - Temp. Disabled"
                                )
                            else
                                exports["mythic_notify"]:SendAlert("success", "You entered a safezone")
                            end
                        else
                            exports["mythic_notify"]:PersistentAlert("end", "Safezone_" .. i)
                            exports["mythic_notify"]:SendAlert("inform", "You left a safezone")
                        end
                    else
                        if isPointInside then
                            inSafeZone = true
                            exports["mythic_notify"]:SendAlert("success", "You spawned in a safezone")
                        end

                        if i == #safezones then
                            firstSpawn = false
                        end
                    end
                end
            )
        end


        for i = 1, #HighCrimeZones do
            HighCrimeZones[i]:onPlayerInOut(
                function(isPointInside, point)
                    LocalPlayer.state:set("inHostileZone", isPointInside, true)
                    if isPointInside then
                        SetEntityVisible(PlayerPedId(), true, 0)
                        
                        print("ass")

                        exports["mythic_notify"]:PersistentAlert("start", "HighCrimeZone_" .. i, "error",
                            "☠️ Hostile Area")
                    else
                        exports["mythic_notify"]:PersistentAlert("end", "HighCrimeZone_" .. i)
                    end
                end
            )
        end

        local insideDisabledZone = false
        for i = 1, #EmoteDisabledZones do
            EmoteDisabledZones[i]:onPlayerInOut(
                function(isPointInside, point)
                    if isPointInside then
                        insideDisabledZone = true
                    end
                    LocalPlayer.state:set("syncedEmotesDisabled", isPointInside, true)
                end
            )
        end

        if insideDisabledZone then
            LocalPlayer.state:set("syncedEmotesDisabled", true, true)
        end
    end

    local plyPed = PlayerPedId()
    local coords = GetEntityCoords(plyPed)

    local b = morguePZ:isPointInside(coords)
    if b then
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetEntityCoords(plyPed, 338.46, -1394.21, 32.51, false, false, false, false)
        SetEntityHeading(plyPed, 56.20)
        Citizen.Wait(5000)
        DoScreenFadeIn(1000)
    end

    if GlobalState.purgeActive then
        lib.notify({
            title = "Spawn protection active",
            duration = 20000,
            type = "success"
        })

        local origSpawn = GetEntityCoords(PlayerPedId())
        local endTime = GetGameTimer() + 10000
        NetworkSetFriendlyFireOption(false)
        SetEntityAlpha(PlayerPedId(), 153, false)
        while GetGameTimer() < endTime do
            if #(GetEntityCoords(PlayerPedId()).xy - origSpawn.xy) > 0.5 then
                break
            end

            if IsPlayerFreeAiming(PlayerId()) then
                break
            end

            NetworkSetFriendlyFireOption(false) -- Needs to be called every frame for some reason, otherwise player doesn't have protection
            Citizen.Wait(0)
        end
        ResetEntityAlpha(PlayerPedId())
        NetworkSetFriendlyFireOption(true)
        lib.notify({
            title = "Spawn protection expired",
            duration = 20000,
            type = "error"
        })
    end
end

AddEventHandler(
    "playerSpawned",
    function()
        loadZones()
    end
)

RegisterNetEvent(
    "PolySZ:deactivateZone",
    function(zoneName)
        local coords = GetEntityCoords(PlayerPedId())
        for i = 1, #safezones do
            if safezones[i].name == zoneName then
                if not safezones[i].isDisabled then
                    safezones[i].isDisabled = true

                    if safezones[i]:isPointInside(coords) then
                        inSafeZone = false
                        lib.notify({
                            title = "🚨 Safezone Disabled By Police",
                            duration = 10000,
                            type = "info"
                        })
                    end

                    Citizen.SetTimeout(
                        300000,
                        function()
                            safezones[i].isDisabled = false
                        end
                    )
                end
            end
        end
    end
)
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(10)

            local isShooting = IsPedShooting(PlayerPedId())
            if isShooting then
                if inSafeZone then
                    lib.notify({
                        title = "You are in a safezone and cannot damage other players.",
                        type = "error"
                    })
                end
                lastShotTime = GetGameTimer()
                LocalPlayer.state.lastShotTime = lastShotTime
            end

            if GlobalState.purgeActive then
                return
            end

            if GlobalState.gangWar then
                local coords = GetEntityCoords(PlayerPedId())
                local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)

                local involved = LocalPlayer.state.gangWar

                if zoneName == "CHAMH" or zoneName == "DAVIS" or zoneName == "RANCHO" or zoneName == "STRAW" then
                    if not GangWarNotificationDisplayed then
                        GangWarNotificationDisplayed = true
                        SetTimeout(60000, function()
                            GangWarNotificationDisplayed = false
                        end)

                        local gangWL = LocalPlayer.state.gangWhitelisted
                        if gangWL and not involved then
                            ESX.ShowHelpNotification(GlobalState.GangWar.aggressorLabel ..
                                ' is currently in an active gang war with ' ..
                                GlobalState.GangWar.targetLabel ..
                                '. You are not involved in this war and ineligible to participate. ~r~Interfering with an active war will result in an automatic punishment.')
                        end
                    end

                    if not LocalPlayer.state.inHostileZone and involved then
                        SetEntityVisible(PlayerPedId(), true, 0)

                        exports["mythic_notify"]:PersistentAlert("start", "GangWar_Hostile", "error", "☠️ Hostile Area")

                        LocalPlayer.state:set("inHostileZone", true, true)
                        LocalPlayer.state:set("syncedEmotesDisabled", true, true)
                    end
                else
                    if LocalPlayer.state.inHostileZone and involved then
                        exports["mythic_notify"]:PersistentAlert("end", "GangWar_Hostile")
                        LocalPlayer.state:set("inHostileZone", false, true)
                        LocalPlayer.state:set("syncedEmotesDisabled", false, true)
                    end
                end
            elseif LocalPlayer.state.inHostileZone then
                local coords = GetEntityCoords(PlayerPedId())
                local zoneName = GetNameOfZone(coords.x, coords.y, coords.z)


                if zoneName == "CHAMH" or zoneName == "DAVIS" or zoneName == "RANCHO" or zoneName == "STRAW" then
                    exports["mythic_notify"]:PersistentAlert("end", "GangWar_Hostile")
                    LocalPlayer.state:set("inHostileZone", false, true)
                    LocalPlayer.state:set("syncedEmotesDisabled", false, true)
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Citizen.Wait(0)
        end

        NetworkSetFriendlyFireOption(true)

        while true do
            Citizen.Wait(0)

            if inSafeZone then
                if not recentlyShot then
                    NetworkSetFriendlyFireOption(false)
                end
                DisableControlAction(0, 69, true)  -- INPUT_VEH_ATTACK
                DisableControlAction(0, 70, true)  -- INPUT_VEH_ATTACK2
                DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
                DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
                DisableControlAction(0, 106, true) -- INPUT_VEH_MOUSE_CONTROL_OVERRIDE
            else
                NetworkSetFriendlyFireOption(true)
            end

            if GlobalState.purgeActive then
                NetworkSetFriendlyFireOption(true)
                return
            end
        end
    end
)

CreateThread(function()
    exports.qtarget:AddCircleZone("StockExchange1", vector3(-1010.2, -423.39, 54.87), 0.5, {
            name = "StockExchange1",
            useZ = true,
            -- debugPoly = true
        },
        {
            options = {
                {
                    action = function()
                        exports['noire_nui']:OpenTradingRegisterMenu()
                    end,
                    icon = "fas fa-clipboard",
                    label = "Create Account",
                },
                {
                    event = "noire_nui:openTrading",
                    icon = "fas fa-clipboard",
                    label = "Open Website",
                },
            },
            distance = 1.5
        }
    )

    exports.qtarget:AddCircleZone("StockExchange_2", vector3(-999.65, -417.05, 54.87), 0.49, {
            name = "StockExchange_2",
            useZ = true,
            --debugPoly=true
        },
        {
            options = {
                {
                    action = function()
                        exports['noire_nui']:OpenTradingRegisterMenu()
                    end,
                    icon = "fas fa-clipboard",
                    label = "Create Account",
                },
                {
                    event = "noire_nui:openTrading",
                    icon = "fas fa-clipboard",
                    label = "Open Website",
                },
            },
            distance = 1.5
        }
    )

    exports.qtarget:AddCircleZone("StockExchange_3", vector3(-1002.02, -414.16, 54.87), 0.47, {
            name = "StockExchange_3",
            useZ = true,
            --debugPoly=true
        },
        {
            options = {
                {
                    action = function()
                        exports['noire_nui']:OpenTradingRegisterMenu()
                    end,
                    icon = "fas fa-clipboard",
                    label = "Create Account",
                },
                {
                    event = "noire_nui:openTrading",
                    icon = "fas fa-clipboard",
                    label = "Open Website",
                },
            },
            distance = 1.5
        }
    )
end)

function IsPedInAnySafeZone()
    local inZone = false
    local coords = GetEntityCoords(PlayerPedId())
    for i = 1, #safezones do
        if safezones[i]:isPointInside(coords) then
            inZone = true
            break
        end
    end
    return inZone
end

function GetSafeZonePedIsIn()
    local coords = GetEntityCoords(PlayerPedId())
    for i = 1, #safezones do
        if safezones[i]:isPointInside(coords) then
            return safezones[i].name
        end
    end

    return nil
end

function IsPedInForumZone()
    local coords = GetEntityCoords(PlayerPedId())
    for i = 1, #DrugZones do
        if DrugZones[i]:isPointInside(coords) then
            return true
        end
    end

    return false
end

function SetSafeZone(value)
    inSafeZone = value
end

AddEventHandler("onResourceStart", function (resource) 
    if (resource ~= GetCurrentResourceName()) then return end
    loadZones()
end)

exports("IsPedInAnySafeZone", IsPedInAnySafeZone)
exports("GetSafeZonePedIsIn", GetSafeZonePedIsIn)
exports("IsPedInForumZone", IsPedInForumZone)
exports("SetSafeZone", SetSafeZone)
