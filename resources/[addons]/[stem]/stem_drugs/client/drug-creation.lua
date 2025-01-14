local zones = {}
local in_progress = false

exports.ox_inventory:displayMetadata({
    quality = "Quality",
})

local function load(time, label, animationDictionary, animClip)

	local anim = {}
	if (animClip) then anim["clip"] = animClip end
	if (animationDictionary) then anim["dict"] = animationDictionary end

	return exports.ox_lib:progressCircle({
		duration = time,
		label = label,
		useWhileDead = false,
		canCancel = true,
        anim = anim,
		disable = {
			car = true,
			move = true,
		},
	})
end

function beginProcess (zone, progress) 
    ESX.TriggerServerCallback(
        "stem_drugs:beginProcess",
        function(can)
            if can then
                if (zone.animation?.scenario) then
                    TaskStartScenarioInPlace(PlayerPedId(), zone.animation.scenario, 0, true)
                else
                    TaskPlayAnim(
                        PlayerPedId(),
                        "anim@amb@business@coc@coc_unpack_cut_left@",
                        "coke_cut_v1_coccutter",
                        1.0,
                        1.0,
                        -1,
                        1,
                        0,
                        false,
                        false,
                        false
                    )
                end

                LocalPlayer.state.blockClearTasks = true

                in_progress = true
                Citizen.CreateThread(function () 
                    while in_progress do
                        if (exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(PlayerId()))) then in_progress = false end
                        Citizen.Wait(50)
                    end
                end)
                local progress = load(progress.time, progress.text)
                TriggerServerEvent("stem_drugs:finishProcess", in_progress and progress)
                
                LocalPlayer.state.blockClearTasks = false
                ClearPedTasks(PlayerPedId())
                ClearAllHelpMessages()

            end
        end,
        zone.id
    )
end

function cleanupZones () 
    for key, zone in pairs(zones) do
        exports.ox_target:removeZone(zone)
    end
end

RegisterNetEvent("stem_drugs:setupZones", function (zones, ints) 
    cleanupZones() 
    for key, zone in pairs(zones) do
        if (type(zone) == "table")  then
            local zoneId = exports.ox_target:addBoxZone({
                coords = zone.coords,
                rotation = zone.coords.w,
                -- debug = true,
                size = zone.scale or vector3(1.0, 2.4, 1.0),
                options = {
                    {
                        onSelect = function()
                            beginProcess(zone, zone.progress)
                        end,
                        canInteract = function(ent)
                            return not LocalPlayer.state.blockClearTasks and not IsPedSprinting(PlayerPedId())
                        end,
                        icon = zone.icon,
                        label = zone.text,
                        distance = 1.5
                    }
                }
            })
            table.insert(zones, zoneId)
        end
    end
    -- Citizen.CreateThread(function () 
    --     while true do
    --         for key, value in pairs(ints) do
    --             local entityInterior = GetInteriorFromEntity(PlayerPedId())
    --             local interior = GetInteriorAtCoords(value.intCoords)
    --             if (interior and entityInterior == interior) then
    --                 DoScreenFadeOut(500)
    --                 Citizen.Wait(500)
    --                 SetEntityCoords(PlayerPedId(), value.doorCoords.x, value.doorCoords.y, value.doorCoords.z)
    --                 SetEntityHeading(PlayerPedId(), value.doorCoords.w)
    --                 DoScreenFadeIn(500)
    --                 Citizen.Wait(250)
    --                 ESX.ShowNotification("You were kicked out. Location has changed.")
    --             end
    --         end
    --         Wait(1000)
    --     end
    -- end)
end)

RegisterNetEvent("stem_drugs:kickFromInterior", function (intCoords, doorCoords) 
    local entityInterior = GetInteriorFromEntity(PlayerPedId())
    local interior = GetInteriorAtCoords(intCoords)
    if (interior and entityInterior == interior) then
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        SetEntityCoords(PlayerPedId(), doorCoords.x, doorCoords.y, doorCoords.z)
        SetEntityHeading(PlayerPedId(), doorCoords.w)
        DoScreenFadeIn(500)
        Citizen.Wait(250)
        ESX.ShowNotification("You were kicked out. Location has changed.")
    end
end)

Citizen.CreateThread(function () 
    while not NetworkIsSessionActive() do
        Wait(0)
    end
    LocalPlayer.state.blockClearTasks = false
    RequestAnimDict("anim@amb@business@coc@coc_unpack_cut_left@")
    while not HasAnimDictLoaded("anim@amb@business@coc@coc_unpack_cut_left@") do
        Citizen.Wait(0)
    end

    TriggerServerEvent("stem_drugs:fetchZones")
end)
