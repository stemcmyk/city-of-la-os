local distDrawOverhead = 15
local idoverhead_GangZones = {
    ["CHAMH"] = true,
    ["DAVIS"] = true,
    ["RANCHO"] = true
}

local function idoverhead_DrawText3D(x, y, z, text, r, g, b)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px, py, pz) - vector3(x, y, z))

    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    if onScreen then
        if not useCustomScale then
            SetTextScale(0.0 * scale, 0.55 * scale)
        else
            SetTextScale(0.0 * scale, customScale)
        end
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

CreateThread(
    function()
        while not NetworkIsSessionActive() do
            Wait(1000)
        end

        while true do
            local playerPed = PlayerPedId()
            local nuiFocused = IsNuiFocused()
            if
                (IsUsingKeyboard(0) and IsControlPressed(0, 170)) or exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerPed))) or IsPedRagdoll(playerPed) or IsPedGettingUp(playerPed) or
                    IsNuiFocused()
             then
                local myCoords = GetEntityCoords(playerPed)
                local zone = GetNameOfZone(myCoords.x, myCoords.y, myCoords.z)

                local minTime = 30000
                if idoverhead_GangZones[zone] then
                    minTime = 120000
                end

                local canDisplay = true
                if LocalPlayer.state.lastShotTime ~= nil then
                    canDisplay = false
                    if ((GetGameTimer() - LocalPlayer.state.lastShotTime) > minTime) then
                        canDisplay = true
                    end

                    if exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerPed))) or IsPedRagdoll(playerPed) or IsPedGettingUp(playerPed) then
                        canDisplay = true
                    end
                end

                if LocalPlayer.state.inHostileZone then
                    canDisplay = false
                end

                if LocalPlayer.state.alwaysDisplayOverhead then
                    canDisplay = true
                end

                if canDisplay then
                    if not LocalPlayer.state.cameraMode then
                        for _, id in ipairs(GetActivePlayers()) do
                            local ped = GetPlayerPed(id)
                            if ped ~= playerPed then
                                local dist = #(GetEntityCoords(ped) - myCoords)

                                if (dist < (nuiFocused and 3.0 or distDrawOverhead)) then
                                    local x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))

                                    local curVehicle = GetVehiclePedIsIn(ped, false)
                                    if DoesEntityExist(curVehicle) then
                                        for seatIndex = -1, 6 do
                                            if GetPedInVehicleSeat(curVehicle, seatIndex) == ped then
                                                local min, max = GetModelDimensions(GetEntityModel(curVehicle))

                                                local zOffset = max.z
                                                local normalIndex = seatIndex + 2
                                                zOffset = zOffset + (normalIndex * 0.15)

                                                local display = string.format("~b~%d:~s~ %d", seatIndex, GetPlayerServerId(id))

                                                local vehCoords = GetEntityCoords(curVehicle)

                                                if NetworkIsPlayerTalking(id) then
                                                    idoverhead_DrawText3D(vehCoords.x, vehCoords.y, vehCoords.z + zOffset, display, 247, 124, 24)
                                                else
                                                    idoverhead_DrawText3D(vehCoords.x, vehCoords.y, vehCoords.z + zOffset, display, 255, 255, 255)
                                                end
                                            end
                                        end
                                    else
                                        if IsControlPressed(0, 170) or nuiFocused then
                                            local camera = GetGameplayCamCoord()
                                            local shapetest = StartShapeTestCapsule(camera.x, camera.y, camera.z, x2, y2, z2, 0.05, 31, playerPed, 7)

                                            local result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapetest)
                                            if result ~= 2 then
                                                repeat
                                                    result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapetest)
                                                until result == 2
                                            end

                                            if entityHit == ped then -- Ped is visible, show ID overhead
                                                if NetworkIsPlayerTalking(id) then
                                                    idoverhead_DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 247, 124, 24)
                                                else
                                                    idoverhead_DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 255, 255, 255)
                                                end
                                            end
                                        else
                                            if NetworkIsPlayerTalking(id) then
                                                idoverhead_DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 247, 124, 24)
                                            else
                                                idoverhead_DrawText3D(x2, y2, z2 + 1, GetPlayerServerId(id), 255, 255, 255)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            Wait(0)
        end
    end
)
