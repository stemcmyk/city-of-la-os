local lit_1 = {
	{
		anim = "savecouch@",
		lib = "t_sleep_loop_couch",
		name = Config.Language.anim.lie_back,
		x = 0,
		y = 0,
		z = 1.1,
		r = 180.0
	},
	{
		anim = "amb@prop_human_seat_chair_food@male@base",
		lib = "base",
		name = Config.Language.anim.sit_right,
		x = 0.0,
		y = -0.2,
		z = 0.55,
		r = -90.0
	},
	{
		anim = "amb@prop_human_seat_chair_food@male@base",
		lib = "base",
		name = Config.Language.anim.sit_left,
		x = 0.0,
		y = -0.2,
		z = 0.55,
		r = 90.0
	},
	-- {anim = "missheistfbi3b_ig8_2",lib = "cpr_loop_victim",name = Config.Language.anim.convulse, x = 0.0, y = 0.0, z = 1.5, r = 175.0},
	{
		anim = "amb@world_human_bum_slumped@male@laying_on_right_side@base",
		lib = "base",
		name = Config.Language.anim.pls,
		x = 0.2,
		y = 0.1,
		z = 1.6,
		r = 100.0
	}
}

local labels = {
	{
		"REDNECK_AMBO_HELP",
		"Press ~INPUT_CONTEXT~ to open/close back doors.~n~Press ~INPUT_HUD_SPECIAL~ to extend power-load."
	},
	{
		"REDNECK_AMBO_HELP2",
		"Press ~INPUT_CONTEXT~ to open/close back doors.~n~Press ~INPUT_VEH_HEADLIGHT~ to take stretcher.~n~Press ~INPUT_HUD_SPECIAL~ to extend power-load."
	},
	{
		"REDNECK_AMBO_HELP3",
		"Press ~INPUT_CONTEXT~ to open/close back doors.~n~Press ~INPUT_VEH_HEADLIGHT~ to stow stretcher.~n~Press ~INPUT_HUD_SPECIAL~ to extend power-load."
	},
	{
		"AMBULANCE_STAGE_1", -- Both doors closed.
		"Press ~INPUT_CONTEXT~ to open or close back doors.~n~"
	},
	{
		"AMBULANCE_STAGE_2", -- Both doors open with power load retracted.
		"Press ~INPUT_CONTEXT~ to open or close back doors.~n~Press ~INPUT_HUD_SPECIAL~ to extend power-load."
	},
	{
		"AMBULANCE_STAGE_3", -- Both doors open with power load extended.
		"Press ~INPUT_HUD_SPECIAL~ to retract power-load.~n~Press ~INPUT_VEH_HEADLIGHT~ to stow stretcher."
	}
}

local stretchers = {
	{stretchers = "stretcher", distance_stop = 2.4, name = lit_1, title = Config.Language.lit_1}
}

prop_amb = false
veh_detect = 0

RegisterNetEvent("stem_common:stretcher:detachStretcher")
AddEventHandler(
	"stem_common:stretcher:detachStretcher",
	function(stretcherNet, coords, heading)
		if not NetworkDoesEntityExistWithNetworkId(stretcherNet) then
			return
		end

		local stretcher = NetToVeh(stretcherNet)
		DetachEntity(stretcher, false, false)
        SetEntityCollision(stretcher, false, false)
	end
)

RegisterNetEvent("stem_common:stretcher:closeOpenDoor")
AddEventHandler(
	"stem_common:stretcher:closeOpenDoor",
	function(vehNet, actionType, doorIndex)
		if not NetworkDoesEntityExistWithNetworkId(vehNet) then
			return
		end

		local veh = NetToVeh(vehNet)
		SetVehicleDoorCanBreak(veh, doorIndex, false)
		if actionType == 0 then
			SetVehicleDoorShut(veh, doorIndex, false)
		elseif actionType == 1 then
			SetVehicleDoorOpen(veh, doorIndex, false, false)
		end

		-- SetVehicleFixed(veh)
		-- SetVehicleDeformationFixed(veh)
	end
)

