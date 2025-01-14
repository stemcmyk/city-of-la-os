RegisterNetEvent("stem_common:warp:teleport", function (coords) 
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(1000)
    Wait(1000)
    local retval, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, true)
    SetEntityCoords(PlayerPedId(), vector3(coords.x, coords.y, groundZ), false, false, false, false)
    SetEntityHeading(coords.w)
    DoScreenFadeIn(1000)
    FreezeEntityPosition(PlayerPedId(), false)
end)


Citizen.CreateThread(function () 
    while not LocalPlayer.state.switchComplete do 
        Wait(100)
    end
    for baseWarpKey, baseWarp in pairs(Config_Warp.Warps) do
        if (#baseWarp.warps > 0) then
            for baseWarpIndex, value in pairs(baseWarp.warps) do
                local options = exports.stem_common:tableMap(baseWarp.warps, function (warp, warpIndex) 
                    if (baseWarpIndex ~= warpIndex) then
                        return {
                            label = warp.label,
                            distance = 2,
                            icon = warp.icon or "fa-solid fa-circle-chevron-right",
                            serverEvent = "stem_common:warp:useWarp",
                            warpKey = baseWarpKey,
                            warpIndex = warpIndex,
                            groups = baseWarp.jobs
                        }
                    end 
                    return false
                end)
                exports.ox_target:addBoxZone({
                    coords = value.coords,
                    size = vector3(3,0.8,2),
                    -- debug = true,
                    rotation = value.coords.w,
                    drawSprite = true,
                    options = exports.stem_common:tableFilter(options, function (data)
                        return data ~= false;
                    end),
                })
            end
        end
    end
end)