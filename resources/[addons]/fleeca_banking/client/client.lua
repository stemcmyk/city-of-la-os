
local PlayerData = {}
local ox_target = exports.ox_target



local banks = {
	{name="Bank", closed = false, id=108, x=150.266, y=-1040.203, z=29.374},
	{name="Bank", closed = false, id=108, x=-1212.980, y=-330.841, z=37.787},
	{name="Bank", closed = false, id=108, x=-2962.582, y=482.627, z=15.703},
	{name="Bank", closed = false, id=108, x=-112.202, y=6469.295, z=31.626},
	{name="Bank", closed = false, id=108, x=314.187, y=-278.621, z=54.170},
	{name="Bank", closed = false, id=108, x=-351.534, y=-49.529, z=49.042},
	{name="Pacific Bank", closed = false, id=106, x=241.727, y=220.706, z=106.286, principal = true},
	{name="Bank", closed = false, id=108, x=1175.0643310547, y=2706.6435546875, z=38.094036102295}
}

local atms = {
	{name="ATM", id=277, x=-386.733, y=6045.953, z=31.501},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
	{name="ATM", id=277, x=-135.165, y=6365.738, z=31.101},
	{name="ATM", id=277, x=-110.753, y=6467.703, z=31.784},
	{name="ATM", id=277, x=-94.9690, y=6455.301, z=31.784},
	{name="ATM", id=277, x=155.4300, y=6641.991, z=31.784},
	{name="ATM", id=277, x=174.6720, y=6637.218, z=31.784},
	{name="ATM", id=277, x=1703.138, y=6426.783, z=32.730},
	{name="ATM", id=277, x=1735.114, y=6411.035, z=35.164},
	{name="ATM", id=277, x=1702.842, y=4933.593, z=42.051},
	{name="ATM", id=277, x=1967.333, y=3744.293, z=32.272},
	{name="ATM", id=277, x=1821.917, y=3683.483, z=34.244},
	{name="ATM", id=277, x=1174.532, y=2705.278, z=38.027},
	{name="ATM", id=277, x=540.0420, y=2671.007, z=42.177},
	{name="ATM", id=277, x=2564.399, y=2585.100, z=38.016},
	{name="ATM", id=277, x=2558.683, y=349.6010, z=108.050},
	{name="ATM", id=277, x=2558.051, y=389.4817, z=108.660},
	{name="ATM", id=277, x=1077.692, y=-775.796, z=58.218},
	{name="ATM", id=277, x=1139.018, y=-469.886, z=66.789},
	{name="ATM", id=277, x=1168.975, y=-457.241, z=66.641},
	{name="ATM", id=277, x=1153.884, y=-326.540, z=69.245},
	{name="ATM", id=277, x=381.2827, y=323.2518, z=103.270},
	{name="ATM", id=277, x=236.4638, y=217.4718, z=106.840},
	{name="ATM", id=277, x=265.0043, y=212.1717, z=106.780},
	{name="ATM", id=277, x=285.2029, y=143.5690, z=104.970},
	{name="ATM", id=277, x=157.7698, y=233.5450, z=106.450},
	{name="ATM", id=277, x=-164.568, y=233.5066, z=94.919},
	{name="ATM", id=277, x=-1827.04, y=785.5159, z=138.020},
	{name="ATM", id=277, x=-1409.39, y=-99.2603, z=52.473},
	{name="ATM", id=277, x=-1205.35, y=-325.579, z=37.870},
	{name="ATM", id=277, x=-1215.64, y=-332.231, z=37.881},
	{name="ATM", id=277, x=-2072.41, y=-316.959, z=13.345},
	{name="ATM", id=277, x=-2975.72, y=379.7737, z=14.992},
	{name="ATM", id=277, x=-2962.60, y=482.1914, z=15.762},
	{name="ATM", id=277, x=-2955.70, y=488.7218, z=15.486},
	{name="ATM", id=277, x=-3044.22, y=595.2429, z=7.595},
	{name="ATM", id=277, x=-3144.13, y=1127.415, z=20.868},
	{name="ATM", id=277, x=-3241.10, y=996.6881, z=12.500},
	{name="ATM", id=277, x=-3241.11, y=1009.152, z=12.877},
	{name="ATM", id=277, x=-1305.40, y=-706.240, z=25.352},
	{name="ATM", id=277, x=-538.225, y=-854.423, z=29.234},
	{name="ATM", id=277, x=-711.156, y=-818.958, z=23.768},
	{name="ATM", id=277, x=-717.614, y=-915.880, z=19.268},
	{name="ATM", id=277, x=-526.566, y=-1222.90, z=18.434},
	{name="ATM", id=277, x=-256.831, y=-719.646, z=33.444},
	{name="ATM", id=277, x=-203.548, y=-861.588, z=30.205},
	{name="ATM", id=277, x=112.4102, y=-776.162, z=31.427},
	{name="ATM", id=277, x=112.9290, y=-818.710, z=31.386},
	{name="ATM", id=277, x=119.9000, y=-883.826, z=31.191},
	{name="ATM", id=277, x=149.4551, y=-1038.95, z=29.366},
	{name="ATM", id=277, x=-846.304, y=-340.402, z=38.687},
	{name="ATM", id=277, x=-1204.35, y=-324.391, z=37.877},
	{name="ATM", id=277, x=-1216.27, y=-331.461, z=37.773},
	{name="ATM", id=277, x=-56.1935, y=-1752.53, z=29.452},
	{name="ATM", id=277, x=-261.692, y=-2012.64, z=30.121},
	{name="ATM", id=277, x=-273.001, y=-2025.60, z=30.197},
	{name="ATM", id=277, x=314.187, y=-278.621, z=54.170},
	{name="ATM", id=277, x=-351.534, y=-49.529, z=49.042},
	{name="ATM", id=277, x=24.589, y=-946.056, z=29.357},
	{name="ATM", id=277, x=-254.112, y=-692.483, z=33.616},
	{name="ATM", id=277, x=-1570.197, y=-546.651, z=34.955},
	{name="ATM", id=277, x=-1415.909, y=-211.825, z=46.500},
	{name="ATM", id=277, x=-1430.112, y=-211.014, z=46.500},
	{name="ATM", id=277, x=33.232, y=-1347.849, z=29.497},
	{name="ATM", id=277, x=129.216, y=-1292.347, z=29.269},
	{name="ATM", id=277, x=287.645, y=-1282.646, z=29.659},
	{name="ATM", id=277, x=289.012, y=-1256.545, z=29.440},
	{name="ATM", id=277, x=295.839, y=-895.640, z=29.217},
	{name="ATM", id=277, x=1686.753, y=4815.809, z=42.008},
	{name="ATM", id=277, x=-302.408, y=-829.945, z=32.417},
	{name="ATM", id=277, x=5.134, y=-919.949, z=29.557},
	{name="ATM", id=277, x=527.26, y=-160.76, z=57.09},

	{name="ATM", id=277, x=-867.19, y=-186.99, z=37.84},
	{name="ATM", id=277, x=-821.62, y=-1081.88, z=11.13},
	{name="ATM", id=277, x=-1315.32, y=-835.96, z=16.96},
	{name="ATM", id=277, x=-660.71, y=-854.06, z=24.48},
	{name="ATM", id=277, x=-1109.73, y=-1690.81, z=4.37},
	{name="ATM", id=277, x=-1091.5, y=2708.66, z=18.95},
	{name="ATM", id=277, x=1171.98, y=2702.55, z=38.18},
	{name="ATM", id=277, x=2683.09, y=3286.53, z=55.24},
	{name="ATM", id=277, x=89.61, y=2.37, z=68.31},
	{name="ATM", id=277, x=-30.3, y=-723.76, z=44.23},
	{name="ATM", id=277, x=-28.07, y=-724.61, z=44.23},
	{name="ATM", id=277, x=-613.24, y=-704.84, z=31.24},
	{name="ATM", id=277, x=-618.84, y=-707.9, z=30.5},
	{name="ATM", id=277, x=-1289.23, y=-226.77, z=42.45},
	{name="ATM", id=277, x=-1285.6, y=-224.28, z=42.45},
	{name="ATM", id=277, x=-1286.24, y=-213.39, z=42.45},
	{name="ATM", id=277, x=-1282.54, y=-210.45, z=42.45},
}

