-- Allowed to reset during server restart
-- You can use this number to calculate a vehicle spawn location index if you have multiple
-- eg: 3 spawnlocations = index % 3 + 1
local _UnimpoundedVehicleCount = 1;
local impoundWebhook = GetConvar("impound_webhook", nil)

function fetchPlayer(playerIdentifier)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then 
        return player
    end
	local result = MySQL.single.await("SELECT job, firstname, lastname, last_seen FROM users WHERE identifier = @player", {
        ["@player"] = playerIdentifier
	})
	if (not result) then return nil end
	return {
		name = result.firstname .. " " .. result.lastname,
		identifier = playerIdentifier,
		offline = true,
	}
end 

RegisterServerEvent('HRP:Impound:ImpoundVehicle')
RegisterServerEvent('HRP:Impound:GetImpoundedVehicles')
RegisterServerEvent('HRP:Impound:GetVehicles')
RegisterServerEvent('HRP:Impound:UnimpoundVehicle')
RegisterServerEvent('HRP:Impound:UnlockVehicle')

AddEventHandler('HRP:Impound:ImpoundVehicle', function (form, vehicle)
	local player = ESX.GetPlayerFromId(source)
	print("HRP: Impounding vehicle: " .. form.plate);

	local entity = NetworkGetEntityFromNetworkId(vehicle)
	if (DoesEntityExist(entity)) then
		DeleteEntity(entity)
	end

	local rowsChanged = MySQL.insert.await('INSERT INTO `h_impounded_vehicles` VALUES (@plate, @officer, @mechanic, @releasedate, @fee, @reason, @notes, CONCAT(@vehicle), @identifier, @hold_o, @hold_m, @image)', {
		['@plate'] 			= form.plate,
		['@officer']     	= form.officer and player.identifier,
		['@mechanic']       = form.mechanic and player.identifier,
		['@releasedate']	= form.releasedate,
		['@fee']			= form.fee,
		['@reason']			= string.format("%s%s", form.reason, form.notes and string.format("\n\nAdditional Notes: \n%s", form.notes) or ""),
		['@notes']			= form.notes,
		['@vehicle']		= form.vehicle,
		['@identifier']		= form.identifier,
		['@hold_o']			= form.hold_o,
		['@hold_m']			= form.hold_m,
		["@image"]			= form.image
	})
	
	local ownerIdentifier = MySQL.single.await("SELECT * FROM owned_vehicles WHERE plate = @plate", {["@plate"] = form.plate}).owner
	local owner = fetchPlayer(ownerIdentifier)

    exports.stem_discord:sendThroughWebhook({
        webhook = impoundWebhook,
        params = {
            username = "Impound Logs",
            content = ("``%s`` **%s** impounded **%s**'s vehicle with plate ``%s`` until: ``%s`` for **$%s**"):format(player.job.grade_label, player.name, owner.name, form.plate, form.releasedate, ESX.Math.GroupDigits(form.fee)),
        },
        ignoreEnv = true,
    })

	MySQL.query.await("UPDATE owned_vehicles SET pound = @pound WHERE plate = @plate", {
		["@plate"] = form.plate,
		["@pound"] = 1,
	})

	if (rowsChanged) then
		player.showNotification("Vehicle impounded", "success")
	else
		player.showNotification("Could not impound vehicle", "error")
	end
end)

AddEventHandler('HRP:Impound:GetImpoundedVehicles', function (identifier)
	_source = source;
	MySQL.Async.fetchAll('SELECT * FROM `h_impounded_vehicles` WHERE `identifier` = @identifier ORDER BY `releasedate`',
		{
			['@identifier'] = identifier,
		}, function (impoundedVehicles)
			TriggerClientEvent('HRP:Impound:SetImpoundedVehicles', _source, exports.stem_common:tableMap(impoundedVehicles, function (vehicle) 
				if (vehicle.officer ~= "N/A") then
					vehicle.officer = fetchPlayer(vehicle.officer).name
				end
				if (vehicle.mechanic ~= "N/A") then
					vehicle.mechanic = fetchPlayer(vehicle.mechanic).name
				end
				return vehicle
			end))
	end)
end)

