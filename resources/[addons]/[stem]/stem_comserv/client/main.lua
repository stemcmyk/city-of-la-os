local active = nil
local inService = false
local existingActions
local targetList = {}
local drawMarker = false
local markerData = nil
local isSweeping = false

ESX.RegisterClientCallback("stem_comserv:getReason", function (cb) 
	local input = lib.inputDialog("Community Service Details.", {
		{
			type = "number",
			label = "Total Sweeps",
			icon = "fa-solid fa-broom",
		},
		{
			type = "textarea",
			label = "Reason",
		},
		{
			type = "input",
			label = "Evidence (Like a clip)"
		},
	})

	if (not input) then return cb(nil) end
	cb(input[1], input[2], input[3])
end)

RegisterNetEvent('stem_comserv:finishSentence' , function()
	active = false
	inService = false
	releaseZone()
end)

RegisterNetEvent('stem_comserv:beginSentence', function(count)
	tpToZone()
	existingActions = count
	inService = true
	startActions()
end)

local target;
startActions = function()
	local indexNumber = math.random(1,#Config.ServiceLocations)
	
	drawMarker = true
	markerData = Config.ServiceLocations[indexNumber].coords.xyz

	if target then exports.ox_target:removeZone(target) end
	target = exports.ox_target:addSphereZone({
		coords = Config.ServiceLocations[indexNumber].coords.xyz,
		radius = 1,
		options = {
			{
				name = 'sweep',
				onSelect = targetInteract,
				icon = 'fa-solid fa-location-crosshairs',
				label = 'Sweep',
				canInteract = function(entity, distance, coords, name)
					return not isSweeping;
				end
			}
		}
	})
	table.insert(targetList, target)
end

removeTargets = function()
	if target then exports.ox_target:removeZone(target) end
	drawMarker = false
	markerData = nil
end
    
Citizen.CreateThread(function () 
	local prizonZone = PolyZone:Create(
		{
			vector2(1812.94, 2488.46 ),
			vector2(1809.04, 2475.16 ),
			vector2(1756.14, 2421.29 ),
			vector2(1660.44, 2408.81 ),
			vector2(1554.91, 2476.19 ),
			vector2(1547.6, 2583.85  ),
			vector2(1580.47, 2673.78 ),
			vector2(1655.64, 2745.45 ),
			vector2(1768.14, 2750.12 ),
			vector2(1831.92, 2695.81 ),
		},
		{
			name = "Prison"
		}
	)

	prizonZone:onPlayerInOut(function (out)
		ESX.TriggerServerCallback("stem_comserv:getComserv", function (coms) 
			if (not coms) then return end
			if (not out and coms.actions_remaining > 0) then
				tpToZone()
			end 
		end)
	end)
end)

tpToZone = function()
	SetEntityCoords(PlayerPedId(), Config.StartLocation.xyz)
end

targetInteract = function(data)
	if data.name == 'sweep' then
		startSweep()
	end
end

releaseZone = function()
	SetEntityCoords(PlayerPedId(), Config.ReleaseLocation.xyz)
end

startSweep = function()
	isSweeping = true
	if not HasAnimDictLoaded("anim@amb@drug_field_workers@rake@male_a@base") then
        RequestAnimDict("anim@amb@drug_field_workers@rake@male_a@base")
    end
    while not HasAnimDictLoaded("anim@amb@drug_field_workers@rake@male_a@base") do
        Citizen.Wait(0)
    end
	TaskPlayAnim(GetPlayerPed(-1), 'anim@amb@drug_field_workers@rake@male_a@base', 'base', 2.0, 2.0, 17000, 1, 0, false, false, false)
	local boneindex = GetPedBoneIndex(PlayerPedId(-1), 28422)
	broom = CreateObject(GetHashKey("prop_tool_broom"), 0, 0, 0, true, true, true)
	AttachEntityToEntity(broom, PlayerPedId(-1), boneindex, -0.010000, 0.040000, -0.030000, 0.000000, 0.000000, 0.000000, true, true, false, true, 1, true)

	Wait(5000)
    DeleteEntity(broom)
	ClearPedTasks(GetPlayerPed(-1))

	local currentNumber = existingActions
	existingActions = currentNumber -1
	if existingActions >= 1 then
		ESX.ShowNotification('Actions remaining'..' '..existingActions..'!')
	end
	isSweeping = false
	
	ESX.TriggerServerCallback("stem_comserv:finishSweep", function (finished)
		if not finished then 
			startActions()
		end
	end)
end


Citizen.CreateThread(function()
  	while true do
		Citizen.Wait(1)
		if drawMarker then 
			DrawMarker(22, markerData.x, markerData.y, markerData.z + 1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 64, 52, 200, true, false, 2, true, false, false, false)
		else 
			Wait(500)
		end
		if inService then
			DisableViolentActions()
			ESX.ShowHelpNotification(
				"You were issued community service by the staff team.~n~Press ~INPUT_CONTEXT~ to view notice.",
				true
			)
			if IsControlJustReleased(1, 51) then
				ESX.TriggerServerCallback("stem_comserv:getComserv", function (coms)
					TriggerEvent("stem_nui:showComservNotice", coms.reason)
				end)
			end
		end
	end
end)

function DisableViolentActions()
	local playerPed = PlayerPedId()

	if disable_actions == true then
		DisableAllControlActions(0)
	end

	DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
	DisablePlayerFiring(playerPed, true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
	DisableControlAction(0, 106, true) -- Disable in-game mouse controls
	DisableControlAction(0, 140, true)
	DisableControlAction(0, 141, true)
	DisableControlAction(0, 142, true)
	EnableControlAction(0, 249, true)

	if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
		TriggerEvent("ox_inventory:disarm", true)
	end

	if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
		TriggerEvent("ox_inventory:disarm", true)
	end
end


function DrawText2D(text, pos)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.45, 0.45)
	SetTextCentre(true)
	SetTextColour(255, 255, 255, 255)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(table.unpack(pos))
end