RegisterNetEvent("stem_common:stretcher:getOnStretcher")
AddEventHandler(
	"stem_common:stretcher:getOnStretcher",
	function()
		local pedCoords = GetEntityCoords(PlayerPedId())
		local closestObject = _GetClosestVehicleModel(GetHashKey("stretcher"))

		if closestObject then
			LoadAnim("savecouch@")
			LoadAnim("anim@gangops@morgue@table@")
			ClearPedTasksImmediately(PlayerPedId())

			if IsPedDeadOrDying(PlayerPedId(), true) then
				AttachEntityToEntity(PlayerPedId(), closestObject, PlayerPedId(), 0, 0, 1.5, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
				TaskPlayAnim(PlayerPedId(), "anim@gangops@morgue@table@", "body_search", 8.0, 8.0, -1, 1, 0, false, false, false)
			else
				AttachEntityToEntity(PlayerPedId(), closestObject, PlayerPedId(), 0, 0, 1.1, 0.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
				TaskPlayAnim(PlayerPedId(), "savecouch@", "t_sleep_loop_couch", 8.0, 8.0, -1, 1, 0, false, false, false)
			end
		end
	end
)

RegisterNetEvent("stem_common:stretcher:grabStretcher")
AddEventHandler(
	"stem_common:stretcher:grabStretcher",
	function(vehNet, target)
		if NetworkDoesEntityExistWithNetworkId(vehNet) then
			local stretcher = NetToVeh(vehNet)
			DetachEntity(stretcher, false, false)

			local player = GetPlayerFromServerId(target)
			local targetPed = GetPlayerPed(player)

			if DoesEntityExist(targetPed) then
                Entity(targetPed).state.stretcherAttached = true
				AttachEntityToEntity(stretcher, targetPed, -1, -0.05, 1.3, -0.4, 180.0, 180.0, 180.0, 0.0, false, false, false, false, 2, true)
			end
		end
	end
)

-- Citizen.CreateThread(
-- 	function()
-- 		while not NetworkIsSessionActive() do
-- 			Citizen.Wait(0)
-- 		end

-- 		while not ESX do
-- 			Citizen.Wait(0)
-- 		end

-- 		for i = 1, #labels do
-- 			AddTextEntry(labels[i][1], labels[i][2])
-- 		end

-- 		while true do
-- 			local sleep = 2000
-- 			local playerPed = PlayerPedId()
-- 			local pedCoords = GetEntityCoords(playerPed)

-- 			if ESX.PlayerData?.job?.name == "amr" then
-- 			end

-- 			Citizen.Wait(sleep)
-- 		end
-- 	end
-- )

function checkCanOpenTrunk() 

end

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Citizen.Wait(0)
		end

		while not ESX do
			Citizen.Wait(0)
		end

        exports.ox_target:addGlobalPlayer({
            {
                onSelect = function(data)
                    local player = NetworkGetPlayerIndexFromPed(data.entity)
                    TriggerServerEvent("stem_common:stretcher:attachStr", GetPlayerServerId(player))    
                end,
                canInteract = function(entity)
                    local serverId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity))
                    return exports.wasabi_ambulance:isPlayerDead(serverId)
                end,
                groups = {["amr"] = 0},
                label = "Attach to Nearby Stretcher",
                index = 1
            },
            
        })
        exports.ox_target:addModel("stretcher", {
            groups = { "amr" },
            label = "Pickup Stretcher",
            icon = "fa-solid fa-arrow-up-from-bucket",
            distance = 2,
            canInteract = function ()
                if (Entity(PlayerPedId()).state.stretcherAttached or not DoesEntityExist(Entity(PlayerPedId()).state.stretcherAttached)) then
                    return true 
                end
                return false;
            end,
            onSelect = function (data) 
                GrabStretcher(data.entity)
            end
        })
        -- exports.ox_target:addModel("stretcher", {
        --     distance = 4,
        --     onSelect = function (data) 
        --         ClearPedTasksImmediately(PlayerPedId())
        --         SetVehicleExtra(data.entity, 1, 1)
        --         SetVehicleExtra(data.entity, 2, 0)
        --         DetachEntity(data.entity, true, false)
        --         SetVehicleOnGroundProperly(data.entity)
        --         Entity(data.entity).state:set("stretcherAttached", nil, true)
        --         Entity(PlayerPedId()).state:set("stretcherAttached", nil, true)
        --     end
        -- })
        exports.ox_target:addGlobalVehicle({
            groups = { "amr" },
            label = "Place Stretcher",
            offset = vec3(0.5, 0, 0.5),
            distance = 2,
			icon = "fa-solid fa-arrow-left",
            canInteract = function (entity) 
                local bone1 = GetEntityBoneIndexByName(entity, "door_dside_r")
                local bone2 = GetEntityBoneIndexByName(entity, "door_pside_r")
                if bone1 ~= -1 and bone2 ~= -1 then
                    local min, max = GetModelDimensions(GetEntityModel(entity))
                    local doorCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, min.y - 0.0, -0.8)
                    local prop = nil;

                    for _, m in pairs(stretchers) do
                        local prop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 4.0, GetHashKey(m.stretchers))
                        if prop ~= 0 then
                            prop_exist = prop
                        end
                    end
                    
                    if IsEntityAttachedToEntity(prop, PlayerPedId()) ~= 0 or prop ~= 0 then
                        if GetVehicleDoorAngleRatio(entity, 5) > 0.1 then -- Both doors open, allow powerload manipulation
                            if GetVehicleDoorAngleRatio(entity, 4) > 0.1 then -- Both doors open, allow powerload manipulation
                                local closestObject = _GetClosestVehicleModel(GetHashKey("stretcher"))
                                if DoesEntityExist(closestObject) and Entity(PlayerPedId()).state.stretcherAttached then
                                    local propCoords = GetEntityCoords(closestObject)
                                    local propForward = GetEntityForwardVector(closestObject)
                                    local litCoords = (propCoords + propForward)
                                    local sitCoords = (propCoords + propForward * 0.1)
                                    local pickupCoords = (propCoords + propForward * 1.2)
                                    local pickupCoords2 = (propCoords + propForward * -1.2)
    
                                    if IsVehicleSeatFree(entity, -1) then
                                        if (IsEntityAttachedToEntity(closestObject, PlayerPedId())) then
                                            return not IsEntityAttachedToEntity(closestObject, amb)
                                        end
                                    end
                                    return false
                                end
                                return false
                            end
                        else 
                            return false
                        end
                    end
                end
            end,
            onSelect = function (data)
                local closestObject = _GetClosestVehicleModel(GetHashKey("stretcher"))
                local oldPos = GetEntityCoords(PlayerPedId())

                if DoesEntityExist(closestObject) then
                    SetVehicleExtra(closestObject, 1, 1)
                    SetVehicleExtra(closestObject, 2, 0)
                    DetachEntity(closestObject, true, true)
                    prop_amb = true

                    if NetworkGetEntityOwner(data.entity) ~= PlayerId() then
                        if IsVehicleSeatFree(data.entity, -1) then
                            NetworkSetInFreeCamMode(true)
                            TaskWarpPedIntoVehicle(PlayerPedId(), data.entity, -1)
                            while NetworkGetEntityOwner(data.entity) ~= PlayerId() do
                                Citizen.Wait(0)
                            end
                
                            Entity(closestObject).state:set("stretcherAttached", nil, true)
                            AttachEntityToEntity(closestObject, data.entity, GetEntityBoneIndexByName(data.entity, "bonnet"), 0.0, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
                        end
                    else
                        Entity(closestObject).state:set("stretcherAttached", nil, true)
                        AttachEntityToEntity(closestObject, data.entity, GetEntityBoneIndexByName(data.entity, "bonnet"), 0.0, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
                    end
                
                    -- TriggerServerEvent("stem_common:stretcherattachStretcher", VehToNet(amb), VehToNet(propObject), depth, height)
                
                    local maxTime = GetGameTimer() + 5000
                    while GetGameTimer() < maxTime and not IsEntityAttachedToEntity(closestObject, data.entity) do
                        Citizen.Wait(0)
                    end
                
                    SetEntityCoordsNoOffset(PlayerPedId(), oldPos.x, oldPos.y, oldPos.z, true, false, false)
                    NetworkSetInFreeCamMode(false)
                        
			        Entity(PlayerPedId()).state:set("stretcherAttached", nil, closestObject)
                    ClearPedTasksImmediately(PlayerPedId())
                    ClearPedTasks(PlayerPedId())
                end
            end
        })
        
        exports.ox_target:addGlobalVehicle({
            groups = { "amr" },
            label = "Retreive Stretcher",
            offset = vec3(0.5, 0, 0.5),
            distance = 2,
			icon = "fa-solid fa-arrow-right",
            canInteract = function (entity) 
                local bone1 = GetEntityBoneIndexByName(entity, "door_dside_r")
                local bone2 = GetEntityBoneIndexByName(entity, "door_pside_r")
                if bone1 ~= -1 and bone2 ~= -1 then
                    local min, max = GetModelDimensions(GetEntityModel(entity))
                    local doorCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, min.y - 0.0, -0.8)

                    for _, m in pairs(stretchers) do
                        local prop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 4.0, GetHashKey(m.stretchers))
                        if prop ~= 0 then
                            prop_exist = prop
                        end
                    end
                    
                    if IsEntityAttachedToEntity(prop, PlayerPedId()) ~= 0 or prop ~= 0 then
                        if GetVehicleDoorAngleRatio(entity, 5) > 0.1 then -- Both doors open, allow powerload manipulation
                            if GetVehicleDoorAngleRatio(entity, 4) > 0.1 then -- Both doors open, allow powerload manipulation
                                local closestObject = _GetClosestVehicleModel(GetHashKey("stretcher"))


                                if DoesEntityExist(closestObject) and not Entity(PlayerPedId()).state.stretcherAttached then
                                    local propCoords = GetEntityCoords(closestObject)
                                    local propForward = GetEntityForwardVector(closestObject)
                                    local litCoords = (propCoords + propForward)
                                    local playerPed = PlayerPedId()
                                    local pedCoords = GetEntityCoords(playerPed)
                                    
                                    if not IsEntityDead(PlayerPedId()) and IsPedOnFoot(PlayerPedId())  then
                                        if not IsEntityAttachedToAnyPed(closestObject, PlayerPedId()) and IsEntityAttachedToEntity(closestObject, entity)  and Entity(closestObject).state.stretcherAttached == nil then
                                            return true
                                        end
                                    end
                                end
                            end
                        end
                    end
                    
                    return false
                end
            end,
            onSelect = function (data)
                local closestObject = _GetClosestVehicleModel(GetHashKey("stretcher"))

                if (DoesEntityExist(closestObject)) then
                    SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 180.0)
                    SetVehicleExtra(closestObject, 1, 0)
                    SetVehicleExtra(closestObject, 2, 1)
                    GrabStretcher(closestObject)
                end
            end
        })

        exports.ox_target:addGlobalVehicle({
            groups = { "amr" },
            label = "Toggle Powerload",
            offset = vec3(0.5, 0, 0.5),
            distance = 2,
            icon = "fa-solid fa-caret-down",
            canInteract = function (entity) 
                local bone1 = GetEntityBoneIndexByName(entity, "door_dside_r")
                local bone2 = GetEntityBoneIndexByName(entity, "door_pside_r")
                if bone1 ~= -1 and bone2 ~= -1 then
                    local min, max = GetModelDimensions(GetEntityModel(entity))
                    local doorCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, min.y - 0.0, -0.8)

                    for _, m in pairs(stretchers) do
                        local prop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 4.0, GetHashKey(m.stretchers))
                        if prop ~= 0 then
                            prop_exist = prop
                        end
                    end
                    
                    if IsEntityAttachedToEntity(prop, PlayerPedId()) ~= 0 or prop ~= 0 then
                        if GetVehicleDoorAngleRatio(entity, 5) > 0.1 then -- Both doors open, allow powerload manipulation
                            return true
                        else 
                            return false
                        end
                    end
                end
            end,
            onSelect = function (data)
                if GetVehicleDoorAngleRatio(data.entity, 4) > 0.1 then
                    TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(data.entity), 0, 4)
                else
                    TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(data.entity), 1, 4)
                end 
            end
        })
        
        exports.ox_target:addGlobalVehicle({
            groups = { "amr" },
            label = "Toggle Doors",
            offset = vec3(0.5, 0, 0.5),
            distance = 2,
            icon = "fa-solid fa-door-open",
            canInteract = function (entity) 
                local bone1 = GetEntityBoneIndexByName(entity, "door_dside_r")
                local bone2 = GetEntityBoneIndexByName(entity, "door_pside_r")
                if bone1 ~= -1 and bone2 ~= -1 then
                    local min, max = GetModelDimensions(GetEntityModel(veh_detect))
                    local doorCoords = GetOffsetFromEntityInWorldCoords(veh_detect, 0.0, min.y - 0.0, -0.8)

                    for _, m in pairs(stretchers) do
                        local prop = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 4.0, GetHashKey(m.stretchers))
                        if prop ~= 0 then
                            prop_exist = prop
                        end
                    end

                    if IsEntityAttachedToEntity(prop, PlayerPedId()) ~= 0 or prop ~= 0 then
                        if GetVehicleDoorAngleRatio(veh_detect, 5) > 0.1 then -- Both doors open, allow powerload manipulation
                            if GetVehicleDoorAngleRatio(veh_detect, 4) > 0.1 then -- Powerload open, don't allow close door
                                return false
                            else
                                return true
                            end
                        else
                            return true
                        end
                    end
                end
            end,
            onSelect = function (data)
                if GetVehicleDoorAngleRatio(data.entity, 5) > 0.1 then
                    TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(data.entity), 0, 5)
                else
                    TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(data.entity), 1, 5)
                end
            end
        })

        -- TODO: Add loop for removing stretcher when he dead

		prop_exist = 0
        end)

