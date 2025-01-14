local streetDealerPedEntities = {}

local streetDealerLocations = {
    vector4(-830.71, -566.58, 30.28, 58.44),
    vector4(-1317.03, -798.98, 17.57, 36.25),
    vector4(-969.44, -266.48, 38.55, 119.57),
    vector4(-505.14, -442.67, 34.48, 165.99),
    vector4(263.6, -309.69, 49.65, 344.08),
    vector4(819.75, -815.2, 26.38, 272.09),
    vector4(729.41, -1974.12, 29.29, 269.79),
    vector4(-326.39, -1300.5, 31.35, 90.38),
    vector4(-174.82, 218.86, 89.9, 173.74),
    vector4(-598.85, 170.45, 66.06, 4.02),
    vector4(-761.72, 352.17, 88.0, 8.72),
    vector4(-1171.12, -1381.05, 4.97, 34.0),
    vector4(-1471.74, -920.29, 10.03, 224.1)
}

local streetDealerPeds = {
    "g_m_y_ballasout_01",
    "g_m_y_famfor_01",
    "g_m_y_mexgoon_03",
    "g_m_y_korean_02"
}

CreateThread(function ()
    GlobalState.GunVanIntelPrice = exports.stem_common:fluctuatePrice(Config.GunVanIntelPrice, Config.PriceFluctuate)
end)

RegisterNetEvent("stem_payphones:syncState", function (closestPhone, boolean) 
    TriggerClientEvent("stem_payphones:syncState", -1, closestPhone, boolean)
end)

RegisterNetEvent("stem_payphones:syncScene", function (closestPhone, anim) 
    TriggerClientEvent("stem_payphones:syncState", -1, closestPhone, anim)
end)

RegisterNetEvent("stem_payphones:contactDealer", function () 
    local player = ESX.GetPlayerFromId(source)
    local hasItem = player.getInventoryItem("sticky_note").count
    if (hasItem < 1) then
        return player.showNotification("You do not have a sticky note.")
    end
    player.removeInventoryItem("sticky_note", 1)

    local location = streetDealerLocations[math.random(#streetDealerLocations)]
    local dealerPedModel = streetDealerPeds[math.random(#streetDealerPeds)]
    
    local dealerPed = CreatePed(5, dealerPedModel, location, location.w, true, false)
    table.insert(streetDealerPedEntities, dealerPed)
    Entity(dealerPed).state.streetDealer = {
        source = player.source,
        scenario = "WORLD_HUMAN_AA_SMOKE"
    }

    TriggerClientEvent("stem_payphones:streetDealerBlip", player.source, location)
end)

ESX.RegisterServerCallback("stem_payphones:purchaseGunVanIntel", function (source, cb, pedNet)
    local player = ESX.GetPlayerFromId(source)
    local ped = NetworkGetEntityFromNetworkId(pedNet)
    
    if (Entity(ped).state.streetDealer.source ~= player.source) then
        player.showNotification("You are a retard?", "error")
        TriggerEvent("stem_ac:player:sus", {
			source, 
			event = "stem_payphones:purchaseGunVanIntel",
			reason = "Invalid intel ownership",
			metadata = {
                streetDealerPed = ped,
                streetDealerOwner = Entity(ped).state.streetDealer,
                player = player.source,
			}
		})
        return
    end
    
    if (player.getAccount("black_money").money < GlobalState.GunVanIntelPrice) then
        return cb("no_funds", player.getAccount("black_money").money, GlobalState.GunVanIntelPrice)
    end

    player.removeAccountMoney("black_money", GlobalState.GunVanIntelPrice)
    Entity(ped).state.streetDealer = nil    

    local gunVanLocation = exports.stem_gunvan:getGunVanLocation()
    local targetNumber = exports.npwd:getPlayerData({ identifier = player.identifier }).phoneNumber
    
    exports.npwd:emitMessage({
        senderNumber = "Dealer",
        targetNumber = targetNumber,
        message = 'Here are the coords for the gun van.',
        embed = {
            type = "location",
            coords = {gunVanLocation.x, gunVanLocation.y, gunVanLocation.Z},
            phoneNumber = "Dealer"
        }
    })

    exports["stem_gangsystem"]:addToPlayerStatistics(player.identifier, {
        dirty_spent = GlobalState.GunVanIntelPrice,
    })
end)


AddEventHandler("onResourceStop", function (resourceName) 
    if (resourceName == GetCurrentResourceName()) then
        for key, value in pairs(streetDealerPedEntities) do
            DeleteEntity(value)
        end
    end
end)