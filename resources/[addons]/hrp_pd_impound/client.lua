----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local _ESX = nil
local _OwnPlayerData = nil
local _DependenciesLoaded = false

local _Impound = Config.Impound

local _GuiEnabled = false

local _VehicleAndOwner = nil

local _ImpoundedVehicles = nil

----------------------------------------------------------------------------------------------------
-- Setup & Initialization
----------------------------------------------------------------------------------------------------

Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Citizen.Wait(0)
		end

		_ESX = exports["es_extended"]:getSharedObject()

		while _ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		_DependenciesLoaded = true

		PlayerData = _ESX.GetPlayerData()
	end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		PlayerData = xPlayer
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

function ActivateBlips()
	local blip = AddBlipForCoord(_Impound.RetrieveLocation.X, _Impound.RetrieveLocation.Y, _Impound.RetrieveLocation.Z)
	SetBlipScale(blip, 0.75)
	SetBlipDisplay(blip, 4)
	SetBlipSprite(blip, 317)
	SetBlipColour(blip, 17)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Impound")
	EndTextCommandSetBlipName(blip)
end

ActivateBlips()

----------------------------------------------------------------------------------------------------
-- Helper functions
----------------------------------------------------------------------------------------------------

function ShowHelpNotification(text)
	ClearAllHelpMessages()
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, true, 5000)
end

RegisterNetEvent("HRP:ESX:SetCharacter")
AddEventHandler(
	"HRP:ESX:SetCharacter",
	function(playerData)
		_OwnPlayerData = playerData
	end
)

RegisterNetEvent("HRP:ESX:SetVehicleAndOwner")
AddEventHandler(
	"HRP:ESX:SetVehicleAndOwner",
	function(vehicleAndOwner)
		_VehicleAndOwner = vehicleAndOwner
	end
)

RegisterNetEvent("HRP:Impound:SetImpoundedVehicles")
AddEventHandler(
	"HRP:Impound:SetImpoundedVehicles",
	function(impoundedVehicles)
		_ImpoundedVehicles = impoundedVehicles
	end
)

-- RegisterNetEvent("HRP:Impound:VehicleUnimpounded")
-- AddEventHandler(
-- 	"HRP:Impound:VehicleUnimpounded",
-- 	function(data, index)
-- 		_ESX.ShowNotification("Your vehicle with the plate: ~g~" .. data.plate .. " ~s~has been unimpounded and returned to the garage.")
-- 	end
-- )

RegisterNetEvent("HRP:Impound:CannotUnimpound")
AddEventHandler(
	"HRP:Impound:CannotUnimpound",
	function()
		_ESX.ShowNotification("Your vehicle cannot be unimpounded at this moment, do you have enough cash?")
	end
)

----------------------------------------------------------------------------------------------------
-- NUI bs
----------------------------------------------------------------------------------------------------

function ShowImpoundMenu(action)
	local policeJobs = {
		["lspd"] = true,
		["sahp"] = true,
		["lscso"] = true
	}

	if GlobalState.jobCount["sadot"] >= 2 and policeJobs[PlayerData.job.name] then
		_ESX.ShowNotification("Cannot impound - D.O.T. required.")
		return
	end

	local pos = GetEntityCoords(PlayerPedId())
	local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)

	if IsPedInAnyVehicle(PlayerPedId()) then
		_ESX.ShowNotification("Leave the vehicle first.")
		return
	end

	if #(GetEntityCoords(vehicle) - pos) > 6.0 then
		_ESX.ShowNotification("Vehicle is too far away.")
		return
	end

	if (vehicle ~= nil) then
		local v = _ESX.Game.GetVehicleProperties(vehicle)
		local data = {}

		TriggerServerEvent("HRP:ESX:GetCharacter", PlayerData.identifier)
		TriggerServerEvent("HRP:ESX:GetVehicleAndOwner", v.plate)
		Citizen.Wait(500)

		if (Config.NoPlateColumn == true) then
			Citizen.Wait(Config.WaitTime)
		end

		if (_VehicleAndOwner == nil) then
			_ESX.ShowNotification("Unknown vehicle owner, cannot impound")
			return
		end
		
		ExecuteCommand("e notepad") -- I'm lazy

		data.action = "open"
		data.form = "impound"
		data.rules = Config.Rules
		data.vehicle = {
			plate = _VehicleAndOwner.plate,
			owner = _VehicleAndOwner.firstname .. " " .. _VehicleAndOwner.lastname
		}

		if (PlayerData.job.name == "lspd" or PlayerData.job.name == "sahp" or PlayerData.job.name == "lscso") then
			data.officer = _OwnPlayerData.firstname .. " " .. _OwnPlayerData.lastname
			_GuiEnabled = true
			SetNuiFocus(true, true)
			SendNuiMessage(json.encode(data))
		end

		if (PlayerData.job.name == "sadot") then
			data.officer = "SA D.O.T."
			data.mechanic = _OwnPlayerData.firstname .. " " .. _OwnPlayerData.lastname
			_GuiEnabled = true
			SetNuiFocus(true, true)
			SendNuiMessage(json.encode(data))
		end
	else
		_ESX.ShowNotification("No vehicle nearby")
	end
