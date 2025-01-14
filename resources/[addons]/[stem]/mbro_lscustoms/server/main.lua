RegisterNetEvent("LSC:buttonSelected", function (name, button) 
    local player = ESX.GetPlayerFromId(source)
    if (not button.price) then return end
    print(json.encode(button))
    if (player.getAccount("bank").money < button.price) then
        return TriggerClientEvent("LSC:buttonSelected", player.source, name, button, false)
    end
    player.removeAccountMoney("bank", button.price)
    if (not button.modtype) then
        player.showNotification(("You have paid **$%s** to fix you vehicle"):format(ESX.Math.GroupDigits(button.price)), "success")
    else
        player.showNotification(("You have paid **$%s** for an upgrade"):format(ESX.Math.GroupDigits(button.price)), "success")
    end
    return TriggerClientEvent("LSC:buttonSelected", player.source, name, button, true)
end)

local lockedGarages = {}

RegisterNetEvent("lockGarage", function (state, id) 
    if (state) then
        Player(source).state.lockedGarage = id
    else
        Player(source).state.lockedGarage = nil
    end
    lockedGarages[id] = state
    TriggerClientEvent("lockGarage", -1, lockedGarages)
end)

AddEventHandler("playerDropped", function ( ) 
    if (Player(source).state.lockedGarage) then
        lockedGarages[Player(source).state.lockedGarage] = nil
    end
    TriggerClientEvent("lockGarage", -1, lockedGarages)
end)

RegisterNetEvent('LSC:refreshOwnedVehicle', function(vehicleProps, netId)
	local src = tostring(source)
	local xPlayer = ESX.GetPlayerFromId(source)

  if not vehicleProps then return print('^3[WARNING]^0 The vehicle Props could\'nt be found.') end
  if not vehicleProps.plate then return print('^3[WARNING]^0 The vehicle plate could\'nt be found.') end
  if not vehicleProps.model then return print('^3[WARNING]^0 The vehicle model could\'nt be found.') end

  if not xPlayer then return print('^3[WARNING]^0 The player could\'nt be found.') end

	MySQL.single('SELECT vehicle FROM owned_vehicles WHERE plate = ?', {vehicleProps.plate},
	function(result)
		if result then
			local vehicle = json.decode(result.vehicle)
			if vehicleProps.model == vehicle.model then
				MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})
                local veh = NetworkGetEntityFromNetworkId(netId)
				local Veh_State = Entity(veh).state.VehicleProperties
				if Veh_State then
					Entity(veh).state:set("VehicleProperties", vehicleProps, true)
        end
			else
				print(('[^3WARNING^7] Player ^5%s^7 Attempted To upgrade with mismatching vehicle model'):format(xPlayer.source))
			end
		end
	end)
end)