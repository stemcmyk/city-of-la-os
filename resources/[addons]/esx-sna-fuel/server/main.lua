local ESX = nil

ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('esx-fuel:server:Pay', function(amount)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    
    Player.removeAccountMoney("bank", amount, "Fuel")
end)

RegisterServerEvent('esx-fuel:server:GiveJerrican', function()
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Config.JerryCanWeaponAsItem then
        Player.addInventoryItem('weapon_petrolcan', 1)
    else
        Player.addWeapon('weapon_petrolcan', 4500)
    end
end)

RegisterServerEvent("esx-fuel:server:RefilJerrican", function ()
    local weapon = exports.ox_inventory:GetCurrentWeapon(source)
    exports.ox_inventory:SetMetadata(source, weapon.slot, {
        ammo = 100,
        durability = 100
    })
end)



RegisterServerEvent('esx-fuel:server:AttachRope', function(netIdProp, coordPumps, model)
	local src = source
    local Player = ESX.GetPlayerFromId(src)
    local citizenid = Player.identifier
    TriggerClientEvent('esx-fuel:client:AttachRope', -1, netIdProp, coordPumps, model, citizenid)
end)


RegisterServerEvent('esx-fuel:server:FineForSnap', function(netIdProp, coordPumps, model)
	local src = source
    local Player = ESX.GetPlayerFromId(src)

    Player.removeAccountMoney("bank", Config.SnapFine, "Pump Snap Fine")
    Player.showNotification(_U("message.fine_for_snap", "$"..exports.stem_common:formatPrice(Config.SnapFine)), "error")
end)


RegisterServerEvent('esx-fuel:server:DetachRope', function(src)
	local srctemp = source
    local Player = ESX.GetPlayerFromId(srctemp)
    local citizenid = Player.identifier
    TriggerClientEvent('esx-fuel:client:DetachRope', -1, citizenid, src)
end)

RegisterNetEvent('esx-fuel:server:UpdateVehicleDateTimeIn', function(plate)
    MySQL.update('UPDATE owned_vehicles SET datetimein = ? WHERE plate = ?', {os.time(), plate})
end)

RegisterNetEvent("esx-fuel:server:UpdateWeaponAmmo", function (weapon, ammo) 
    local player = ESX.GetPlayerFromId(source)
    print("ass")
    if (weapon ~= 883325847) then
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "esx-fuel:server:UpdateWeaponAmmo",
			reason = "Player attemted to update a weapon other than the jerry can.",
			metadata = {
				weapon = weapon,
                ammo = ammo,
			}
		})
    end
    local weapon = exports.ox_inventory:GetCurrentWeapon(player.source)
    exports.ox_inventory:SetMetadata(player.source, weapon.slot, {
        ammo = ammo,
        durability = ammo
    })
end)

ESX.RegisterServerCallback('esx-fuel:server:GetTimeInGarage', function(source, cb, plate)
    local result = MySQL.single.await('SELECT * FROM owned_vehicles WHERE plate = ?', { plate })
    if result then
        if result.datetimein and result.datetimein ~= 0 then
            cb(os.time() - result.datetimein)
        else
            cb(false)            
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("esx-fuel:hasEnough", function (source, cb, amount) 
    return cb(ESX.GetPlayerFromId(source).getAccount("bank").money >= amount)
end)


ESX.RegisterCommand("fuel", 'admin', function(xPlayer, args, showError)
    local amount = tonumber(args.amount)
    if not amount then
        amount = 100
    end
    xPlayer.triggerEvent('esx-fuel:SetFuel', amount)
end, false, {help = "Set fuel/charge for vehicle", validate = false, arguments = {
	{name = 'amount',validate = false, help = "Amount", type = 'string'}
}}) 