end

function ShowAdminTerminal()
	_ImpoundedVehicles = nil
	TriggerServerEvent("HRP:Impound:GetVehicles")

	exports["mythic_notify"]:SendAlert("inform", "Fetching impound data...", 1000)

	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), true)
	while not _ImpoundedVehicles do
		DisableAllControlActions(0)
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 249, true)
		Citizen.Wait(0)
	end

	FreezeEntityPosition(PlayerPedId(), false)

	_GuiEnabled = true
	SetNuiFocus(true, true)
	local data = {
		action = "open",
		form = "admin",
		user = _OwnPlayerData,
		job = PlayerData.job,
		vehicles = _ImpoundedVehicles
	}

	SendNuiMessage(json.encode(data))
end

function DisableImpoundMenu()
	ClearPedTasks(PlayerPedId())
	_GuiEnabled = false
	SetNuiFocus(false)
	SendNuiMessage('{"action": "close", "form": "none"}')
	ExecuteCommand("emotecancel")
	_OwnPlayerData = nil
	_VehicleAndOwner = nil
	_ImpoundedVehicles = nil
end

function ShowRetrievalMenu()
	_ImpoundedVehicles = nil
	TriggerServerEvent("HRP:ESX:GetCharacter", PlayerData.identifier)
	TriggerServerEvent("HRP:Impound:GetImpoundedVehicles", PlayerData.identifier)

	exports["mythic_notify"]:SendAlert("inform", "Fetching impound data...", 1000)

	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(PlayerPedId(), true)
	while not _ImpoundedVehicles do
		DisableAllControlActions(0)
		EnableControlAction(0, 1, true)
		EnableControlAction(0, 2, true)
		EnableControlAction(0, 249, true)
		Citizen.Wait(0)
	end

	FreezeEntityPosition(PlayerPedId(), false)

	_GuiEnabled = true
	SetNuiFocus(true, true)
	local data = {
		action = "open",
		form = "retrieve",
		user = _OwnPlayerData,
		job = PlayerData.job,
		vehicles = _ImpoundedVehicles
	}

	SendNuiMessage(json.encode(data))
end

RegisterNUICallback(
	"escape",
	function(data, cb)
		DisableImpoundMenu()
		cb("ok")
	end
)

