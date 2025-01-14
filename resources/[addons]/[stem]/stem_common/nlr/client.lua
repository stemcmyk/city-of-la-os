NLR_BLIPS = {}

RegisterNetEvent(
    "stem_common:nlr:createBlip",
    function(coords)
        local blip = AddBlipForRadius(coords.x, coords.y, coords.z, Config_AntiNLR.CannotReturnDist)
        SetBlipAlpha(blip, 128)
        SetBlipColour(blip, 1)
        SetBlipHiddenOnLegend(blip, true)
        SetBlipRotation(blip, 0)
        SetBlipFlashes(blip, true)
        SetBlipFlashTimer(blip, 30000)

        NLR_BLIPS[#NLR_BLIPS + 1] = blip
    end
)

RegisterNetEvent("stem_common:nlr:removeBlip", function(coords)
    for k, v in pairs(NLR_BLIPS) do
        local blip = v

        if DoesBlipExist(blip) then
            if #(GetBlipInfoIdCoord(blip) - coords) < 1.0 then
                RemoveBlip(blip)
                NLR_BLIPS[k] = nil

                return
            end
        else
            NLR_BLIPS[k] = nil
        end
    end
end)

RegisterNetEvent(
    "stem_common:nlr:violation",
    function()
        SetEntityHealth(PlayerPedId(), 0)
    end
)

RegisterNetEvent("stem_common:nlr:policeRespawn", function (job)
    local input = lib.alertDialog({
        header = "Would you like to respawn at your station?",
        content = "This will teleport you",
        cancel = true,
        centered = true,
        labels = {
            cancel = "No",
            confirm = "Yes"
        }
    })
    if (input == "cancel") then return end
    DoScreenFadeOut(500)
    Wait(500)
    local coords = Config_AntiNLR.policeStations[job]
    SetEntityCoords(PlayerPedId(), coords)
    SetEntityHeading(coords.w)
    DoScreenFadeIn(500)
end)

ESX.RegisterClientCallback("stem_common:getZoneAtCoords", function (cb, coords)
    cb(GetNameOfZone(coords))
end)