AddEventHandler('HRP:Impound:UnimpoundVehicle', function (plate)
	player = ESX.GetPlayerFromId(source)

	_UnimpoundedVehicleCount = _UnimpoundedVehicleCount + 1;

	print('HRP: Unimpounding Vehicle with plate: ' .. plate);

	local veh = MySQL.query.await('SELECT * FROM `h_impounded_vehicles` WHERE `plate` = @plate',
	{
		['@plate'] = plate,
	})

	if(veh == nil) then
		TriggerClientEvent("HRP:Impound:CannotUnimpound", player.source)
		return
	end

	if (player.getAccount("bank").money < veh[1].fee) then
		TriggerClientEvent("HRP:Impound:CannotUnimpound", player.source)
	else
		player.removeAccountMoney("bank", round(veh[1].fee));

		MySQL.query.await('DELETE FROM `h_impounded_vehicles` WHERE `plate` = @plate',
		{
			['@plate'] = plate,
		})

		MySQL.query.await("UPDATE owned_vehicles SET pound = @pound, stored = @stored WHERE plate = @plate", {
			["@plate"] = plate,
			["@pound"] = 0,
			["@stored"] = 1
		})

		TriggerClientEvent('HRP:Impound:VehicleUnimpounded', player.source, veh[1], _UnimpoundedVehicleCount)
	end
end)

AddEventHandler('HRP:Impound:GetVehicles', function ()
	_source = source;

	local vehicles = MySQL.Async.fetchAll('SELECT * FROM `h_impounded_vehicles`', nil, function (vehicles)
		TriggerClientEvent('HRP:Impound:SetImpoundedVehicles', _source, exports.stem_common:tableMap(vehicles, function (vehicle) 
			if (vehicle.officer ~= "N/A") then
				vehicle.officer = fetchPlayer(vehicle.officer).name
			end
			if (vehicle.mechanic ~= "N/A") then
				vehicle.mechanic = fetchPlayer(vehicle.mechanic).name
			end
			return vehicle
		end));
	end);
end)

AddEventHandler('HRP:Impound:UnlockVehicle', function (plate)
	MySQL.Async.execute('UPDATE `h_impounded_vehicles` SET `hold_m` = false, `hold_o` = false WHERE `plate` = @plate', {
		['@plate'] = plate
	}, function (bs)
		-- Something
	end)
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Stupid extra shit because fuck all of this
-------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('HRP:ESX:GetCharacter')
AddEventHandler('HRP:ESX:GetCharacter', function (identifier)
	local _source = source
	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier',
		{
			['@identifier'] 		= identifier,
		}, function(users)
		TriggerClientEvent('HRP:ESX:SetCharacter', _source, users[1]);
	end)
end)

RegisterServerEvent('HRP:ESX:GetVehicleAndOwner')
AddEventHandler('HRP:ESX:GetVehicleAndOwner', function (plate)
	local _source = source
	if (Config.NoPlateColumn == false) then
		MySQL.Async.fetchAll('select * from `owned_vehicles` LEFT JOIN `users` ON users.identifier = owned_vehicles.owner WHERE `plate` = rtrim(@plate)',
			{
				['@plate'] 		= plate,
			}, function(vehicleAndOwner)
			TriggerClientEvent('HRP:ESX:SetVehicleAndOwner', _source, vehicleAndOwner[1]);
		end)
	else
		MySQL.Async.fetchAll('SELECT * FROM `owned_vehicles` LEFT JOIN `users` ON users.identifier = owned_vehicles.owner', {}, function (result)
			for i=1, #result, 1 do
				local vehicleProps = json.decode(result[i].vehicle)

				if vehicleProps.plate:gsub("%s+", "") == plate:gsub("%s+", "") then
					vehicleAndOwner = result[i];
					vehicleAndOwner.plate = vehicleProps.plate;
					TriggerClientEvent('HRP:ESX:SetVehicleAndOwner', _source, vehicleAndOwner);
					break;
				end
			end
		end)
	end
end)


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function round(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end