ATMObjects = {
	-870868698,
	-1126237515,
	-1364697528,
	506770882,
  }
  

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

local nearBank, bankkey, nearATM =  false, 0 , false
local inMenu			= false
local showblips	= true
local canUse = true
local GLOBAL_PED = nil
local GLOBAL_COORDS = vector3(0, 0, 0)
--===============================================
--==             Core Threading                ==
--===============================================
Citizen.CreateThread(function()

	InitBlips()

	while true do
		sleepThread = 1000
		if canUse then
			nearATM =  IsNearATM()
			nearBank, bankkey = IsNearBank()
		end
		canUse = IsAllowedToOperate()
		GLOBAL_PED = GetPlayerPed(-1)
		GLOBAL_COORDS = GetEntityCoords(GLOBAL_PED)
		Citizen.Wait(sleepThread)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleepThread = 1000
		if nearBank and canUse then 
			if not banks[bankkey].closed then
				if not inMenu then
					sleepThread = 5
					DisplayHelpText("Press ~INPUT_PICKUP~ for Banking Services ~b~")			
				end
			else
				if not inMenu then
					sleepThread = 5
					DisplayHelpText("~r~ BANK IS CLOSED ~b~")			
				end
			end
		elseif nearATM and canUse then
			if not inMenu then
				sleepThread = 5
				DisplayHelpText("Press ~INPUT_PICKUP~ for Banking Services ~b~")			
			end
		end
		Citizen.Wait(sleepThread)
	end
end)