function GrabStretcher(propObject, hash)
	if not DoesEntityExist(propObject) then
		return
	end

	if IsEntityAttached(propObject) then
		TriggerServerEvent("stem_common:stretcher:detachStretcher", VehToNet(propObject))
		while IsEntityAttached(propObject) do
			Citizen.Wait(100)
			TriggerServerEvent("stem_common:stretcher:detachStretcher", VehToNet(propObject))
		end
	end

	TriggerServerEvent("stem_common:stretcher:grabStretcher", VehToNet(propObject), GetPlayerServerId(PlayerId()))

	while not IsEntityAttached(propObject) do
		Citizen.Wait(250)
		TriggerServerEvent("stem_common:stretcher:grabStretcher", VehToNet(propObject), GetPlayerServerId(PlayerId()))
	end


	LoadAnim("anim@heists@box_carry@")

	while DoesEntityExist(propObject) and Entity(propObject).state.stretcherAttached do


		Citizen.Wait(0)
        
		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
            if (Entity(propObject).state.stretcherAttached) then
			    TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
            end
		end

		if IsEntityDead(PlayerPedId()) then
			ClearPedTasksImmediately(PlayerPedId())
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, true)
		end

		if IsControlJustPressed(0, Config.Press.release_bed) then
			ClearPedTasksImmediately(PlayerPedId())
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, false)
			SetVehicleOnGroundProperly(propObject)
			Entity(propObject).state:set("stretcherAttached", nil, true)
			Entity(PlayerPedId()).state:set("stretcherAttached", nil, true)
			break
		end
	end
