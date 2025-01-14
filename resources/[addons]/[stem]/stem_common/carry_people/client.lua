local carry = {
	InProgress = false,
	targetSrc = -1,
	type = "",
	personCarrying = {
		animDict = "missfinale_c2mcs_1",
		anim = "fin_c2_mcs_1_camman",
		flag = 49
	},
	personCarried = {
		animDict = "nm",
		anim = "firemans_carry",
		attachX = 0.27,
		attachY = 0.15,
		attachZ = 0.63,
		flag = 33
	}
}

local function CarryPeople_GetClosestPlayer(radius)
	local players = GetActivePlayers()
	local closestDistance = radius
	local closestPlayer = nil
	local playerPed = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)

	for i = 1, #players do
		local ped = GetPlayerPed(players[i])
		if ped ~= playerPed then
			local targetCoords = GetEntityCoords(ped)
			local distance = #(targetCoords - playerCoords)
			if distance <= closestDistance and IsEntityVisible(ped) and GetEntityAttachedTo(ped) == 0 then
				closestDistance = distance
				closestPlayer = players[i]
			end
		end
	end

	return closestPlayer
end

local function ensureAnimDict(animDict)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(0)
		end
	end
	return animDict
end

local function tryCarry() 
    local coords = GetEntityCoords(PlayerPedId())
    local hMapArea = GetHashOfMapAreaAtCoords(coords.x, coords.y, coords.z)
    if hMapArea == -289320599 then -- CITY
        if GlobalState.jobCount.amr > 0 and not carry.InProgress then
            ESX.ShowNotification("Carry cannot be initiated at this time.")
            return
        end
    elseif hMapArea == 2072609373 then -- COUNTRY
        if GlobalState.jobCount.amr >= 3 and not carry.InProgress then
            ESX.ShowNotification("Carry cannot be initiated at this time.")
            return
        end
    end

    local plyPed = PlayerPedId()
    if exports.wasabi_ambulance:isPlayerDead(GetPlayerServerId(NetworkGetPlayerIndexFromPed(plyPed))) then
        return
    end

    if GetPedType(plyPed) ~= 2 then
        return
    end

    if not carry.InProgress then
        local closestPlayer = CarryPeople_GetClosestPlayer(3)
        if closestPlayer then
            local plySource = GetPlayerServerId(closestPlayer)
            if not exports.wasabi_ambulance:isPlayerDead(plySource) then
                ESX.ShowNotification("This person isn't dead.", "error")
                return
            end

            if Player(plySource).state.bodybagged then
                return
            end

            if Player(plySource).state.cannotBeCarried then
                ESX.ShowNotification("~r~This player combat logged or spawned dead and cannot be carried.")
                return
            end

            if Player(plySource).state.gangWar and not LocalPlayer.state.gangWar then
                ESX.ShowNotification("This player is in an active gang war and cannot be carried.")
                return
            end

            local targetSrc = GetPlayerServerId(closestPlayer)

            if targetSrc ~= -1 then
                TaskStartScenarioInPlace(plyPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)

                LocalPlayer.state.blockClearTasks = true
                LocalPlayer.state.invBusy = true

                local progress = lib.progressBar({
                    label = "Picking Up Player",
                    duration = 5000,
                    disable = {
                        car = true,
                        move = true,
                    },
                    canCancel = true,
                })

                if (progress) then 
                    ClearPedTasksImmediately(plyPed)
                    carry.InProgress = true
                    carry.targetSrc = targetSrc
                    TriggerServerEvent("stem_common:carry_people:sync", targetSrc)
                    ensureAnimDict(carry.personCarrying.animDict)
                    carry.type = "carrying"
                end
                
                LocalPlayer.state.blockClearTasks = false
                LocalPlayer.state.invBusy = false
            else
                ESX.ShowNotification("~r~No one nearby to carry~s~")
            end
        else
            ESX.ShowNotification("~r~No one nearby to carry~s~")
        end
    else
        carry.InProgress = false
        ClearPedSecondaryTask(plyPed)
        DetachEntity(plyPed, true, false)
        TriggerServerEvent("stem_common:carry_people:stop", carry.targetSrc)
        carry.targetSrc = 0
    end
end

RegisterCommand("carry", tryCarry)

AddEventHandler('playerSpawned', function()
	if carry.InProgress then
		carry.InProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		TriggerServerEvent("stem_common:carry_people:stop", carry.targetSrc)
		carry.targetSrc = 0
	end
end)

