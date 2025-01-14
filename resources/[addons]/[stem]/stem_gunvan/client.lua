local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ""
local CurrentActionData = {}
local deleteOnKillProps = {}
local ShopOpen = false
local currentBoxZone;

local function getStockColor(stock)
    -- fuelLevel not defined in vehicleProps??
    if not stock then return 'lime' end

    if stock > 75.0 then
        return 'lime'
    elseif stock > 50.0 then
        return 'yellow'
    elseif stock > 25.0 then
        return 'orange'
    else
        return 'red'
    end
end

local function destroyCamera () 
	if DoesCamExist(CameraId) then
		if IsCamActive(CameraId) then
			SetCamActive(CameraId, false)
		end
		DestroyCam(CameraId, false)
		RenderScriptCams(false, false, 3000, true, false)
		SetGameplayCamRelativeHeading(0)
		SetGameplayCamRelativePitch(0, 1.0)
	end
end

local function rotateVector(uParam0, rotationAngles)
	local rotatedVector = uParam0

	local cosX, sinX = Cos(rotationAngles.x), Sin(rotationAngles.x)
	rotatedVector = vector3(
		rotatedVector.x,
		(cosX * rotatedVector.y) - (sinX * rotatedVector.z),
		(sinX * rotatedVector.y) + (cosX * rotatedVector.z)
	)

	local cosY, sinY = Cos(rotationAngles.y), Sin(rotationAngles.y)
	rotatedVector = vector3(
		(cosY * rotatedVector.x) + (sinY * rotatedVector.z),
		rotatedVector.y,
		(cosY * rotatedVector.z) - (sinY * rotatedVector.x)
	)

	local cosZ, sinZ = Cos(rotationAngles.z), Sin(rotationAngles.z)
	rotatedVector = vector3(
		(cosZ * rotatedVector.x) - (sinZ * rotatedVector.y),
		(sinZ * rotatedVector.x) + (cosZ * rotatedVector.y),
		rotatedVector.z
	)

	return rotatedVector
end

local function activateCamera(pos, rot)
	local v = rotateVector(vec3(0.4161, -3.5735, 0.7107), rot)
	local cameraPos = pos + v
	local cameraRot = rot + vec3(1.1179, 0, 23.1972)

	if not DoesCamExist(CameraId) then
		CameraId = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
	end

	SetCamCoord(CameraId, cameraPos)
	SetCamRot(CameraId, cameraRot, 2)
	SetCamFov(CameraId, 43.0)

	if not IsCamActive(CameraId) then
		SetCamActive(CameraId, true)
	end

	RenderScriptCams(true, false, 3000, true, false)
end

function purchaseWeapon(weaponName, amount)
	ESX.TriggerServerCallback(
		"stem_gunvan:purchaseWeapon",
		function (response, total, current) 
			if response == "no_funds" then
				lib.notify({
					type = "error",
					title = "You do not have enough Dirty Cash for this.",
					description = string.format("This purchase is **$%s**, you have **$%s**", ESX.Math.GroupDigits(total), ESX.Math.GroupDigits(current)),
				})
				destroyCamera()
				return
			elseif response == "no_space" then 
				lib.notify({
					type = "error",
					title = "You don't have space for these items",
				})
				destroyCamera()
				return
			elseif response == "no_stock" then
				lib.notify({
					type = "error",
					title = "There's not enough stock left",
					description = string.format("You tried to purchase **%s** weapons, the current stock is **%s**", ESX.Math.GroupDigits(total), ESX.Math.GroupDigits(current)),
				})
				lib.showContext("gunvan")
				return 
			end

			if DoesEntityExist(ped) and speechName then
				PlayPedAmbientSpeechWithVoiceNative(ped, speechName, 'XM3_GUNSELLER',
					'SPEECH_PARAMS_FORCE_NORMAL', false)
			end
	
			DisplayBoughtScaleform(weaponName, total)
			PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", false)

			destroyCamera()
		end,
		weaponName,
		amount
	)
	end