RegisterNUICallback(
	"impound",
	function(data, cb)
		local v = _ESX.Game.GetClosestVehicle()
		local veh = _ESX.Game.GetVehicleProperties(v)

		veh.engineHealth = GetVehicleEngineHealth(v)
		veh.bodyHealth = GetVehicleBodyHealth(v)
		veh.fuelLevel = GetVehicleFuelLevel(v)
		veh.oilLevel = GetVehicleOilLevel(v)
		veh.petrolTankHealth = GetVehiclePetrolTankHealth(v)

		veh.tyresburst = {}
		for i = 1, 7 do
			res = IsVehicleTyreBurst(v, i, false)
			if res ~= nil then
				veh.tyresburst[#veh.tyresburst + 1] = res
				if res == false then
					res = IsVehicleTyreBurst(v, i, true)
					veh.tyresburst[#veh.tyresburst] = res
				end
			else
				veh.tyresburst[#veh.tyresburst + 1] = false
			end
		end

		veh.windows = {}
		for i = 1, 13 do
			res = IsVehicleWindowIntact(v, i)
			if res ~= nil then
				veh.windows[#veh.windows + 1] = res
			else
				veh.windows[#veh.windows + 1] = true
			end
		end

		if (veh.plate:gsub("%s+", "") ~= data.plate:gsub("%s+", "")) then
			_ESX.ShowNotification("The processed vehicle, and nearest vehicle do not match")
			return
		end

		data.vehicle = json.encode(veh)
		data.identifier = _VehicleAndOwner.identifier

		local veh = _ESX.Game.GetClosestVehicle()
		TriggerServerEvent("HRP:Impound:ImpoundVehicle", data, VehToNet(veh))

		DisableImpoundMenu()
		cb("ok")
	end
)

RegisterNUICallback(
	"unimpound",
	function(plate, cb)
		TriggerServerEvent("HRP:Impound:UnimpoundVehicle", plate)
		DisableImpoundMenu()
		cb("ok")
	end
)

RegisterNUICallback(
	"unlock",
	function(plate, cb)
		TriggerServerEvent("HRP:Impound:UnlockVehicle", plate)
		DisableImpoundMenu()
	end
)
----------------------------------------------------------------------------------------------------
-- Background tasks
----------------------------------------------------------------------------------------------------

-- Draw markers, which were somehow not added by initial author
Citizen.CreateThread(
	function()
		local letSleep = true
		local retrievePos = vector3(_Impound.RetrieveLocation.X, _Impound.RetrieveLocation.Y, _Impound.RetrieveLocation.Z)

		while true do
			local playerPed = PlayerPedId()
			local pos = GetEntityCoords(playerPed)
			local r, g, b, _ = GetHudColour(12)

			if #(pos - retrievePos) < 20 then
				letSleep = false
				DrawMarker(36, retrievePos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, true, false, false, false)
			end

			for _, v in pairs(_Impound.StoreLocations) do
				local dist = #(pos - vector3(v.x, v.y, v.z))
				if dist < 25 then
					letSleep = false
					local markerPos = vector3(v.x, v.y, v.z - 0.9)
					DrawMarker(25, markerPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, r, g, b, 150, false, true, 2, true, nil, nil, false)
				end
			end

			for _, v in pairs(_Impound.AdminTerminalLocations) do
				local dist = #(pos - vector3(v.x, v.y, v.z))
				if dist < 10 then
					letSleep = false
					DrawMarker(24, vector3(v.x, v.y, v.z), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 100, false, false, 2, true, false, false, false)
				end
			end

			if letSleep then
				Citizen.Wait(1000)
			else
				Citizen.Wait(0)
			end
		end
	end
)

-- Decide what the player is currently doing and showing a help notification.
Citizen.CreateThread(
	function()
		while not NetworkIsSessionActive() do
			Wait(0)
		end

		local function InActiveZone(coords, zone, distance)
			local vZone = vector3(zone.x, zone.y, zone.z)
			return #(coords - vZone) < distance
		end

		while true do
			inZone = false
			if (_DependenciesLoaded) then
				local PlayerPed = PlayerPedId()
				local coords = GetEntityCoords(PlayerPed)

				if #(vector3(_Impound.RetrieveLocation.X, _Impound.RetrieveLocation.Y, _Impound.RetrieveLocation.Z) - vector3(coords.x, coords.y, coords.z)) < 1.0 then
					inZone = true

					_ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to view your impounded vehicles.", true)
					if (_CurrentAction ~= "retrieve") then
						_CurrentAction = "retrieve"
					end
				elseif not inZone then
					for _, v in pairs(_Impound.StoreLocations) do
						if InActiveZone(coords, v, 1.5) then
							inZone = true

							if (ESX?.PlayerData?.job?.name == "lspd" or ESX?.PlayerData?.job?.name == "sahp" or ESX?.PlayerData?.job?.name == "sadot") then
								_ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to impound this vehicle.", true)
								if (_CurrentAction ~= "store") then
									_CurrentAction = "store"
								end
								break
							end
						end
					end

					if not inZone then
						for _, location in pairs(_Impound.AdminTerminalLocations) do
							if InActiveZone(coords, location, 0.5) then
								inZone = true

								if ESX?.PlayerData?.job?.name == "sadot" then
									_ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to open the impound terminal.", true)
									if (_CurrentAction ~= "admin") then
										_CurrentAction = "admin"
									end
									break
								end
							end
						end
					end
				end
			end

			Citizen.Wait(0)

			if not inZone then
				_CurrentAction = nil
			end
		end
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if (IsControlJustReleased(0, 38)) then
				if (_CurrentAction == "retrieve") then
					ShowRetrievalMenu()
				elseif (_CurrentAction == "store") then
					ShowImpoundMenu("store")
				elseif (_CurrentAction == "admin") then
					ShowAdminTerminal("admin")
				end
			end
		end
	end
)

-- Disable background actions if the player is currently in a menu
Citizen.CreateThread(
	function()
		while true do
			if _GuiEnabled then
				local ply = PlayerPedId()
				local active = true
				DisableControlAction(0, 1, active) -- LookLeftRight
				DisableControlAction(0, 2, active) -- LookUpDown
				DisableControlAction(0, 24, active) -- Attack
				DisablePlayerFiring(ply, true) -- Disable weapon firing
				DisableControlAction(0, 142, active) -- MeleeAttackAlternate
				DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
				if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
					SendNUIMessage({type = "click"})
				end
			end
			Citizen.Wait(0)
		end
	end
)

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end
