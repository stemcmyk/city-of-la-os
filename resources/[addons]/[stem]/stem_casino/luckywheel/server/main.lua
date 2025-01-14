math.randomseed(os.time())
GlobalState.LuckyWheel = nil
isRoll = false
-- local car = Config_LuckyWheel.Cars[math.random(#Config_LuckyWheel.Cars)] 

if Config_LuckyWheel.LimitedSpins then
	Citizen.CreateThread(function()
		while true do
			Wait(1000*60)
			if os.date('%H:%M') == Config_LuckyWheel.LimitedSpins then
				exports.oxmysql:execute('UPDATE players SET luckywheel_spins = 0')
			end
		end
	end)
end

function getRandomWin(car) 
	local number = car and math.random(1000) or math.random(995)
	for key, value in pairs(Config_LuckyWheel.Prices) do
		if (number > value.probability.a and number <= value.probability.b) then
			return key, value
		end
	end
end

ESX.RegisterServerCallback("stem_casino:getPodiumVehicle", function (source, cb)
	local luckywheelVehicle = MySQL.single.await("SELECT * FROM luckywheel_vehicle ORDER BY date ASC")
	if (not luckywheelVehicle) then return cb(nil) end
	local vehicle = MySQL.single.await("SELECT * FROM owned_vehicles WHERE plate = @plate", {
		["@plate"] = luckywheelVehicle.vehicle_plate
	})
	if (not vehicle) then return cb(nil) end
	return cb(vehicle)
end)

ESX.RegisterServerCallback("stem_casino:canSpinWheel", function (source, cb)
	local player = ESX.GetPlayerFromId(source)
	local lastSpun = player.getMeta("lastLuckyWheel")
	if (player.getAccount("bank").money < Config_LuckyWheel.SpinMoney) then
		player.showHelpNotification(("You do not have enough to spin the wheel, cost: ~g~$%s"):format(ESX.Math.GroupDigits(Config_LuckyWheel.SpinMoney)))
		return cb(false)
	end
	return cb(true)
end)

function giveWinnings(player, data) 
	if (data.type == "weapon" or data.type == "chips" or data.type == "money") then
		local item = player.hasItem(data.name)
		if (data.count > 1) then
			player.showHelpNotification(("You've won ~b~x%s~w~ ~w~%s~w~"):format(data.count, item.label))
		else
			player.showHelpNotification(("You've won a ~b~%s"):format(item.label))
		end
		player.addInventoryItem(data.name, data.count)
    	return exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
			exports.stem_discord:sendThroughWebhook({
				webhook = WEBHOOK,
				params = {
					username = "Luckywheel win",
					content = ("<@%s> ``%s (%s)`` has won **x%s %s** at the lucky wheel"):format(playerDiscord, player.name, GetPlayerName(player.source), data.count, item.label)
				}
			})
    	end)
	end
	if (data.type == "car") then
		local luckywheelVehicle = MySQL.single.await("SELECT * FROM luckywheel_vehicle ORDER BY date ASC")
		if (not luckywheelVehicle) then return giveWinnings(player, Config_LuckyWheel.Prices[3]) end

		local car = MySQL.single.await("SELECT * FROM owned_vehicles WHERE plate = @plate", {
			["@plate"] = luckywheelVehicle.vehicle_plate
		})

		if (not car) then return end;

		MySQL.query.await("UPDATE owned_vehicles SET owner = @identifier, status = 0, stored = 0 WHERE plate = @plate", {
			["@identifier"] = player.identifier,
		})

		MySQL.query.await("DELETE FROM luckywheel_vehicle WHERE vehicle_plate = @plate", {
			["@plate"] = luckywheelVehicle.vehicle_plate
		})

		local vehData = json.decode(car.vehicle)
		local vehicleName = exports.stem_dealership:getVehicleByHash(vehData.model).label

		local vehicle = CreateVehicleServerSetter(vehData.model, "automobile", Config_LuckyWheel.VehicleWinPos.x, Config_LuckyWheel.VehicleWinPos.y, Config_LuckyWheel.VehicleWinPos.z, Config_LuckyWheel.VehicleWinPos.h)
		TriggerClientEvent("stem_casino:carWon", -1, car, player.source, NetworkGetNetworkIdFromEntity(vehicle))
		player.showHelpNotification(("You have the casino car! A ~b~%s~w~"):format(vehicleName))

    	exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
			exports.stem_discord:sendThroughWebhook({
				webhook = WEBHOOK,
				params = {
					username = "Luckywheel win",
					content = ("<@%s> **%s**  ``%s (%s)`` has won the **%s** at the lucky wheel"):format(playerDiscord, player.name, GetPlayerName(player.source), vehicleName)
				}
			})
    	end)
	end
	if (data.type == "mystery") then
		local key, win = getRandomWin() 
		giveWinnings(player, win)
	end
	if (data.type == "souvenir") then
		local key, win = getRandomWin() 
		giveWinnings(player, win)
	end

end

ESX.RegisterServerCallback("stem_casino:spinWheel", function (source, cb) 
	local player = ESX.GetPlayerFromId(source)
	local lastSpun = player.getMeta("lastLuckyWheel")

	if (lastSpun and type(lastSpun) == "number") then
		local lastSpunDate = os.date("*t", lastSpun)
		local todayDate = os.date("*t", os.time())
		if (todayDate.year == lastSpunDate.year and todayDate.month == lastSpunDate.month and todayDate.day == lastSpunDate.day) then
			player.showHelpNotification("You've already spun the wheel today")
			Player(player.source).state.luckywheel = "spun"
			return cb(false)
		end
	end
	local luckywheelVehicle = MySQL.single.await("SELECT * FROM luckywheel_vehicle ORDER BY date ASC")

	player.removeAccountMoney("bank", Config_LuckyWheel.SpinMoney)

	local society = exports.esx_society:GetSociety("casino")
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        if not account then return end
		account.addMoney(Config_LuckyWheel.SpinMoney)
	end)

	local key, win = getRandomWin(not not luckywheelVehicle)

	TriggerClientEvent("stem_casino:startWheelRoll", -1, player.source, key, win)
	TriggerClientEvent("stem_casino:syncWheelAnim", player.source)

	Citizen.CreateThread(function () 
		while not Player(player.source).state.luckywheel do
			Wait(50)
		end
		while Player(player.source).state.luckywheel ~= "done" do
			Wait(50)
		end
		giveWinnings(player, win)
		Player(player.source).state.luckywheel = nil
		player.setMeta("lastLuckyWheel", os.time())
		cb(true)
	end)
end)

RegisterNetEvent("stem_casino:wheelUsing", function () 
	GlobalState.LuckyWheel = {
		player = source
	}
end)

RegisterNetEvent("stem_casino:wheelExit", function () 
	GlobalState.LuckyWheel = nil
end)

RegisterNetEvent("stem_casino:wheelStopRoll", function () 
	GlobalState.LuckyWheel = nil
	Player(source).state.luckywheel = nil
end)

function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = exports.oxmysql:scalarSync('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end