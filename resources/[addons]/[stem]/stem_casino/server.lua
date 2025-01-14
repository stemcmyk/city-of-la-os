

function getTotalCasinoChips (source) 
    local player = ESX.GetPlayerFromId(source)
	local casinoChips = player.getInventoryItem("casino_chips").count
    local casinoCompChips = player.getInventoryItem("casino_comp_chips").count
    return casinoChips + casinoCompChips
end 

SetGetChipsCallback = function(source)
    return getTotalCasinoChips(source)
end

SetTakeChipsCallback = function(source, amount)
    local player = ESX.GetPlayerFromId(source)
    local totalChips = getTotalCasinoChips(source)
    if (totalChips < amount) then
        return player.showNotification("You do not have enough chips")
    end
    local totalCompChips = player.getInventoryItem("casino_comp_chips").count

    if (totalCompChips < amount) then
        local remaining = amount - totalCompChips
        player.removeInventoryItem("casino_comp_chips", totalCompChips)
        player.removeInventoryItem("casino_chips", remaining)
        return
    else
        return player.removeInventoryItem("casino_comp_chips", amount)
    end
end

SetGiveChipsCallback = function(source, amount)
    local player = ESX.GetPlayerFromId(source)
    player.addInventoryItem("casino_chips", amount)
end