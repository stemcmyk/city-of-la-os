-- Event: stem_drugs:sell:searchingBuyer
-- Callback: stem_drugs:sell:canSpawnPed
-- Event: stem_drugs:sell:instance
-- Event stem_drugs:sell:pedTaskComplete
-- Event stem_drugs:sell:cleanupPed
-- stem_drugs:sell:soldPed
-- stem_drugs:sell:completeSale

local pedsForArea = {
    CHAMH = {
        "g_m_y_ballasout_01",
        "g_m_y_famdnf_01",
        "g_m_y_famca_01",
        "a_m_y_hippy_01"
    },
    DAVIS = {
        "g_m_y_armgoon_02",
        "g_m_y_ballaorig_01",
        "g_m_y_famfor_01",
        "g_f_y_ballas_01",
        "a_m_m_tramp_01"
    },
    STRAW=  {
        "g_m_y_ballaorig_01",
        "g_m_y_mexgoon_01",
        "g_m_y_mexgoon_02",
        "g_f_y_ballas_01",
        "g_f_y_families_01"
    },
    RANCHO = {
        "g_m_y_lost_01",
        "g_m_y_lost_02",
        "g_f_y_vagos_01"
    },
    GRAPES = {
        "csb_cletus",
        "a_m_y_salton_01",
        "a_m_y_methhead_01",
        "a_m_y_hippy_01",
        "a_m_y_acult_02"
    },
    BEACH = {
        "s_f_y_bartender_01",
        "s_f_y_movprem_01",
        "a_m_m_beach_01",
        "a_m_y_runner_01",
        "ig_tylerdix",
        "u_f_y_lauren"
    },
}

local buyersInArea = {}

ESX.RegisterServerCallback("stem_drugs:sell:canSpawnPed", function (source, cb, currentZone, actualZone)
    local player = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(player.source)) 
    if (checkBuyersInArea(currentZone) >= 5) then
        local dispatchData = {
            message = "Suspicious Activity",
            codeName = 'susactivity',
            code = '10-66',
            icon = 'fas fa-tablets',
            priority = 2,
            coords = coords,
            gender = player.get("sex"),
            street = actualZone,
            alertTime = nil,
            jobs = { 'lspd', 'lscso', 'sahp' },
            borderCheck = {'lspd', 'lscso', 'sahp'}
        }
    
        TriggerEvent('ps-dispatch:server:notify', dispatchData)

        return cb(false, "There are too many ~r~sellers~w~ in the area, ~b~please wait~w~.")
    end

    cb(true, true)
end)

RegisterNetEvent("stem_drugs:sell:searchingBuyer", function (zone, sex, sellingToQuick)
    local player = ESX.GetPlayerFromId(source)
    local coords = GetEntityCoords(GetPlayerPed(player.source)) 
    if (sellingToQuick) then
        local dispatchData = {
            message = "Suspicious Activity",
            codeName = 'susactivity',
            code = '10-66',
            icon = 'fas fa-tablets',
            priority = 2,
            coords = coords,
            gender = player.get("sex"),
            street = zone,
            alertTime = nil,
            jobs = { 'lspd', 'lscso', 'sahp' },
            borderCheck = {'lspd', 'lscso', 'sahp'}
        }
    
        TriggerEvent('ps-dispatch:server:notify', dispatchData)
    end
end)

function checkBuyersInArea(area)
    local total = 0
    for key, value in pairs(buyersInArea) do
        if (value.zone == area) then
            total = total + 1
        end
    end
    return total;
end

function removeFromBuyersInArea(buyer) 
    for key, value in pairs(buyersInArea) do
        if (value.buyer == buyer) then
            buyersInArea[key] = nil
        end
    end
end


RegisterNetEvent("stem_drugs:sell:instance", function (spawnPos, currentZone) 
    local player = ESX.GetPlayerFromId(source)

    local randomPed = pedsForArea[currentZone][math.random(#pedsForArea[currentZone])]

    local ped = CreatePed(5, randomPed, spawnPos, 0, true, false)
    local pedNet = NetworkGetNetworkIdFromEntity(ped)
    
    Entity(ped).state.drugBuyer = {
        taskCoords = GetEntityCoords(GetPlayerPed(player.source)),
        heading = GetEntityHeading(GetPlayerPed(player.source)),
        taskDone = false,
    }
    Player(player.source).state.sellToPed = pedNet

    table.insert(buyersInArea, {
        buyer =  pedNet,
        zone = currentZone
    })

    TriggerClientEvent("stem_drugs:sell:instCreated", player.source, pedNet)
end)

RegisterNetEvent("stem_drugs:sell:pedTaskComplete", function (entityNetId)
    local entityId = NetworkGetEntityFromNetworkId(entityNetId)
    Entity(entityId).state.drugBuyer = {
        taskCoords = GetEntityCoords(GetPlayerPed(source)),
        heading = GetPedDesiredHeading(entityId),
        taskDone = true,
    }
end)

RegisterNetEvent("stem_drugs:sell:cleanupPed", function (entity)
    Player(source).state.sellToPed = nil;
    DeleteEntity(NetworkGetEntityFromNetworkId(entity))

    removeFromBuyersInArea(entity)
end)

RegisterNetEvent("stem_drugs:sell:soldPed", function (entity) 
    local player = ESX.GetPlayerFromId(source)

    local sellToPed = NetworkGetEntityFromNetworkId(Player(player.source).state.sellToPed)
    removeFromBuyersInArea(entity)

    Player(player.source).state.validSale = sellToPed == NetworkGetEntityFromNetworkId(entity)
end)

RegisterNetEvent("stem_drugs:sell:completeSale", function (currentZone, saleItemname, clockHours)
    local player = ESX.GetPlayerFromId(source)

    local sellToPed = NetworkGetEntityFromNetworkId(Player(player.source).state.sellToPed)
    local validSale = Player(player.source).state.validSale

    if not (sellToPed and validSale) then
        player.showNotification("Invalid sale", "error")
        TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:sell:completeSale",
			reason = "Invalid sale conditions",
			metadata = {
                validSale = validSale,
                sellToPed = sellToPed,
			}
		})
        return
    end

    local item = exports.ox_inventory:GetSlotWithItem(player.source, saleItemname)
    local quality = item.metadata?.quality or 75


    local saleBasePrice = tonumber(Config.Sales.Items[saleItemname]) * (quality / 100)
    
    local randomSalePlus = saleBasePrice + math.random(1, math.ceil(saleBasePrice * 0.10)) * (currentZone == "GRAPES" and 2 or 1)
    local canSwap = player.canSwapItem(saleItemname, 1, "black_money", randomSalePlus)

    if (not canSwap) then
       return player.showNotification("You do not have enough space to carry these items.", "error")
    end    

    player.removeInventoryItem(saleItemname, 1)
    player.addAccountMoney("black_money", randomSalePlus)
    
    local shouldGiveSticky = math.random(1, 100) < 5
    if (shouldGiveSticky) then player.addInventoryItem("sticky_note", 1) end

    exports["stem_gangsystem"]:addToPlayerStatistics(player.identifier, {
        dirty_earned = randomSalePlus,
        drugs_sold = 1
    })
end)