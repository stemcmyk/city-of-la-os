local SETTINGS = {
	exempt_weapons = {
		[`WEAPON_KNIFE`] = true,
		[`WEAPON_SWITCHBLADE`] = true,
		[`WEAPON_COMPACTRIFLE`] = true,
		[`WEAPON_MAC10`] = true,
		[`WEAPON_MACHINEPISTOL`] = true,
	}
}

local weaponStateChanged = false
local attached_weapons = {}
local plyEntMap = {}

AddStateBagChangeHandler(
	"weaponPropData",
	nil,
	function(bagName, key, value, _reserved, replicated)
		if replicated then
			return
		end

		local player = GetPlayerFromStateBagName(bagName)
		if player == 0 then
			return
		end

		local maxTime = GetGameTimer() + 2500
		while not DoesEntityExist(GetPlayerPed(player)) and GetGameTimer() < maxTime do
			Wait(0)
		end

		local plyPed = GetPlayerPed(player)

		if not DoesEntityExist(plyPed) then
			return
		end

		local plyServerId = GetPlayerServerId(player)
		if plyEntMap[plyServerId] then
			local objects = plyEntMap[plyServerId]
			for i = 1, #objects do
				if NetworkGetEntityIsLocal(objects[i]) then
					DeleteEntity(objects[i])
				end
			end
		end

		local weaponObjs = {}

		local xIndex = 1
		local xOff = {
			[1] = { 0.11, 0.14 },
			[2] = { -0.05, 0.00 },
			[3] = { 0.17, -0.14 }
		}

		for weaponModel, weaponName in pairs(value) do
			RequestModel(weaponModel)
			while not HasModelLoaded(weaponModel) do
				Wait(0)
			end

			local obj = CreateObject(weaponModel, GetEntityCoords(plyPed), false, false, false)
			if isMeleeWeapon(weaponName) then
				AttachEntityToEntity(obj, plyPed, GetPedBoneIndex(plyPed, 24816), 0.05, -0.14, xOff[xIndex][2],
					0.0, 90.0, 0.0, true, true, false, false, 2, true)
			else
				AttachEntityToEntity(obj, plyPed, GetPedBoneIndex(plyPed, 24816), 0.1, -0.16, xOff[xIndex][2],
					90.0, 0.0, 0.0, true, true, false, false, 2, true)
			end

			xIndex += 1
			if xIndex > 3 then xIndex = 1 end

			weaponObjs[#weaponObjs + 1] = obj
			plyEntMap[plyServerId] = weaponObjs
		end
	end
)

RegisterNetEvent(
	"onPlayerDropped",
	function(serverId)
		local player = GetPlayerFromServerId(serverId)

		if plyEntMap[serverId] then
			local objects = plyEntMap[serverId]

			for i = 1, #objects do
				if NetworkGetEntityIsLocal(objects[i]) then
					DeleteEntity(objects[i])
				end
			end

			plyEntMap[serverId] = nil
		end
	end
)

AddEventHandler(
	"weaponStateChanged",
	function()
		LocalPlayer.state:set("weaponPropData", {}, true)         -- Clear old weapons for all players
		Wait(500)
		LocalPlayer.state:set("weaponPropData", attached_weapons, true) -- Clear old weapons for all players
	end
)

CreateThread(function()
	while not LocalPlayer.state.switchComplete do
		Wait(0)
	end

	local attachedWeapons = {}
	local inventory = exports.ox_inventory

	while true do
		if not IsEntityDead(PlayerPedId()) then
			weaponStateChanged     = false
			local items            = inventory:GetPlayerItems()
			local inventoryWeapons = {}

			for _, v in pairs(items) do
				if v.name and v.name:match("WEAPON_") and v.name ~= "WEAPON_UNARMED" and not v.metadata?.policeItem then
					local wepGroup = GetWeapontypeGroup(GetHashKey(v.name))
					if wepGroup == `GROUP_RIFLE` or wepGroup == `GROUP_SMG` or wepGroup == `GROUP_MG` or wepGroup == `GROUP_SNIPER` or wepGroup == `GROUP_HEAVY` then
						if not SETTINGS.exempt_weapons[GetHashKey(v.name)] then
							inventoryWeapons[#inventoryWeapons + 1] = v.name
						end
					end
				end
			end

			local currentWeapon = inventory:getCurrentWeapon()

			for _, v in pairs(inventoryWeapons) do
				if not currentWeapon or currentWeapon.name ~= v then
					local wepModel = GetWeapontypeModel(GetHashKey(v))
					if not Config_PoliceSlingedWeapons[currentWeapon?.hash] then
						if not attachedWeapons[wepModel] then
							attachedWeapons[wepModel] = v
							weaponStateChanged = true
						end
					end
				end
			end

			for wepModel, wepName in pairs(attachedWeapons) do
				local itemCount = exports.ox_inventory:GetItemCount(wepName)
				if HasPedGotWeapon(PlayerPedId(), GetHashKey(wepName), false) or not itemCount or itemCount < 1 or Config_PoliceSlingedWeapons[GetHashKey(wepName)] then
					attachedWeapons[wepModel] = nil
					weaponStateChanged = true
				end
			end

			-- local job = ESX?.PlayerData?.job?.name or ""
			-- if job ~= 'lspd' and job ~= 'sahp' and job ~= 'lscso' then
			-- 	if LocalPlayer.state.weaponPropData then
			-- 		local data = LocalPlayer.state.weaponPropData
			-- 		if type(data) == 'table' then
			-- 			local attached = 0
			-- 			for _, v in pairs(data) do
			-- 				attached += 1
			-- 			end
			-- 			if attached > 0 then
			-- 				SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
			-- 			end
			-- 		end
			-- 	end
			-- end

			if weaponStateChanged then
				LocalPlayer.state:set("weaponPropData", attachedWeapons, true)
			end
		end

		Wait(100)
	end
end)

function isMeleeWeapon(wep_name)
	local wepGroup = GetWeapontypeGroup(GetHashKey(wep_name))
	return wepGroup == 2685387236 or wepGroup == -728555052
end