RegisterNetEvent("stem_common:carry_people:syncTarget")
AddEventHandler(
	"stem_common:carry_people:syncTarget",
	function(targetSrc)
		local targetPed = GetPlayerPed(GetPlayerFromServerId(targetSrc))
		carry.InProgress = true
		ensureAnimDict(carry.personCarried.animDict)
		AttachEntityToEntity(
			PlayerPedId(),
			targetPed,
			0,
			carry.personCarried.attachX,
			carry.personCarried.attachY,
			carry.personCarried.attachZ,
			0.5,
			0.5,
			180,
			false,
			false,
			false,
			false,
			2,
			false
		)
		carry.type = "beingcarried"
	end
)

RegisterNetEvent("stem_common:carry_people:cl_stop")
AddEventHandler(
	"stem_common:carry_people:cl_stop",
	function()
		local plyPed = PlayerPedId()
		carry.InProgress = false
		ClearPedSecondaryTask(plyPed)
		DetachEntity(plyPed, true, false)
		ClearPedTasksImmediately(plyPed)
	end
)

RegisterNetEvent(
	"stem_common:carry_people:ClearTasks",
	function()
		ClearPedTasksImmediately(PlayerPedId())
	end
)

Citizen.CreateThread(
	function()

        exports.ox_target:addGlobalPlayer({
            {
                label = "Carry Person",
                icon = "fa-solid fa-hand-holding",
                distance = 2,
                canInteract = function (closestPlayer)
                    local plySource = GetPlayerServerId(closestPlayer)
                    
                    if not exports.wasabi_ambulance:isPlayerDead(plySource) then
                        return
                    end

                    if Player(plySource).state.bodybagged then
                        return
                    end

                    if Player(plySource).state.cannotBeCarried then
                        ESX.ShowNotification("~r~This player combat logged or spawned dead and cannot be carried.")
                        return
                    end

                    if Player(plySource).state.gangWar and not LocalPlayer.state.gangWar then
                        ESX.ShowNotification("This player is in an active gang war and cannot be carried.")
                        return
                    end

                    return true
                end,
                onSelect = tryCarry
            }
        })

		while true do
			local plyPed = PlayerPedId()
			if carry.InProgress then
				if carry.type == "beingcarried" then
					if not IsEntityPlayingAnim(plyPed, carry.personCarried.animDict, carry.personCarried.anim, 3) then
						TaskPlayAnim(plyPed, carry.personCarried.animDict, carry.personCarried.anim, 8.0, -8.0, 100000, carry.personCarried.flag, 0, false, false, false)
					end
				elseif carry.type == "carrying" then
					DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
					DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
					DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
					DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
					DisableControlAction(0, 106, true) -- INPUT_VEH_MOUSE_CONTROL_OVERRIDE
					DisablePlayerFiring(PlayerId(), true) -- Disables firing all together if they somehow bypass inzone Mouse Disable

                    ESX.ShowHelpNotification("Press ~INPUT_VEH_DUCK~ to drop the person.", true)
                    if (IsControlJustPressed(1, 73)) then
                        carry.InProgress = false
                        ClearPedSecondaryTask(plyPed)
                        DetachEntity(plyPed, true, false)
                        TriggerServerEvent("stem_common:carry_people:stop", carry.targetSrc)
                        carry.targetSrc = 0
                    end

					local _, strength = StatGetInt(GetHashKey("MP0_STRENGTH"), 0)
					if strength ~= nil and strength >= 60 then
						-- Allow sprinting if enough strength
					else
						DisableControlAction(0, 21, true) -- Disable sprint
					end
					DisableControlAction(0, 22, true) -- No one should be able to jump

					if not IsEntityPlayingAnim(plyPed, carry.personCarrying.animDict, carry.personCarrying.anim, 3) then
						TaskPlayAnim(plyPed, carry.personCarrying.animDict, carry.personCarrying.anim, 8.0, -8.0, 100000, carry.personCarrying.flag, 0, false, false, false)
					end

					if IsPedInAnyVehicle(plyPed, true) then
						local veh = GetVehiclePedIsIn(plyPed, false)
						if DoesEntityExist(veh) then
							if (GetPedInVehicleSeat(veh, -1) == plyPed) or (GetVehicleModelNumberOfSeats(GetEntityModel(veh)) <= 2) then
								carry.InProgress = false
								ClearPedSecondaryTask(plyPed)
								DetachEntity(plyPed, true, false)
								TriggerServerEvent("stem_common:carry_people:stop", carry.targetSrc)
								carry.targetSrc = 0
							end
						end
					end
				end
			end
			Wait(0)
		end
	end
)
