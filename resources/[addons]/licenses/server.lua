RegisterNetEvent("licenses:showDriversLicense", function (playerId)
    local player = ESX.GetPlayerFromId(source)
    
    TriggerClientEvent("licenses:showPlayer", playerId, {
        CitizenId = playerId,
        Sex = player.get("sex"),
        Format = "driver_license",
        DOB = player.get("dateofbirth"),
        FirstName = player.get("firstName"),
        LastName = player.get("lastName"),
        Height = player.get("height"),
    })
end)

RegisterNetEvent("licenses:grabLicenseFromBody", function (playerId)
    
    local player = ESX.GetPlayerFromId(playerId)
    
    TriggerClientEvent("licenses:showPlayer", source, {
        CitizenId = playerId,
        Sex = player.get("sex"),
        Format = "driver_license",
        DOB = player.get("dateofbirth"),
        FirstName = player.get("firstName"),
        LastName = player.get("lastName"),
        Height = player.get("height"),
    })
end)