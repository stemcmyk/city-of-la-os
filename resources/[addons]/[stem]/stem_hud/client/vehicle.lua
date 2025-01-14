-- ################################### --
--									   --
--        I N F O - Version 1.9        --
--									   --
-- ################################### --

-- Cruise Control and Engine Code wrote by TheMrDeivid(https://forum.fivem.net/u/David_Carneiro)
-- RPM and Gears code wrote by Cheleber(https://forum.fivem.net/u/Cheleber) and TheMrDeivid
-- Race Mode Wrote by TheMrDeivid and thanks for the 2 lines of code that saved me Ezy(https://forum.fivem.net/u/ezy/)
-- Race Mode 2 Wrote by TheMrDeivid
-- Race Mode 3 Wrote by TheMrDeivid
-- SeatBelt code wrote by All_Sor (https://forum.fivem.net/u/all_sor) and IndianaBonesUrMom (https://github.com/IndianaBonesUrMom/fivem-seatbelt)
-- Indicators code wrote by TheMrDeivid
-- Heli and Plane HUD wrote and made by TheMrDeivid
-- NOTE: The Cruise Control script it self its not here only the text fuction
-- NOTE: The hazards/indicators script it self its not here this script only detect if they are on or off

-- Please do not steal or sell this script, if you want to use it or modify it, first of all contact me then just give some type of credit!

-- ################################### --
--									   --
--        C   O   N   F   I   G        --
--									   --
-- ################################### --

-- show/hide component


local HUD = {
	Speed = "mph", -- kmh or mph
	DamageSystem = false,
	SpeedIndicator = true,
	ParkIndicator = false,
	Top = true, -- ALL TOP PANAL ( oil, dsc, plate, fluid, ac )
	Plate = false, -- Only if Top is false and you want to keep Plate Number
	Engine = true, -- Engine Status off/on
	Cruise = false, -- Enables/Disables The CRUISE Control status (default key F9)
	CarFuel = true, -- Enables/Disables The fuel status of the car
	CarGears = true, -- Enables/Disables The status of the gears of the car
	RaceMode = false, -- Enables/Disables The Race Mode HUD
	RaceMode2 = false, -- Enables/Disables The Race Mode HUD 2, only if the Race Mode is false
	RaceMode3 = false, -- Enables/Disables The Race Mode HUD 3, only if the Race Mode and RaceMode2 are false - NEW
	SeatBelt = true, -- Enables/Disables The seatbelt option (default key K) - NEW
	Indicators = true, -- Enables/Disables The indicators option - NEW
	DSCDisabled = false
}

local HUDPlane = {
	PlaneSpeed = true, -- Enables/Disables The hud for the heli or plane speed
	Panel = true -- Enagles/Disables The heli or plane panel
}

-- Move the entire UI
local UI = {
	x = 0.035, -- Base Screen Coords 	+ 	 x
	y = -0.035, -- Base Screen Coords 	+ 	-y
	CenterX = 0.0
}

-- Move the entire Race Mode or Race Mode2 or RaceMode3
local RM = {
	x = 0.000, -- Base Screen Coords 	+ 	 x
	y = -0.001 -- Base Screen Coords 	+ 	-y
}

CreateThread(
	function()
		SetScriptGfxAlign(string.byte("L"), string.byte("B"))
		local minimapTopX, minimapTopY = GetScriptGfxPosition(-0.0045, 0.002 + (-0.188888))
		ResetScriptGfxAlign()
		local w, h = GetActiveScreenResolution()
		local pos = {minimapTopX, minimapTopY}

		UI.x = pos[1]
		UI.y = pos[2] - 0.04
		UI.CenterX = (pos[1] + pos[1] + 0.150) / 2
	end
)

-- Change this if you want
local cruisekey = 171 -- CAPSLOCK
local seatbeltkey = 29 -- B
local EngineHpBroken = 110
local EngineHpAlmostBroken = 370
local BodyHpBroken = 50

-- Don't touch this
local cruiseSpeed = 999
local cruisecolor = false
local carspeed = nil
local speedBuffer = {}
local velBuffer = {}
local beltOn = false
local wasInCar = false

-- ################################### --
--									   --
--             C   O   D   E           --
--									   --
-- ################################### --

IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end



Fwv = function(entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then
		hr = 360.0 + hr
	end
	hr = hr * 0.0174533
	return {x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0}
end

CreateThread(
	function()
		while not LocalPlayer.state.switchComplete do
			Wait(0)
		end

		while true do
			Wait(0)

			local MyPed = PlayerPedId()
			local PedHeli = IsPedInAnyHeli(MyPed) -- Checks if the PED is in any Heli
			local PedPlane = IsPedInAnyPlane(MyPed) -- Checks if the PEd is in any Plane
			local PedBoat = IsPedInAnyBoat(MyPed) -- Checks if the PED is in any Boat
			local PedBike = IsPedOnAnyBike(MyPed) -- Checks if the PED is in any Bike or Bicycle

			if (IsPedInAnyVehicle(MyPed, false)) and not LocalPlayer.state.inHeliCam and not LocalPlayer.state.hudHidden and not IsRadarHidden() then
				local MyPedVeh = GetVehiclePedIsIn(PlayerPedId(), false)
				local PlateVeh = GetVehicleNumberPlateText(MyPedVeh)
				local VehStopped = IsVehicleStopped(MyPedVeh)
				local isDriverOrPassenger = (GetPedInVehicleSeat(MyPedVeh, -1) == MyPed) or (GetPedInVehicleSeat(MyPedVeh, 0) == MyPed)
				--  #### 		   EDITED IN			  ####  --
				local Gear = GetVehicleCurrentGear(MyPedVeh) -- Check the current gear of the vehicle
				local RPM = GetVehicleCurrentRpm(MyPedVeh) -- Check the rpm of the vehicle
				local model = GetVehicleClass(MyPedVeh) -- Check the vehicle class/model
				-- local Bumper1 = IsVehicleBumperBrokenOff(MyPedVeh, 0) -- Back Broken Bumper
				-- local Bumper2 = IsVehicleBumperBrokenOff(MyPedVeh, 1) -- Front Broken Bumper
				local Height = GetEntityHeightAboveGround(MyPedVeh) -- Check the height above the ground
				local Roll = GetEntityRoll(MyPedVeh) -- Check the roll of the plane
				local Pitch = GetEntityPitch(MyPedVeh) -- Check the pitch of the plane
				local MainRotor = GetHeliMainRotorHealth(MyPedVeh) -- Check the Main Rotor of the heli
				local TailRotor = GetHeliTailRotorHealth(MyPedVeh) -- Check the Tail Rotor of the heli
				local EngineRunning = GetIsVehicleEngineRunning(MyPedVeh) -- Check if the engine is running
				local get_collision_veh = HasEntityCollidedWithAnything(MyPedVeh) -- Check if the vehicle hit something
				local LandingGear0 = GetLandingGearState(MyPedVeh) -- Check the state of the landing gear
				--  #### SOME STUFF THAT YOU CAN'T CHANGE ####  --
				if RPM > 0.99 then
					RPM = RPM * 100
					RPM = RPM + math.random(-2, 2)
					RPM = RPM / 100
				end

				local useMetric = ShouldUseMetricMeasurements()

				--  ####         	 PLANE HUD	  	  	  ####  --
				if PedPlane then
					if HUDPlane.PlaneSpeed then
						carhud_drawRct(UI.x + 0.11, UI.y + 0.932, 0.046, 0.03, 0, 0, 0, 150)
						Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * (useMetric and 3.6 or 2.24)
						carhud_drawTxt(UI.x + 0.61, UI.y + 1.42, 1.0, 1.0, 0.64, "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
						carhud_drawTxt(UI.x + 0.633, UI.y + 1.432, 1.0, 1.0, 0.4, "~w~ knots", 255, 255, 255, 255)
					else
						speed = 0.0
					end

					if HUDPlane.Panel then
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.09, 1.0, 1.0, 0.44, "ROLL: " .. math.ceil(Roll), 20, 235, 85, 255)
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.115, 1.0, 1.0, 0.44, "ALT: " .. math.ceil(Height), 20, 235, 85, 255)
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.14, 1.0, 1.0, 0.44, "PITCH: " .. math.ceil(Pitch), 20, 235, 85, 255)

						if LandingGear0 then
							carhud_drawTxt(UI.x + 0.005, UI.y + 0.165, 1.0, 1.0, 0.44, "LND GEAR", 20, 235, 85, 255) -- Red
						else
							carhud_drawTxt(UI.x + 0.005, UI.y + 0.165, 1.0, 1.0, 0.44, "LND GEAR", 20, 235, 85, 255) -- Green
						end

						if EngineRunning then
							carhud_drawTxt(UI.x + 0.620, UI.y + 1.240, 1.0, 1.0, 0.44, "ENG", 0, 255, 0, 200) -- Green
						else
							carhud_drawTxt(UI.x + 0.620, UI.y + 1.240, 1.0, 1.0, 0.44, "ENG", 255, 0, 0, 200) -- Red
						end
					end
				end

				if PedHeli then
					if HUDPlane.PlaneSpeed then
						-- carhud_drawRct(UI.x + 0.11, UI.y + 0.932, 0.046, 0.03, 0, 0, 0, 150)
						Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * (useMetric and 3.6 or 2.24)
						carhud_drawTxt(UI.x + 0.61, UI.y + 1.42, 1.0, 1.0, 0.64, "~w~" .. math.ceil(Speed), 255, 255, 255, 255)
						carhud_drawTxt(UI.x + 0.633, UI.y + 1.432, 1.0, 1.0, 0.4, "~w~ knots", 255, 255, 255, 255)
					else
						speed = 0.0
					end

					if HUDPlane.Panel then
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.09, 1.0, 1.0, 0.44, "ROLL: " .. math.ceil(Roll), 20, 235, 85, 255)
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.115, 1.0, 1.0, 0.44, "ALT: " .. math.ceil(Height), 20, 235, 85, 255)
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.14, 1.0, 1.0, 0.44, "PITCH: " .. math.ceil(Pitch), 20, 235, 85, 255)

						if (MainRotor < 350) and (MainRotor > 151) then
							carhud_drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0, 1.0, 0.45, "Main Rotor", 255, 255, 0, 200)
						elseif (MainRotor > 1) and (MainRotor < 150) then
							carhud_drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0, 1.0, 0.45, "Main Rotor", 255, 0, 0, 200)
						elseif (MainRotor == 0) then
							carhud_drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0, 1.0, 0.45, "Main Rotor", 255, 0, 0, 200)
						elseif not EngineRunning then
							carhud_drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0, 1.0, 0.45, "Main Rotor", 255, 0, 0, 200)
						else
							carhud_drawTxt(UI.x + 0.514, UI.y + 1.240, 1.0, 1.0, 0.45, "Main Rotor", 0, 255, 0, 200)
						end

						if (TailRotor < 350) and (TailRotor > 151) then
							carhud_drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0, 1.0, 0.45, "Tail Rotor", 255, 255, 0, 200)
						elseif (TailRotor > 1) and (TailRotor < 150) then
							carhud_drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0, 1.0, 0.45, "Tail Rotor", 255, 0, 0, 200)
						elseif (TailRotor == 0) then
							carhud_drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0, 1.0, 0.45, "Tail Rotor", 255, 0, 0, 200)
						elseif not EngineRunning then
							carhud_drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0, 1.0, 0.45, "Tail Rotor", 255, 0, 0, 200)
						else
							carhud_drawTxt(UI.x + 0.560, UI.y + 1.240, 1.0, 1.0, 0.45, "Tail Rotor", 0, 255, 0, 200)
						end

						if EngineRunning then
							carhud_drawTxt(UI.x + 0.620, UI.y + 1.240, 1.0, 1.0, 0.45, "ENG", 0, 255, 0, 200)
						else
							carhud_drawTxt(UI.x + 0.620, UI.y + 1.240, 1.0, 1.0, 0.45, "ENG", 255, 0, 0, 200)
						end
					end
				end
				--  ####         	 PLANE HUD	  	  	  ####  --

				if PedHeli or PedPlane or PedBoat then
					if useMetric then
						Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * (useMetric and 3.6 or 2.24) * 0.539957
					else
						Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * (useMetric and 3.6 or 2.24) * 0.868976
					end
				else
					Speed = GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false)) * (useMetric and 3.6 or 2.24)
				end

				if HUD.Cruise and PedHeli == false and PedPlane == false and PedBoat == false and PedBike == false and isDriverOrPassenger then

					if IsControlJustPressed(1, cruisekey) and not VehStopped and cruisecolor == false then -- F9
						if GetPedInVehicleSeat(MyPedVeh, -1) == MyPed then
							cruisecolor = true
							cruiseSpeed = GetEntitySpeed(MyPedVeh)

							exports["mythic_notify"]:PersistentAlert(
								"START",
								"cruise",
								"success",
								"CRUISE: " .. math.floor(cruiseSpeed * (useMetric and 3.6 or 2.23)) .. (useMetric and " K.P.H." or " M.P.H.")
							)
						end
					elseif IsControlJustPressed(1, cruisekey) and cruisecolor == true then -- F9
						if GetPedInVehicleSeat(MyPedVeh, -1) == MyPed then
							cruisecolor = false
							cruiseSpeed = 999
							exports["mythic_notify"]:PersistentAlert("END", "cruise")
						end
					end

					if IsControlJustPressed(1, 8) and cruisecolor == true then -- S
						exports["mythic_notify"]:PersistentAlert("END", "cruise")
						cruisecolor = false
					end
					if get_collision_veh then -- If you hit something the cruise text will turn red
						exports["mythic_notify"]:PersistentAlert("END", "cruise")
						cruisecolor = false
					end
					if (Speed < 20) then
						exports["mythic_notify"]:PersistentAlert("END", "cruise")
						cruisecolor = false
					end
					local maxSpeed = cruisecolor and cruiseSpeed or GetVehicleHandlingFloat(MyPedVeh, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(MyPedVeh, maxSpeed)

					if cruisecolor then
						SetControlNormal(0, 71, 1.0)
					end
				end

				-- Draw plate of vehicle
				if isDriverOrPassenger then
					local odometer = Entity(MyPedVeh).state.odometer
					if odometer ~= nil then
						local odometer_display = ESX.Math.GroupDigits(math.floor((odometer / 1000) * 0.6213712)) .. " mi."
						carhud_drawTxt(UI.CenterX, UI.y + 0.03, 1.0, 1.0, 0.4, "~w~" .. odometer_display, 255, 255, 255, 255, true)
					end

					-- carhud_drawTxt(UI.CenterX, UI.y + 0.03, 1.0, 1.0, 0.55, "~w~" .. PlateVeh, 255, 255, 255, 255, true)
				end

				if HUD.SpeedIndicator and isDriverOrPassenger then
					local r, g, b = 255, 255, 255
					if useMetric then
						carhud_drawTxt(
							UI.x + 0.005,
							UI.y + 0.04,
							1.0,
							1.0,
							0.5,
							"~w~" .. math.ceil(Speed) .. ((PedBoat or PedHeli or PedPlane) and " KTS" or " KPH"),
							r,
							g,
							b,
							200
						)
					else
						carhud_drawTxt(
							UI.x + 0.005,
							UI.y + 0.04,
							1.0,
							1.0,
							0.5,
							"~w~" .. math.ceil(Speed) .. ((PedBoat or PedHeli or PedPlane) and " KTS" or " MPH"),
							r,
							g,
							b,
							200
						)
					end
				end

				if HUD.CarFuel and (model ~= 13) and not blacklist and isDriverOrPassenger then
					local fuel = math.ceil(carhud_round(Entity(MyPedVeh).state.fuel or 100, 2))
					if fuel <= 20 then
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.065, 1.0, 1.0, 0.4, "~y~" .. fuel .. "% FUEL~s~", 255, 255, 255, 200)
					else
						carhud_drawTxt(UI.x + 0.005, UI.y + 0.065, 1.0, 1.0, 0.4, "~w~" .. fuel .. "% FUEL~s~", 255, 255, 255, 200)
					end
				end
			end
		end
	end
)

function carhud_round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function carhud_drawTxt(x, y, width, height, scale, text, r, g, b, a, center)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextCentre(center and true or false)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function carhud_drawRct(x, y, width, height, r, g, b, a)
	DrawRect(x, y, width, height, r, g, b, a)
end

function ToggleDSC()
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
	if veh == 0 then
		return
	end
	if GetVehicleClass(veh) == 4 or GetVehicleClass(veh) == 5 or GetVehicleClass(veh) == 6 or GetVehicleClass(veh) == 7 then
		HUD.DSCDisabled = not HUD.DSCDisabled
		SetDriftTyresEnabled(veh, HUD.DSCDisabled)

		if not HUD.DSCDisabled then
			exports["mythic_notify"]:DoHudText("inform", "DSC: ON")
		else
			exports["mythic_notify"]:DoHudText(
				"inform",
				"/!\\ DSC: OFF",
				{
					["background-color"] = "#FF9933",
					["color"] = "#000000"
				}
			)
		end
	end
end
