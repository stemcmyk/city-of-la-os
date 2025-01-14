-- VARIABLES --

local config = {}

local vars = {
    BandagesActive = false,
    BandagesType = 0,
    BandagesAreInTable = false
}

-- DEBUG INFO --

function GetBandagesDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

-- GET CONFIG --

RegisterNetEvent("c_GetBandages_ConfigSet")
AddEventHandler(
    "c_GetBandages_ConfigSet",
    function(configSent)
        config = configSent
        FirstAidDebug(
            "c_GetBandages_ConfigSet",
            "Config sent, debug status: ",
            "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug)
        )
    end
)

-- GET NEAREST --

function GetNearestAbleVehicle()
    local ped = PlayerPedId()
    local carGamePool = GetGamePool("CVehicle")
    local plrCoords = GetEntityCoords(ped)
    local plrHeading = GetEntityHeading(ped)

    if config.UseVehicleClass == true then
        for i, v in pairs(carGamePool) do
            local carCoords = GetEntityCoords(v)
            local carHeading = GetEntityHeading(v)
            local dist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], carCoords[1], carCoords[2], carCoords[3], false)

            if dist <= 5.0 and GetVehicleClass(v) == 18 and (carHeading >= plrHeading + 10 or carHeading >= plrHeading - 10) then
                GetBandagesDebug("GetNearestAbleVehicle", "Car Heading: " .. tostring(carHeading), ". Player Heading: " .. tostring(plrHeading))

                local bone = GetEntityBoneIndexByName(v, "platelight")

                if bone == -1 then
                    bone = GetEntityBoneIndexByName(v, "boot")
                    if bone == -1 then
                        GetBandagesDebug(
                            "GetNearestAbleVehicle",
                            "FATAL ERROR",
                            "Unable to get car platelight or boot. Terminating GetNearestAbleVehicle function."
                        )
                        return
                    end
                end

                local boneCoords = GetWorldPositionOfEntityBone(v, bone)
                local boneDist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], boneCoords[1], boneCoords[2], boneCoords[3], false)

                if boneDist <= 1.5 and GetVehicleDoorAngleRatio(v, 5) >= 0.50 then
                    GetBandagesDebug("GetNearestAbleVehicle", "Door Angle Ratio: ", GetVehicleDoorAngleRatio(v, 5))
                    GetBandagesDebug("GetNearestAbleVehicle", "Distance: ", boneDist)
                    GetBandagesDebug("GetNearestAbleVehicle", "Banadge Type: ", config.CarBandageType)

                    if config.CarBandageType == nil then
                        GetBandagesDebug("GetNearestAbleVehicle", "FATAL ERROR: ", "Bandage type is nil, terminating.")
                    else
                        vars.BandagesType = config.CarBandageType
                        vars.BandagesAreInTable = true
                    end

                    vars.BandagesType = config.CarBandageType
                    vars.BandagesAreInTable = false

                    return true
                else
                    GetBandagesDebug("GetNearestAbleVehicle", "Door Angle Ratio: ", GetVehicleDoorAngleRatio(v, 5))
                    GetBandagesDebug("GetNearestAbleVehicle", "Distance: ", boneDist)

                    return false
                end
            end
        end
    else
        for i, v in pairs(carGamePool) do
            local carCoords = GetEntityCoords(v)
            local carHeading = GetEntityHeading(v)
            local dist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], carCoords[1], carCoords[2], carCoords[3], false)
            local isInTable = false
            local TempBTS = 0

            for i2, v2 in pairs(config.CarsAbleToGiveFirstAid) do
                if v2.Name == GetEntityModel(v) then
                    isInTable = true
                    TempBTS = v2.BandageType
                end
            end

            if dist <= 5.0 and isInTable ~= nil and (carHeading >= plrHeading + 10 or carHeading >= plrHeading - 10) then
                isInTable = false

                GetBandagesDebug("GetNearestAbleVehicle", "Car Heading: " .. tostring(carHeading), ". Player Heading: " .. tostring(plrHeading))

                local bone = GetEntityBoneIndexByName(v, "platelight")

                if bone == -1 then
                    bone = GetEntityBoneIndexByName(v, "boot")
                    if bone == -1 then
                        GetBandagesDebug(
                            "GetNearestAbleVehicle",
                            "FATAL ERROR",
                            "Unable to get car platelight or boot. Terminating GetNearestAbleVehicle function."
                        )
                        return
                    end
                end

                local boneCoords = GetWorldPositionOfEntityBone(v, bone)
                local boneDist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], boneCoords[1], boneCoords[2], boneCoords[3], false)

                if boneDist <= 1.5 and GetVehicleDoorAngleRatio(v, 5) >= 0.50 then
                    GetBandagesDebug("GetNearestAbleVehicle", "Door Angle Ratio: ", GetVehicleDoorAngleRatio(v, 5))
                    GetBandagesDebug("GetNearestAbleVehicle", "Distance: ", boneDist)
                    GetBandagesDebug("GetNearestAbleVehicle", "Banadge Type: ", TempBTS)

                    if TempBTS == nil then
                        GetBandagesDebug("GetNearestAbleVehicle", "FATAL ERROR: ", "Bandage type is nil, terminating.")
                    else
                        vars.BandagesType = TempBTS
                        vars.BandagesAreInTable = true
                    end

                    return true
                else
                    GetBandagesDebug("GetNearestAbleVehicle", "Door Angle Ratio: ", GetVehicleDoorAngleRatio(v, 5))
                    GetBandagesDebug("GetNearestAbleVehicle", "Distance: ", boneDist)

                    return false
                end
            end
        end
    end
end

function GetNearestStore()
    local ped = PlayerPedId()
    local plrCoords = GetEntityCoords(ped)

    for i, v in pairs(config.StoreLocations) do
        local dist = GetDistanceBetweenCoords(plrCoords[1], plrCoords[2], plrCoords[3], v.x, v.y, v.z, false)
        if dist <= v.MaxDist then
            return true
        end
    end
end

function GetPlayers()
    local players = {}
    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local plrCoords = GetEntityCoords(PlayerPedId(), 0)

    for i, v in ipairs(players) do
        local target = GetPlayerPed(v)

        if (target ~= PlayerPedId()) then
            local targetCoords = GetEntityCoords(GetPlayerPed(v), 0)
            local distance = Vdist(targetCoords[1], targetCoords[2], targetCoords[3], plrCoords[1], plrCoords[2], plrCoords[3])
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = v
                closestDistance = distance
            end
        end
    end

    if closestDistance <= 2.0 then
        return closestPlayer
    end
end