function OpenGunVan(items, shopKeeper, location, rotation)
	PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)
	
	PlayPedAmbientSpeechWithVoiceNative(shopKeeper, 'GENERIC_HI', 'XM3_GUNSELLER', 'SPEECH_PARAMS_FORCE_NORMAL',
	false)


	activateCamera(location, rotation)

	lib.registerContext({
		id = "gunvan",
		title = "Black Market",
		options = exports.stem_common:tableMap(items, 
			---@param item GunVanItem
			function (item)
				function openConfirmDialog() 
					if (item.stock and item.stock <= 0) then
						lib.notify({
							title = "This weapon is out of stock",
							description = "Check back later when the van has moved.",
							type = "error"
						})
						lib.showContext("gunvan")
						return 
					end
					local response = lib.inputDialog("How many do you want to purchase?", {{
						type = "slider",
						label = "Amount",
						default = 1,
						min = 1,
						max = item.stock or item.max,
					}}, {
						allowCancel = true
					})
					if not response or not response[1] then 
						lib.showContext("gunvan")
						return
					end
					purchaseWeapon(item.itemName, response[1])
				end
				
				local description = string.format("Dirty Price: **$%s**", ESX.Math.GroupDigits(item.price))
				if (item.stock and item.stock <= 0) then
					description = "Out of stock"
				end
				local stockPercentage = ((item.stock or item.max) / item.max) * 100

				return {
					title = item.title,
					description = description,
					colorScheme = getStockColor(stockPercentage),
					progress = stockPercentage,
					weaponName = item.item,
					onSelect = openConfirmDialog,
					icon = "fa-solid fa-gun",
				}
		end),
		onExit = function () 
			PlaySoundFrontend(-1, "ERROR", "HUD_AMMO_SHOP_SOUNDSET", false)
			destroyCamera () 
		end 
	})
	lib.showContext("gunvan")
end

