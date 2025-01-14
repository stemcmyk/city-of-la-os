function sendDiscordEmbed(channel, embeds) 
	exports.stem_discord:sendMessage({
		channelId = channel, 
		embeds = embeds,
		addTimestamp = true,
	})
end

ESX.RegisterServerCallback('stem-dmv:canPay', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getAccount("bank").money >= Config.Prices[type] then
		xPlayer.removeAccountMoney("bank", Config.Prices[type], "DMV Purchase")
		xPlayer.showNotification( TranslateCap('you_paid')..ESX.Math.GroupDigits(Config.Prices[type]), "success")
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback("stem-dmv:fetchAllOwnedVehicles", function (source, cb, l)
	local src = source
	local identifier = ESX.GetPlayerFromId(src).identifier

	MySQL.Async.fetchAll("SELECT vehicle, vehiclename, pound, `stored`, plate, garage_name, vehiclename FROM owned_vehicles WHERE owner = @identifier", {
		['@identifier'] = identifier,
	}, function(result)
		cb(exports.stem_common:tableMap(result, function (vehicle) 
			return {
				state = not (vehicle.stored and not vehicle.pound), -- reverse boolean because monkey script
				plate = vehicle.plate,
				vehicle = vehicle.vehicle,
				vehiclename = vehicle.vehiclename
			}
		end))
	end)
end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('stem_dmv:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('stem_dmv:addLicense')
AddEventHandler('stem_dmv:addLicense', function(type)
	local source = source
	local player = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_license:addLicense', source, type, function()
		
		if (player.getInventoryItem("driverlicense").count < 1 and type ~= "dmv") then
			player.addInventoryItem("driverlicense", 1)
		end
		
		TriggerEvent('esx_license:getLicenses', source, function(licenses)
			TriggerClientEvent('stem_dmv:loadLicenses', source, licenses)
		end)
	end)
end)

RegisterNetEvent("stem_dmv:vanityPlate")
AddEventHandler("stem_dmv:vanityPlate", function (old, new, vehicleName, vehicleModel)
	local src = source
	local player = ESX.GetPlayerFromId(src)
    local supporterAccess = Player(player.source).state.supporterAccess
	if (not supporterAccess or not exports.stem_common:tableContains(supporterAccess, "gold")) then
		TriggerClientEvent("esx:showHelpNotification", player.source, "You do not have ~b~Gold Supporter~w~", false, true)
		return
	end

	
	if (player.getAccount("bank").money < Config.VanityPlateFee) then
		player.showNotification("You do not have enough money for this.", "error")
		return 
	end
	MySQL.Async.fetchAll('SELECT vehicle, vehiclename FROM owned_vehicles WHERE plate = @old AND owner = @identifier', {
		["@old"] = old,
		["@identifier"] = player.identifier
	}, function (result) 
		if (result[1]) then
			local newVehicle = json.decode(result[1].vehicle)
			newVehicle.plate = new
			MySQL.Async.execute("UPDATE owned_vehicles SET plate = @new, vehicle = @vehicle WHERE plate = @old AND owner = @identifier", {
				["@old"] = old,
				["@new"] = new,
				["@vehicle"] = json.encode(newVehicle),
				["@identifier"] = player.identifier
			}, function (updateResult)
				if (updateResult) then
					player.removeAccountMoney("bank", Config.VanityPlateFee)
					player.showNotification(TranslateCap('you_paid')..ESX.Math.GroupDigits(Config.VanityPlateFee), "success")

					exports.stem_discord:getUserDiscord(src, function (discordId)
						sendDiscordEmbed("1229804464781656165", {
							{
								author = {
									name = "Vanity Plate Change"
								},
								title = "A player has changed their plate at the dmv.",
								description = string.format("**Player:** %s, <@!%s>", player.getName(), discordId),
								fields = {
									{
										name = "Vehicle",
										value = string.format("**%s** %s", vehicleName or result[1].vehiclename, vehicleModel)
									},
									{
										name = "From",
										value = string.format("```%s```", old),
										inline = true,
									},
									{
										name = "To",
										value = string.format("```%s```", new),
										inline = true,
									},
								},
								color = 37,
								footer = {
									text = player.identifier,
								},
							}
						})
					end)

					player.showNotification(string.format("You have changed the plate from %s to %s", old, new), "success")
				end
			end)
		end

	end)
end)

local licenseTypes = {
	boat = "boatinglicense",
	drive = "driverlicense"
}

RegisterNetEvent("stem_dmv:requestLicenseItem")
AddEventHandler("stem_dmv:requestLicenseItem", function (type)
	local player = ESX.GetPlayerFromId(source) 
	if (player.getAccount("bank").money < Config.LicenseReplacementFee) then
		player.showNotification("You do not have enough money for this.", "error")
		return 
	end
	if (player.getInventoryItem(licenseTypes[type]).count >= 1) then
		player.showNotification("You already have a license on you.", "error")
		return 
	end
	TriggerEvent("esx_license:getLicense", "drive", function (license) 
		if (not license) then
			player.showNotification("You do not have a valid driver's license", "error")
			return
		end
		player.removeAccountMoney("bank", Config.LicenseReplacementFee)
		player.addInventoryItem(licenseTypes[type], 1)
		player.showNotification(TranslateCap('you_paid')..ESX.Math.GroupDigits(Config.LicenseReplacementFee), "success")
	end)
end)

RegisterNetEvent("stem_dmv:purchaseBoatLicense", function () 
	local player = ESX.GetPlayerFromId(source) 
	if (player.getAccount("bank").money < Config.BoatPurchaseLicenseFee) then
		player.showNotification("You do not have enough money for this.", "error")
		return 
	end
	if (player.getInventoryItem("boatinglicense").count >= 1) then
		player.showNotification("You already have a license on you.", "error")
		return 
	end
	TriggerEvent('esx_license:addLicense', source, "boat", function()
		player.removeAccountMoney("bank", Config.BoatPurchaseLicenseFee)
		player.addInventoryItem("boatinglicense", 1)
		player.showNotification(TranslateCap('you_paid')..ESX.Math.GroupDigits(Config.BoatPurchaseLicenseFee), "success")
	end)
end)

exports.ox_inventory:registerHook("createItem", function (payload, source)
	local player = ESX.GetPlayerFromId(payload.inventoryId)

	return {
		firstname = player.get("firstName"),
		lastname = player.get("lastName"),
		dateofbirth = player.get("dateofbirth"),
		sex = player.get("sex"),
		height = player.get("height")
	}
end, {
	itemFilter = {
		driverlicense = true,
		boatinglicense = true
	}
})

-- Gang gang no givvy givvy to players
exports.ox_inventory:registerHook('swapItems', function(payload)
	if (payload.toType == "player" and payload.fromInventory == payload.toInventory) then return true  end
    return false
end, {
    itemFilter = {
        driverlicense = true,
		boatinglicense = true
    },
})

RegisterNetEvent("stem_dmv:requestIdentityChange")
AddEventHandler("stem_dmv:requestIdentityChange", function (input) 
	local player = ESX.GetPlayerFromId(source) 
    local supporterAccess = Player(player.source).state.supporterAccess
	if (not supporterAccess or not exports.stem_common:tableContains(supporterAccess, "gold")) then
		TriggerClientEvent("esx:showHelpNotification", player.source, "You do not have ~b~Gold Supporter~w~", false, true)
		return
	end

	local data = {
		firstname = input[1],
		lastname = input[2],
		dateofbirth = input[3],
		height = input[4],
		sex = input[5]
	}

	if (player.getAccount("bank").money < Config.LicenseChangeFee) then
		player.showNotification("You do not have enough money for this.", "error")
	end
		
	data.dateofbirth = exports.esx_identity:convertTimestampToDate(data.dateofbirth)

	if not exports.esx_identity:checkNameFormat(data.firstname, Config.MinFirstNameLength, Config.MaxFirstNameLength) then
		TriggerClientEvent('esx:showNotification', player.source, TranslateCap('invalid_firstname_format'), "error")
		return cb(false)
	end
	if not exports.esx_identity:checkNameFormat(data.lastname, Config.MinLastNameLength, Config.MaxLastNameLength) then
		TriggerClientEvent('esx:showNotification', player.source, TranslateCap('invalid_lastname_format'), "error")
		return cb(false)
	end
	if not exports.esx_identity:checkSexFormat(data.sex) then
		TriggerClientEvent('esx:showNotification', player.source, TranslateCap('invalid_sex_format'), "error")
		return cb(false)
	end
	if not exports.esx_identity:checkDOBFormat(data.dateofbirth) then
		TriggerClientEvent('esx:showNotification', player.source, TranslateCap('invalid_dob_format'), "error")
		return cb(false)
	end
	if not exports.esx_identity:checkHeightFormat(data.height) then
		TriggerClientEvent('esx:showNotification', player.source, TranslateCap('invalid_height_format'), "error")
		return cb(false)
	end
	local currentIdentity = {
		firstName = player.get("firstName"),
		lastName = player.get("lastName"),
		dateofbirth = player.get("dateofbirth"),
		sex = player.get("sex"),
		height = player.get("height")
	}
	local newIdentity = {
		firstName = exports.esx_identity:formatName(data.firstname),
		lastName = exports.esx_identity:formatName(data.lastname),
		dateOfBirth = exports.esx_identity:formatDate(data.dateofbirth),
		sex = data.sex,
		height = data.height
	}


	player.setName(('%s %s'):format(newIdentity.firstName, newIdentity.lastName))
	player.set('firstName', newIdentity.firstName)
	player.set('lastName', newIdentity.lastName)
	player.set('dateofbirth', newIdentity.dateOfBirth)
	player.set('sex', newIdentity.sex)
	player.set('height', newIdentity.height)
	TriggerClientEvent('esx_identity:setPlayerData', player.source, newIdentity)

	exports.esx_identity:saveIdentityToDatabase(player.identifier, newIdentity)

	player.removeAccountMoney("bank", Config.LicenseChangeFee)
	player.showNotification(TranslateCap('you_paid')..ESX.Math.GroupDigits(Config.LicenseChangeFee), "success")
	player.showNotification("You have changed your identity", "success")
	
	exports.stem_discord:getUserDiscord(player.source, function (discordId)
		sendDiscordEmbed("1230301861043638292", {
			{
				author = {
					name = "Identity Change"
				},
				title = "A player has changed their identity at the dmv.",
				description = string.format("**Player:** %s, <@!%s>", player.getName(), discordId),
				fields = {
					{
						name = "Name From",
						value = string.format("```%s```", ('%s %s'):format(currentIdentity.firstName, currentIdentity.lastName)),
						inline = true,
					},
					{
						name = "To",
						value = string.format("```%s```", ('%s %s'):format(newIdentity.firstName, newIdentity.lastName)),
						inline = true,
					},
					{
						name = "",
						value = ""
					},
					{
						name = "DOB From",
						value = string.format("```%s```", currentIdentity.dateofbirth),
						inline = true,
					},
					{
						name = "To",
						value = string.format("```%s```", newIdentity.dateOfBirth),
						inline = true,
					},
					{
						name = "",
						value = ""
					},
					{
						name = "Height From",
						value = string.format("```%s```", currentIdentity.height),
						inline = true,
					},
					{
						name = "To",
						value = string.format("```%s```", newIdentity.height),
						inline = true,
					},
					{
						name = "",
						value = ""
					},
					{
						name = "Sex From",
						value = string.format("```%s```", currentIdentity.sex),
						inline = true,
					},
					{
						name = "To",
						value = string.format("```%s```", newIdentity.sex),
						inline = true,
					},
				},
				color = 37,
				footer = {
					text = player.identifier,
				},
			}
		})
	end)
end)