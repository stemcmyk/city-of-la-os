local CurrentAction = nil
local CurrentActionMsg = nil
local CurrentActionData = nil
local Licenses = {}
local CurrentTest = nil
local CurrentTestType = nil
local CurrentVehicle = nil
local CurrentCheckPoint = 0
local LastCheckPoint = -1
local CurrentBlip = nil
local CurrentZoneType = nil
local DriveErrors = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

exports.ox_inventory:displayMetadata({
    firstname = "FN",
    lastname = "LN",
    dateofbirth = "DOB",
    sex = "SEX",
    height = "HGT"
})

function DrawMissionText(msg, time)
	ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function StartTheoryTest()
	CurrentTest = "theory"

	SendNUIMessage(
		{
			openQuestion = true
		}
	)

	ESX.SetTimeout(
		200,
		function()
			SetNuiFocus(true, true)
		end
	)
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage(
		{
			openQuestion = false
		}
	)

	SetNuiFocus(false)

	if success then
		PlayMissionCompleteAudio("FRANKLIN_BIG_01")
		TriggerServerEvent('stem_dmv:addLicense', 'dmv')
		ESX.ShowNotification(_U("passed_test"), "success")

		Citizen.SetTimeout(
			1500,
			function()
				AnimpostfxPlay("SuccessFranklin")
			end
		)

		local hasPermit = false
		while not hasPermit do
			for i = 1, #Licenses, 1 do
				if Licenses[i].type == "dmv" then
					hasPermit = true
				end
			end

			Citizen.Wait(0)
		end

		OpenDMVSchoolMenu()
	else
		ESX.ShowNotification(_U("failed_test"), "error")
	end
end