function DisplayBoughtScaleform(weaponName, price)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
	local sec = 4

	BeginScaleformMovieMethod(scaleform, "SHOW_WEAPON_PURCHASED")

	PushScaleformMovieMethodParameterString(_U("weapon_bought", ESX.Math.GroupDigits(price)))
	PushScaleformMovieMethodParameterString(ESX.GetWeaponLabel(weaponName))
	PushScaleformMovieMethodParameterInt(GetHashKey(weaponName))
	PushScaleformMovieMethodParameterString("")
	PushScaleformMovieMethodParameterInt(100)

	EndScaleformMovieMethod()

	PlaySoundFrontend(-1, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET", false)

	Citizen.CreateThread(
		function()
			while sec > 0 do
				Citizen.Wait(0)
				sec = sec - 0.01

				DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			end
		end
	)
end

AddEventHandler(
	"onResourceStop",
	function(resource)
		if resource == GetCurrentResourceName() then
			if ShopOpen then
				ESX.UI.Menu.CloseAll()
			end
		end
	end
)

local gunVanBlip = nil;

CreateThread(function () 
	gunVanBlip = AddBlipForCoord(0,0,0)
	SetBlipSprite(gunVanBlip, 844)
    SetBlipDisplay(gunVanBlip, 0)
    SetBlipScale(gunVanBlip, 0.8)
    SetBlipAsShortRange(gunVanBlip, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName("Gun Van")
    EndTextCommandSetBlipName(gunVanBlip)
end)


AddStateBagChangeHandler('GunVan', nil, function(bagName, key, value)
	local entNet = bagName:gsub('entity:', '')
	print(entNet)
	entNet = tonumber(entNet)
	clearProps()

	local maxTime = GetGameTimer() + 10000
	while not NetworkDoesEntityExistWithNetworkId(entNet) and GetGameTimer() < maxTime do
		Wait(0)
	end

	if not NetworkDoesEntityExistWithNetworkId(entNet) then
		return
	end

	local entity = NetworkGetEntityFromNetworkId(entNet)
	while not HasCollisionLoadedAroundEntity(entity) do Wait(0) end

	while not gunVanBlip do
		Wait(100)
	end

	local vanPosition = GetEntityCoords(entity)
	
	SetBlipCoords(gunVanBlip, vanPosition.x, vanPosition.y, vanPosition.z)
    SetBlipDisplay(gunVanBlip, 5)

	local retval, vanGroundZ = GetGroundZFor_3dCoord(vanPosition.x, vanPosition.y, vanPosition.z, false);

	SetEntityCoords(entity, vanPosition.x, vanPosition.y, vanGroundZ, true)
	local vanHeading = GetEntityHeading(entity)
	-- SetEntityRotation(entity, value.rotation, 2, true)
	FreezeEntityPosition(entity, true)

	SetVehicleModKit(entity, 0)
	SetVehicleNumberPlateTextIndex(entity, 1)
	SetVehicleColours(entity, 7, 7)
	SetVehicleExtraColours(entity, 0, 0)
	SetVehicleLivery(entity, 0)

	SetVehicleWindowTint(entity, 1)
	SetVehicleWheelType(entity, 4)
	SetVehicleMod(entity, 5, 0, false)
	SetVehicleMod(entity, 16, 2, false)
	SetVehicleMod(entity, 23, 33, false)

	SetVehicleDirtLevel(entity, 0.0)
	SetVehicleHasUnbreakableLights(entity, true)
	SetVehicleNumberPlateText(entity, '31EVL500')
	SetVehicleLights(entity, 1)
	Citizen.InvokeNative(`SET_VEHICLE_TAIL_LIGHTS`, entity, false)

	SetVehicleEngineOn(entity, true, true, false)
	SetVehicleExplodesOnHighExplosionDamage(entity, false)
	SetVehicleStrong(entity, true)

	SetEntityInvincible(entity, true)
	SetVehicleCanBreak(entity, false)
	SetEntityCanBeDamaged(entity, false)
	SetVehicleDoorsLocked(entity, 10)

	-- SetVehicleDoorControl(entity, 2, 0, 1.0)
	-- SetVehicleDoorControl(entity, 3, 0, 1.0)
	SetVehicleDoorLatched(entity, 2, false, false, false)
	SetVehicleDoorLatched(entity, 3, false, false, false)
	SetVehicleDoorOpen(entity, 2, false, true)
	SetVehicleDoorOpen(entity, 3, false, true)

	RequestModel(`xm3_prop_xm3_crate_ammo_01a`)

	while not HasModelLoaded(`xm3_prop_xm3_crate_ammo_01a`) do Wait(0) end
	local ammo_crate = CreateObject(`xm3_prop_xm3_crate_ammo_01a`,
		GetObjectOffsetFromCoords(value.position, value.rotation, 0.0, -1.1, 0.5), false, false, false)

	table.insert(deleteOnKillProps, ammo_crate)

	local boneIndex = GetEntityBoneIndexByName(entity, 'chassis_dummy')


	AttachEntityToEntity(ammo_crate, entity, boneIndex, 0, -1.1, -0.15, 0, 0, 0, false, false, false, false, 2, true)
	SetEntityInvincible(ammo_crate, true)

	RequestModel(`xm3_props_xm3_lights_veh_01a`)
	while not HasModelLoaded(`xm3_props_xm3_lights_veh_01a`) do Wait(0) end
	local veh_lights = CreateObject(`xm3_props_xm3_lights_veh_01a`,
		GetObjectOffsetFromCoords(value.position, value.rotation, 0.0, -1.3, 1.955), false, false, false)

		
	table.insert(deleteOnKillProps, veh_lights)

	AttachEntityToEntity(veh_lights, entity, boneIndex, 0, -1.3, 1.241, 0, 0,
		180.0, false, false, false, false, 2, true)
	SetEntityInvincible(veh_lights, true)

	RequestModel(`IG_GunVanSeller`)
	while not HasModelLoaded(`IG_GunVanSeller`) do Wait(0) end

	local pedPos = GetEntityBonePosition_2(entity, boneIndex)
	shopKeeper = CreatePed(4, `IG_GunVanSeller`, pedPos, value.rotation.z, false, false)
	table.insert(deleteOnKillProps, shopKeeper)

	if currentBoxZone then exports.ox_target:removeZone(currentBoxZone) end
	currentBoxZone = exports.ox_target:addBoxZone({
		coords = vector3(vanPosition.x, vanPosition.y, vanPosition.z - 0.3),
		rotation = vanHeading,
		size = vector3(2, 5.5, 2),
		options = {
			{
				label = "Open Black Market",
				icon = "fa-solid fa-skull-crossbones",
				distance = 24,
				onSelect = function () OpenGunVan(value.items, shopKeeper, vector3(vanPosition.x, vanPosition.y, vanPosition.z - 0.3), GetEntityRotation(entity)) end,
			}
		}
	})
	

	SetEntityCollision(shopKeeper, false, false)
	FreezeEntityPosition(shopKeeper, true)
	SetEntityInvincible(shopKeeper, true)

	SetRagdollBlockingFlags(shopKeeper, 57360)
	SetPedConfigFlag(shopKeeper, 128, false)
	SetPedConfigFlag(shopKeeper, 179, true)
	SetPedConfigFlag(shopKeeper, 208, true)
	SetPedConfigFlag(shopKeeper, 294, true)
	SetPedConfigFlag(shopKeeper, 430, true)
	SetPedConfigFlag(shopKeeper, 118, false)
	SetPedConfigFlag(shopKeeper, 116, false)
	SetPedCanBeTargetted(shopKeeper, false)
	SetBlockingOfNonTemporaryEvents(shopKeeper, true)
	SetEntityCanBeDamaged(shopKeeper, false)
	-- SetEntityRotation(ped, value.rotation, 2, true)
	SetPedCanBeTargetted(shopKeeper, false)

	RequestAnimDict('ANIM@SCRIPTED@NPC@FREEMODE@IG2_GUN_SHOP@')
	while not HasAnimDictLoaded('ANIM@SCRIPTED@NPC@FREEMODE@IG2_GUN_SHOP@') do Wait(0) end

	local scene = CreateSynchronizedScene(GetEntityBonePosition_2(entity, boneIndex), value.rotation, 2)
	TaskSynchronizedScene(shopKeeper, scene, 'ANIM@SCRIPTED@NPC@FREEMODE@IG2_GUN_SHOP@', 'idle_look_at_player_gunseller', 1000.0,
		-1000.0, 5, 0, 1000.0, 0)
	SetSynchronizedSceneLooped(scene, true)

	-- *uParam0 = 9;
	-- StringCopy(&(uParam0->f_7), "GS_BROWSE_GV" /* GXT: Press ~a~ to purchase weapons from the Gun Van. */, 16);
	-- uParam0->f_1 = { func_12() };
	-- uParam0->f_13[0 /*3*/] = { OBJECT::GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS(func_12(), func_1217(), -0.6f, -3f, 0f) };
	-- uParam0->f_13[1 /*3*/] = { OBJECT::GET_OFFSET_FROM_COORD_AND_HEADING_IN_WORLD_COORDS(func_12(), func_1217(), 0.6f, -3f, 2f) };
	-- uParam0->f_26[0] = 1.25f;

	local hostileZone = CircleZone:Create(
		value.position,
		50.0,
		{
			name = "BM",
			useZ = true
			--debugPoly=true
		}
	)

	hostileZone:onPlayerInOut(
		function(isPointInside, point)
			LocalPlayer.state:set("inHostileZone", isPointInside, true)
		end
	)

	if DoesCamExist(CameraId) then
		if IsCamActive(CameraId) then
			SetCamActive(CameraId, false)
		end

		DestroyCam(CameraId, false)
		RenderScriptCams(false, false, 3000, true, false)
		SetGameplayCamRelativeHeading(0)
		SetGameplayCamRelativePitch(0, 1.0)
	end

	lib.hideMenu()

	DeleteEntity(ammo_crate)
	DeleteEntity(veh_lights)
	DeleteEntity(shopKeeper)

	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end

	hostileZone:destroy()

	SetModelAsNoLongerNeeded(`xm3_prop_xm3_crate_ammo_01a`)
	SetModelAsNoLongerNeeded(`xm3_props_xm3_lights_veh_01a`)
	SetModelAsNoLongerNeeded(`IG_GunVanSeller`)
end)

function clearProps()
	for key, value in pairs(deleteOnKillProps) do
		DeleteEntity(value)
	end
end

AddEventHandler("onResourceStop", function (resource) 
	if (GetCurrentResourceName() == resource) then
		clearProps()
	end
end)

RegisterNetEvent("stem_gunvan:clearProps", function() 
	clearProps()
end)