end

-- Stretcher is attached to ambulance
function in_ambulance(propObject, amb, depth, height)
	veh_detect = 0

	local oldPos = GetEntityCoords(PlayerPedId())

	while IsEntityAttachedToEntity(propObject, amb) do
		Citizen.Wait(0)

		if GetVehiclePedIsIn(PlayerPedId()) == 0 then
			local min, max = GetModelDimensions(GetEntityModel(amb))
			local doorCoords = GetOffsetFromEntityInWorldCoords(amb, 0.0, min.y - 0.0, -0.8)

			if #(GetEntityCoords(PlayerPedId()) - doorCoords) <= 10.0 then
				DrawMarker(25, doorCoords.x, doorCoords.y, doorCoords.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 0, 255, 0, 200, false, true, 0, false, nil, nil, false)
			end

			if #(GetEntityCoords(PlayerPedId()) - doorCoords) <= 2.0 then
				if GetVehicleDoorAngleRatio(veh_detect, 5) > 0.1 then -- Both doors open, allow powerload manipulation
					if GetVehicleDoorAngleRatio(veh_detect, 4) > 0.1 then -- Powerload extended
						BeginTextCommandDisplayHelp(labels[6][1])
						EndTextCommandDisplayHelp(0, 0, 1, -1)

						if IsControlJustPressed(0, Config.Press.take_stow_stretcher) then
							local detachPos = GetOffsetFromEntityInWorldCoords(amb, 0.0, min.y - 2.0, 0.0)
							local detachHeading = GetEntityHeading(PlayerPedId()) - 180.0
							prop_amb = false

							SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId()) - 180.0)
							SetVehicleExtra(propObject, 1, 0)
							SetVehicleExtra(propObject, 2, 1)
							GrabStretcher(propObject)
						end
					else
						BeginTextCommandDisplayHelp(labels[5][1])
						EndTextCommandDisplayHelp(0, 0, 1, -1)
					end

					if IsControlJustPressed(0, Config.Press.extend_powerload) then
						if GetVehicleDoorAngleRatio(amb, 4) > 0.1 then
							TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(amb), 0, 4)
						else
							TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(amb), 1, 4)
						end
						Citizen.Wait(500)
					end
				else
					BeginTextCommandDisplayHelp(labels[4][1])
					EndTextCommandDisplayHelp(0, 0, 1, -1)
				end

				if IsControlJustPressed(0, Config.Press.out_vehicle_bed) and GetVehicleDoorAngleRatio(veh_detect, 4) < 0.1 then
					if GetVehicleDoorAngleRatio(amb, 5) > 0.1 then
						TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(amb), 0, 5)
					else
						TriggerServerEvent("stem_common:stretcher:closeOpenDoor", VehToNet(amb), 1, 5)
					end
					Citizen.Wait(500)
				end
			end
		end
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function hintToDisplay(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function DrawText3D(coords, text, size)
	local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z + 1.0)
	local px, py, pz = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 370
	DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

function _GetClosestVehicleModel(model)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local closestVehicle = nil
	local closestDist = 100
	local pool = GetGamePool("CVehicle")

	for i = 1, #pool do
		local veh = pool[i]
		if DoesEntityExist(veh) and GetEntityModel(veh) == model then
			local dist = #(GetEntityCoords(veh) - playerCoords)
			if dist < closestDist then
				closestDist = dist
				closestVehicle = veh
			end
		end
	end

	return (closestVehicle and closestDist < 10.0) and closestVehicle or nil
end