local function OpenBanking(type) 
	inMenu = true
	TaskStartScenarioInPlace(GLOBAL_PED, "PROP_HUMAN_ATM", 0, true)
	Citizen.Wait(3000)
	ClearPedTasksImmediately(GLOBAL_PED)
	SetNuiFocus(true, true)
	SendNUIMessage({type = 'openGeneral', data = type})
	TriggerServerEvent('bank:balance')
end

RegisterCommand("banking", function()
	if nearBank and not banks[bankkey].closed and canUse then
		OpenBanking("bank")
	elseif nearATM and canUse then
		OpenBanking("atm")
	end
end)

RegisterKeyMapping("banking", "Interact with Bank/ATM", "keyboard", "e")

RegisterNetEvent('fleeca_banking:client:SetBankState')
AddEventHandler('fleeca_banking:client:SetBankState', function(BankId, bool)
  banks[BankId].closed = bool
end)

--===============================================
--==             Map Blips	                   ==
--===============================================
function InitBlips()
	if showblips then
		for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipScale(blip, 0.7)
		SetBlipAsShortRange(blip, true)
		SetBlipColour(blip, 69)
		if v.principal ~= nil and v.principal then
			SetBlipColour(blip, 77)
		end
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
		end
	end
end



--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = ""
	ESX.TriggerServerCallback('fleeca_banking:fetchData', function(data)
		if data then
			playerName = data.firstname .. " "..data.lastname
			SendNUIMessage({
				type = "balanceHUD",
				balance = balance,
				player = playerName
			})
		end
	end)
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function IsNearBank()
	for key, search in pairs(banks) do
		local distance = #(vector3(search.x, search.y, search.z)- GLOBAL_COORDS)
		
		if distance <= 1.5 then
			return  true , key
		end
	end
end

--Check if player is near an atm
function IsNearATM()
	local hit, coords, entity = RayCastGamePlayCamera(1000.0)
	if hit == 1 and GetEntityType(entity) ~= 0 and IsEntityAnObject(entity) then
	  for k,v in pairs(ATMObjects) do
		if v == GetEntityModel(entity) then
		  local objCoords = GetEntityCoords(entity)
		  
		  if entity ~= 0 then
			local dist = #(GLOBAL_COORDS - objCoords)
			if dist <= 1.5 then
			  return true
			end
		  end
		end
	  end
	end
  
	for _, search in pairs(atms) do
	  	local distance = #(vector3(search.x, search.y, search.z) - GLOBAL_COORDS)
		  
	  	if distance <= 1.5 then
	  		return true
	  	end
	end
	return false
end

function RotationToDirection(rotation)
	local adjustedRotation =
	{
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction =
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination =
	{
		x = cameraCoord.x + direction.x * distance,
		y = cameraCoord.y + direction.y * distance,
		z = cameraCoord.z + direction.z * distance
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

--===============================================
--==            Some useful checks         ==
--===============================================

function IsAllowedToOperate()
	if not IsPedInAnyVehicle(GLOBAL_PED, true) then
		return true
	else
		return false
	end
	
end


--===============================================
--==            Givecash Shit         ==
--===============================================

function IsNearPlayer(player)
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
	local ply2Coords = GetEntityCoords(ply2, 0)
	local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
	if(distance <= 5) then
	  return true
	end
  end
  
  function GetClosestPlayer()
	local closestPlayers = ANRPCore.Functions.GetPlayersFromCoords()
	local closestDistance = -1
	local closestPlayer = -1
	local plyCoords = GetEntityCoords(GetPlayerPed(-1))
  
	for i=1, #closestPlayers, 1 do
		if closestPlayers[i] ~= PlayerId() then
			local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, plyCoords.x, plyCoords.y, plyCoords.z, true)
  
			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = closestPlayers[i]
				closestDistance = distance
			end
		end
  end
  
  return closestPlayer, closestDistance
  end
  
RegisterNetEvent('banking:client:CheckDistance')
AddEventHandler('banking:client:CheckDistance', function(targetId, amount)
	local player, distance = ESX.Game.GetClosestPlayer(GetEntityCoords(GetPlayerPed(-1)))
	if player ~= -1 and distance < 2.5 then
		local playerId = GetPlayerServerId(player)
		if targetId == playerId then
			TriggerServerEvent('banking:server:giveCash', playerId, amount)
		end
	else
		ESX.ShowNotification('No person nearby.')
	end
end)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end
local atmModels = {-870868698, -1126237515, 506770882, -1364697528}
ox_target:addGlobalObject({
	{
		name = "atm",
		event = 'fleec_banking:open_bank',
		icon = 'fa-solid fa-wallet',
		label = "Open ATM",
		distance = 2,
		canInteract = function (entity)
			local entityModel = GetEntityModel(entity)
			return has_value(atmModels, entityModel)
		end,
		onSelect = function(data)
			OpenBanking("atm")
		end
	}
})

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end