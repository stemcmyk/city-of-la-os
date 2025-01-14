if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'sadot', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'sadot', TranslateCap('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'sadot', 'sadot', 'society_sadot', 'society_sadot', 'society_sadot', {type = 'private'})
exports.esx_society:setBossGradeName("director")


ESX.RegisterUsableItem('carokit', function(source)
	local source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_mechanicjob:onCarokit', source)
	TriggerClientEvent('esx:showNotification', source, TranslateCap('you_used_body_kit'))
end)

ESX.RegisterServerCallback("stem_dot:createVeh", function (source, cb, model, location, modelType)
	local vehicle = CreateVehicle(model, location, location.w, true, false)

	while not DoesEntityExist(vehicle) do
		Wait(10)
	end
	cb(NetworkGetNetworkIdFromEntity(vehicle))
end)


ESX.RegisterServerCallback('esx_mechanicjob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)


local callMaxTime = 5 * 60
local calls = {

};

ESX.RegisterCommand("calldot", nil, function (player) 
	local playerCoords = player.coords
	
	if (calls[player.source]) then
		return player.showNotification("You already have a pending call, please try again later.", "error")
	end
	
	local calldata = {
		timestamp = os.time();
		location = GetEntityCoords(GetPlayerPed(player.source)),
		accepted = {},
	}

	calls[player.source] = calldata
	
	for key, value in pairs(GetActivePlayers()) do
		local player = ESX.GetPlayerFromId(value)
		if (player.job.name == "sadot") then
			TriggerClientEvent("stem_dot:notifyNewCall", -1, calldata)
		end
	end
end)

ESX.RegisterServerCallback(
	"stem_dot:fetchCalls",
	function (source, cb)
		local newCalls = {}
		for playerSource, call in pairs(calls) do
			local dateTable = os.date("*t", call.timestamp)
			call.displayTime = string.format("%02d:%02d", dateTable.hour, dateTable.min)
			call.player = playerSource
			table.insert(newCalls, call)
		end
		cb(newCalls)
	end
)

SetInterval(function ()
	for key, value in ipairs(calls) do
		if (#value.accepted > 0) then
			local timeSinceCall = os.time() - value.acceptedTime 
			if (timeSinceCall > callMaxTime) then
				calls[key] = nil;
			end
		end
	end
end, 10000)

RegisterNetEvent("stem_dot:acceptCall", function (playerSource) 
	local caller = ESX.GetPlayerFromId(playerSource)
	local player = ESX.GetPlayerFromId(source)
	if (not calls[caller.source]) then
		return player.sendNotification("This call has expired.")
	end
	if (not calls[caller.source].acceptedTime) then calls[caller.source].acceptedTime = os.time() end
	
	if (not calls[caller.source].accepted) then calls[caller.source].accepted = {} end

	

	if (not exports.stem_common:tableContains(calls[caller.source].accepted, player.source)) then 
		table.insert(calls[caller.source].accepted, player.source)
	else
		return player.showNotification("You are already connected to this call")
	 end
	
	if (#calls[caller.source].accepted < 2) then
		caller.showNotification("A S.A DOT Employee is on the way to your location.")
	end

	player.showNotification("Call Accepted.", "success")
end)

RegisterNetEvent("playerDropped", function () 
	if (calls[source]) then
		for key, value in pairs(calls[source].accepted) do
			TriggerClientEvent("stem_dot:notifyCancelled", value, calls[source])
		end
		calls[source] = nil
	end
end)

RegisterNetEvent("stem_dot:getRadio", function ( )
	local player = ESX.GetPlayerFromId(source)
	
	if (player.job.name ~= "sadot") then
		return
	end
	
	if (player.hasItem("radio").count > 0) then
		return player.showNotification("You already have a radio")
	end

	if not player.canCarryItem("radio", 1) then
		return player.showNotification("You cannot carry this item")
	end

	player.addInventoryItem("radio", 1)
	player.showNotification("You have been given a radio")
end)