function StartDriveTest(testType)
	ESX.TriggerServerCallback(
		"stem-dmv:canPay",
		function(bool)
			if bool then
				ESX.Game.SpawnVehicle(Config.VehicleModels[testType], vector3(Config.Zones.VehicleSpawnPoint.Pos.x, Config.Zones.VehicleSpawnPoint.Pos.y, Config.Zones.VehicleSpawnPoint.Pos.z), Config.Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
					TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
					CurrentTest = "drive"
					CurrentTestType = testType
					CurrentCheckPoint = 0
					LastCheckPoint = -1
					CurrentZoneType = "residence"
					DriveErrors = 0
					IsAboveSpeedLimit = false
					CurrentVehicle = vehicle
					LastVehicleHealth = GetEntityHealth(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					exports["wasabi_carlock"]:GiveKey(plate)
					exports["esx-sna-fuel"]:SetFuel(vehicle, 100)
				end)
			else
				ESX.ShowHelpNotification("You do not have enough money to start the test.")
			end
		end,
		testType
	)
end

function StopDriveTest(success)
	if success then
		PlayMissionCompleteAudio("FRANKLIN_BIG_01")
		TriggerServerEvent("stem_dmv:addLicense", CurrentTestType)
		ESX.ShowNotification(_U("passed_test"), "success")

		Citizen.SetTimeout(
			1500,
			function()
				AnimpostfxPlay("SuccessFranklin")
			end
		)
	else
		ESX.ShowNotification(_U("failed_test"), "error")
	end

	CurrentTest = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
	CurrentZoneType = type
end


function OpenSetVanityPlateMenu()
    local input =
        lib.inputDialog(
            "Set Vanity Plate",
            {
                {
                    type = "input",
                    label = "New Plate",
                    description = "All plates must be between 3 and 8 characters.",
                    required = true
                }
            }
        )

    if not input or not input[1] then
        return
    end

    return input[1]
end

function OpenVanityPlateMenu()
	ESX.TriggerServerCallback(
		"stem-dmv:fetchAllOwnedVehicles",
		function(vehicles)
			local elem = {}

			for _, v in pairs(vehicles) do
				local hashVehicule = v.vehicle.model
				local vehicleName =  v.vehiclename or GetLabelText(GetMakeNameFromVehicleModel(hashVehicule))
				local vehicleModel = GetDisplayNameFromVehicleModel(hashVehicule)		
				
				local labelvehicle

				if v.state == false then
					local output = string.format('%s: [%s] In Garage', (vehicleName), v.plate)
					elem[#elem + 1] = {label = output, value = v.plate, name = vehicleName, model = vehicleModel}
				else
					local output = string.format('%s: [%s] Already Out', (vehicleName), v.plate)
					elem[#elem + 1] = {label = output, value = nil, name = vehicleName, model = vehicleModel}
				end
			end

			
			lib.registerMenu({
				id = "dmv_vanity",
				title = "Set Vanity Plate(s)",
				options = exports.stem_common:tableMap(elem, function (element) 
						return {
							label = element.label,
							args = { value = element.value, type = element.type}
						}
					end),
				position = "top-right",
			}, function (selected, scrollIndex, args) 
				if not args.value then
					lib.hideMenu()
					ESX.ShowNotification("Vehicle is already out, cannot change plates", "error")
				else
					lib.hideMenu()

					local plate = OpenSetVanityPlateMenu()
					plate = plate:gsub("%s", "")
					plate = plate:upper()

					local bIsAllowed = exports['stem_common']:IsStringPassedProfanityCheck(plate)
					if not bIsAllowed then
						ESX.ShowNotification('Profanity or offensive language is not allowed.', "error")
						return
					end

					if plate:match('[IOQ]') then
						ESX.ShowNotification('The following characters are not allowed: **I, O, Q**', "error")
						return
					end

					local len = plate:len()
					if len < 3 or len > 8 then
						ESX.ShowNotification("Vanity plates require a **minimum length of 3 characters** and a **maximum length of 8 characters**", "error")
						return
					end

					if plate:match("%W") then
						ESX.ShowNotification("Vanity plates are required to be **alphanumeric**", "error")
						return
					end

					TriggerServerEvent("stem_dmv:vanityPlate", args.value, plate, args.name, args.model)
				end
			end)
			
			lib.hideMenu()

			lib.showMenu("dmv_vanity")
		end,
		"square"
	)
end

function OpenChangeIdentificationMenu()
    local minDate = Config.DateFormat
    minDate = string.gsub(minDate, "[Yy][Yy][Yy][Yy]", Config.LowestYear) -- Replace "YYYY" or "yyyy" with Config.LowestYear
    minDate = string.gsub(minDate, "[Mm][Mm]", "01")                      -- Replace "MM" or "mm" with "01"
    minDate = string.gsub(minDate, "[Dd][Dd]", "01")                      -- Replace "DD" or "dd" with "01"

    local maxDate = Config.DateFormat
    maxDate = string.gsub(maxDate, "[Yy][Yy][Yy][Yy]", Config.HighestYear + 1) -- Replace "YYYY" or "yyyy" with Config.HighestYear
    maxDate = string.gsub(maxDate, "[Mm][Mm]", "01")                           -- Replace "MM" or "mm" with "01"
    maxDate = string.gsub(maxDate, "[Dd][Dd]", "01")        

       

	local input =
		lib.inputDialog(
		"Identity Change or Correction",
		{
			{type = "input", label = "First Name", description = "Legal first name. Required.", placeholder = "John"},
			{type = "input", label = "Last Name", description = "Legal last name. Required.", placeholder = "Smith"},
			{
				type = "date",
				label = "Date Of Birth",
				description = "Your character's date-of-birth",
				required = true,
				format = Config.DateFormat,
				min = minDate,
				max = maxDate
			},
			{
				type = "number",
				label = "Height (CM)",
				description = "Your character's height",
				placeholder = "Height (CM)",
				min = 120,
				max = 220
			},
			{
				type = "select",
				label = "Sex",
				options = {
					{value = "m", label = "Male"},
					{value = "f", label = "Female"}
				}
			}
		}
	)

	if not input[1] or not input[2] or input[1]:len() < 2 or input[1]:len() > 20 or input[2]:len() < 3 or input[2]:len() > 20 then
		lib.defaultNotify({title = "Error", description = "First or last name must be between 2 and 20 characters in length.", variant = "solid", status = "error"})
		return
	end

	if input[1]:find("%A") ~= nil or input[2]:find("%A") ~= nil then
		lib.defaultNotify(
			{title = "Error", description = "Firstname and lastname cannot contain non-alphabetical or whitespace characters.", variant = "solid", status = "error"}
		)
		return
	end

	if not exports['stem_common']:IsStringPassedProfanityCheck(input[1]) or not exports['stem_common']:IsStringPassedProfanityCheck(input[2]) then
		lib.defaultNotify(
			{title = "Error", description = "This name is not allowed. Please change your name and try again.", variant = "solid", status = "error"}
		)
		return
	end

	TriggerServerEvent("stem_dmv:requestIdentityChange", input)
end

function OpenPointsHistoryMenu()
	ESX.TriggerServerCallback(
		"stem_dmv:viewPoints",
		function(data)
			local elements = {
				head = {("Date Assessed"), ("Amount"), ("Violation"), ("Date Expunged")},
				rows = {}
			}

			for i = 1, #data do
				rows[#rows + 1] = {
					cols = {
						data[i].dateReceived,
						data[i].amount,
						data[i].violation,
						data[i].dateExpunged
					}
				}
			end

			ESX.UI.Menu.Open(
				"list",
				GetCurrentResourceName(),
				"points_history",
				elements,
				function(data, menu)
					menu.close()
				end,
				function(data, menu)
					menu.close()
				end
			)
		end
	)
end

-- RegisterCommand("forcePassTheory", function ( ) 
-- 	TriggerServerEvent('stem_dmv:addLicense', 'dmv')
-- 	ESX.ShowNotification(TranslateCap('passed_test'), "success")
-- end, true)


function OpenDMVSchoolMenu()
	local ownedLicenses = {}

	for i = 1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {}

	if not ownedLicenses["dmv"] then
		table.insert(elements, {label = _U("theory_test") .. Config.Prices["dmv"], value = "theory_test"})
	end

	if ownedLicenses["dmv"] then
		if not ownedLicenses["drive"] then
			table.insert(elements, {label = _U("road_test_car") .. Config.Prices["drive"], value = "drive_test", type = "drive"})
		end

		if not ownedLicenses["drive_bike"] and ownedLicenses["drive"] then
			table.insert(elements, {label = _U("road_test_bike") .. Config.Prices["drive_bike"], value = "drive_test", type = "drive_bike"})
		end

		if not ownedLicenses["drive_truck"] and ownedLicenses["drive"] then
			table.insert(elements, {label = _U("road_test_truck") .. Config.Prices["drive_truck"], value = "drive_test", type = "drive_truck"})
		end
	end

	
	if ownedLicenses["drive"] and ownedLicenses["dmv"] and ownedLicenses["boat"] then 
		table.insert(elements, {label = _U("boat_license_replace", ESX.Math.GroupDigits(Config.LicenseReplacementFee)), value = "boat_replace", type = "boat_replace"})
	else
		table.insert(elements, {label = _U("purchase_boat_license", ESX.Math.GroupDigits(Config.BoatPurchaseLicenseFee)) , value = "boat_purchase", type = "boat_purchase"})
	end

	if ownedLicenses["drive"] then
		local supporterAccess = LocalPlayer.state.supporterAccess
		if (supporterAccess and exports.stem_common:tableContains(supporterAccess, "gold")) then
			elements[#elements + 1] = {label = _U("vanity_plate").. ESX.Math.GroupDigits(Config.VanityPlateFee), value = "vanity_plate"}
			elements[#elements + 1] = {label = _U("id_change") .. ESX.Math.GroupDigits(Config.LicenseChangeFee), value = "change_id"}
			return
		end
		elements[#elements + 1] = {label = _U("request_license") .. ESX.Math.GroupDigits(Config.LicenseReplacementFee), value = "request_license"}
		-- elements[#elements + 1] = {label = "Check License Status", value = "check_status"}
		-- elements[#elements + 1] = {label = "Check Points History", value = "check_points"}
		-- elements[#elements + 1] = {label = "Restore License ($" .. ESX.Math.GroupDigits(Config.RestoreLicenseFee) ..")", value = "restore_license"}
	end

	if ownedLicenses["drive"] or ownedLicenses["drive_truck"] then
	end

	lib.registerMenu({
		id = "dmv",
		title = _U("driving_school"),
		options = exports.stem_common:tableMap(elements, function (element) 
				return {
					label = element.label,
					args = { value = element.value, type = element.type}
				}
			end),
		position = "top-right",
	}, function (selected, scrollIndex, args) 
			if args.value == "theory_test" then
				lib.hideMenu()
				StartTheoryTest()
			end

			if args.value == "drive_test" then
				lib.hideMenu()
				StartDriveTest(args.type)
			end

			if args.value == "check_status" then
				lib.hideMenu()
				TriggerServerEvent("stem_dmv:checkLicenseStatus")
			end

			if args.value == "check_points" then
				lib.hideMenu()
				OpenPointsHistoryMenu()
			end

			if args.value == "restore_license" then
				lib.hideMenu()
				TriggerServerEvent("stem_dmv:restoreLicense")
			end

			if args.value == "vanity_plate" then
				lib.hideMenu()
				OpenVanityPlateMenu()
			end

			if args.value == "request_license" then
				lib.hideMenu()
				TriggerServerEvent("stem_dmv:requestLicenseItem", "drive")
			end

			if args.value == "change_id" then
				lib.hideMenu()
				OpenChangeIdentificationMenu()
			end

			if args.value == "boat_replace" then
				lib.hideMenu()
				TriggerServerEvent("stem_dmv:requestLicenseItem", "boat")
			end
			
			if args.value == "boat_purchase" then
				lib.hideMenu()
				TriggerServerEvent("stem_dmv:purchaseBoatLicense")
			end
	end)
	
	lib.hideMenu()

	lib.showMenu("dmv")

	-- ESX.UI.Menu.Open(
	-- 	"default",
	-- 	GetCurrentResourceName(),
	-- 	"dmvschool_actions",
	-- 	{
	-- 		title = _U("driving_school"),
	-- 		align = "right",
	-- 		elements = elements
	-- 	},
	-- 	function(data, menu)
	-- 		if data.current.value == "theory_test" then
	-- 			menu.close()
	-- 			StartTheoryTest()
	-- 		end

	-- 		if data.current.value == "drive_test" then
	-- 			menu.close()
	-- 			StartDriveTest(data.current.type)
	-- 		end

	-- 		if data.current.value == "check_status" then
	-- 			menu.close()
	-- 			TriggerServerEvent("noire-dmv:checkLicenseStatus")
	-- 		end

	-- 		if data.current.value == "check_points" then
	-- 			menu.close()
	-- 			OpenPointsHistoryMenu()
	-- 		end

	-- 		if data.current.value == "restore_license" then
	-- 			menu.close()
	-- 			TriggerServerEvent("noire-dmv:restoreLicense")
	-- 		end

	-- 		if data.current.value == "vanity_plate" then
	-- 			menu.close()
	-- 			OpenVanityPlateMenu()
	-- 		end

	-- 		if data.current.value == "request_license" then
	-- 			menu.close()
	-- 			TriggerServerEvent("noire-dmv:requestLicenseItem")
	-- 		end

	-- 		if data.current.value == "change_id" then
	-- 			menu.close()
	-- 			OpenChangeIdentificationMenu()
	-- 		end
	-- 	end,
	-- 	function(data, menu)
	-- 		menu.close()

	-- 		CurrentAction = "dmvschool_menu"
	-- 		CurrentActionMsg = _U("press_open_menu")
	-- 		CurrentActionData = {}
	-- 	end
	-- )
end

RegisterNUICallback(
	"question",
	function(data, cb)
		SendNUIMessage(
			{
				openSection = "question"
			}
		)

		cb("OK")
	end
)

RegisterNUICallback(
	"close",
	function(data, cb)
		StopTheoryTest(true)
		cb("OK")
	end
)

RegisterNUICallback(
	"kick",
	function(data, cb)
		StopTheoryTest(false)
		cb("OK")
	end
)

AddEventHandler(
	"stem_dmv:hasEnteredMarker",
	function(zone)
		if zone == "DMVSchool" then
			CurrentAction = "dmvschool_menu"
			CurrentActionMsg = _U("press_open_menu")
			CurrentActionData = {}
		end
	end
)

AddEventHandler(
	"stem_dmv:hasExitedMarker",
	function(zone)
		CurrentAction = nil
		ESX.UI.Menu.CloseAll()
	end
)

RegisterNetEvent("stem_dmv:loadLicenses")
AddEventHandler(
	"stem_dmv:loadLicenses",
	function(licenses)
		Licenses = licenses
	end
)

-- Create Blips
Citizen.CreateThread(
	function()
		local blip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)

		SetBlipSprite(blip, 498)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.9)
		SetBlipColour(blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U("driving_school_blip"))
		EndTextCommandSetBlipName(blip)
	end
)

-- Display markers
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local coords = GetEntityCoords(PlayerPedId())

			for k, v in pairs(Config.Zones) do
				if (v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(
						v.Type,
						v.Pos.x,
						v.Pos.y,
						v.Pos.z,
						0.0,
						0.0,
						0.0,
						0,
						0.0,
						0.0,
						v.Size.x,
						v.Size.y,
						v.Size.z,
						v.Color.r,
						v.Color.g,
						v.Color.b,
						100,
						false,
						true,
						2,
						false,
						false,
						false,
						false
					)
				end
			end
		end
	end
)

-- Enter / Exit marker events
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil

			for k, v in pairs(Config.Zones) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone = currentZone
				--TriggerServerEvent('esx_dmvschool:refreshLicenses')
				TriggerEvent("stem_dmv:hasEnteredMarker", currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent("stem_dmv:hasExitedMarker", LastZone)
			end
		end
	end
)

-- Block UI
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if CurrentTest == "theory" then
				local playerPed = PlayerPedId()

				DisableControlAction(0, 1, true) -- LookLeftRight
				DisableControlAction(0, 2, true) -- LookUpDown
				DisablePlayerFiring(playerPed, true) -- Disable weapon firing
				DisableControlAction(0, 142, true) -- MeleeAttackAlternate
				DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			end
		end
	end
)

-- Key Controls
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat("STRING")
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) then
					if CurrentAction == "dmvschool_menu" then
						OpenDMVSchoolMenu()
					end

					CurrentAction = nil
				end
			end
		end
	end
)

-- Drive test
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if CurrentTest == "drive" then
				local playerPed = PlayerPedId()
				local coords = GetEntityCoords(playerPed)
				local nextCheckPoint = CurrentCheckPoint + 1

				if DriveErrors > Config.MaxErrors then
					StopDriveTest(false)
				end

				if Config.CheckPoints[nextCheckPoint] == nil then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentTest = nil

					ESX.ShowNotification(_U("driving_test_complete"))

					if DriveErrors < Config.MaxErrors then
						StopDriveTest(true)
					else
						StopDriveTest(false)
					end
				else
					if CurrentCheckPoint ~= LastCheckPoint then
						if DoesBlipExist(CurrentBlip) then
							RemoveBlip(CurrentBlip)
						end

						CurrentBlip =
							AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
						SetBlipRoute(CurrentBlip, 1)

						LastCheckPoint = CurrentCheckPoint
					end

					local distance =
						GetDistanceBetweenCoords(
						coords,
						Config.CheckPoints[nextCheckPoint].Pos.x,
						Config.CheckPoints[nextCheckPoint].Pos.y,
						Config.CheckPoints[nextCheckPoint].Pos.z,
						true
					)

					if distance <= 100.0 then
						DrawMarker(
							1,
							Config.CheckPoints[nextCheckPoint].Pos.x,
							Config.CheckPoints[nextCheckPoint].Pos.y,
							Config.CheckPoints[nextCheckPoint].Pos.z,
							0.0,
							0.0,
							0.0,
							0,
							0.0,
							0.0,
							1.5,
							1.5,
							1.5,
							102,
							204,
							102,
							100,
							false,
							true,
							2,
							false,
							false,
							false,
							false
						)
					end

					if distance <= 3.0 then
						Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
						CurrentCheckPoint = CurrentCheckPoint + 1
					end
				end
			end
		end
	end
)

-- Speed / Damage control
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)

			if CurrentTest == "drive" then
				local playerPed = PlayerPedId()

				if IsPedInAnyVehicle(playerPed, false) then
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					local speed = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
					local tooMuchSpeed = false

					for k, v in pairs(Config.SpeedLimits) do
						if CurrentZoneType == k and speed > v then
							tooMuchSpeed = true

							if not IsAboveSpeedLimit then
								DriveErrors = DriveErrors + 1
								IsAboveSpeedLimit = true

								ESX.ShowNotification(_U("driving_too_fast") .. v .. " M.P.H.", "error")
								ESX.ShowNotification(_U("errors") .. DriveErrors .. "/" .. Config.MaxErrors, "error")
							end
						end
					end

					if not tooMuchSpeed then
						IsAboveSpeedLimit = false
					end

					local health = GetEntityHealth(vehicle)

					if health < LastVehicleHealth then
						DriveErrors = DriveErrors + 1

						ESX.ShowNotification(_U("you_damaged_veh"))
						ESX.ShowNotification(_U("errors") .. DriveErrors .. "/" .. Config.MaxErrors, "error")
						LastVehicleHealth = health
					end
				end
			end
		end
	end
)
