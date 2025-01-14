local invoices = {}

RegisterNetEvent("stem_common:payment_terminal:invoiceCreated", function (toPlayer, price, meta, pos)
    local player = ESX.GetPlayerFromId(source)

    local distanceToPlayer = exports.stem_common:getDistanceToCoord(player.source, GetEntityCoords(GetPlayerPed(toPlayer)))

    if (distanceToPlayer > 10) then
        return player.showNotification("You are too far away fom this player", "error")
    end
    if (price > 5000) then
        return player.showNotification("You charged the person too much", "error")
    end

    Player(toPlayer).state.invoice = {from = player.source, amount = price, meta = meta, pos = pos }

    TriggerClientEvent("stem_common:payment_terminal:floatingNotify", toPlayer, player.source, price, pos)
end)

RegisterNetEvent("stem_common:payment_terminal:acceptInvoice", function (initPlayerSrc, pos) 
    local initPlayer = ESX.GetPlayerFromId(initPlayerSrc)
    local player = ESX.GetPlayerFromId(source)

    local invoice = Player(player.source).state.invoice;

    if not invoice then return player.showNotification("Invalid Invoice") end

    if (player.getAccount("bank").money < invoice.amount) then
        initPlayer.showNotification("You do not have enough money to pay for this invoice", "error")
        player.showNotification("This person does not have enough to pay this invoice", "error")
        return;
    end

    if (initPlayer.source ~= invoice.from) then
        initPlayer.showNotification("Invalid Transaction", "error")
        player.showNotification("Invalid Transaction", "error")
        return;
    end

    player.removeAccountMoney("bank", invoice.amount)   
    
    if (invoice.meta.society) then
        local society = exports.esx_society:GetSociety(invoice.meta.society)

        local societyMoney, playerMoney = invoice.amount,0

        if invoice.meta.ppratio then
            playerMoney =  societyMoney * (invoice.meta.ppratio / 100   )
            societyMoney = societyMoney - playerMoney
        end

        if (societyMoney > 0) then
            TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
                if not account then return initPlayer.showNotification("Invalid society") end
                account.addMoney(societyMoney)
        
                initPlayer.showNotification(string.format("Successful payment of **$%s** from %s (%s)",  ESX.Math.GroupDigits(societyMoney), player.name, player.source), "success")
                player.showNotification(string.format("Successful payment of **$%s** to **%s**",  ESX.Math.GroupDigits(societyMoney), society.label), "success")
            end)
        end
        if (playerMoney > 0) then
            initPlayer.addAccountMoney("bank", playerMoney)
            initPlayer.showNotification(string.format("Successful payment of **$%s** from %s (%s) to your bank",  ESX.Math.GroupDigits(playerMoney), player.name, player.source), "success")
        end

    else
        initPlayer.addAccountMoney("bank", invoice.amount)

        initPlayer.showNotification(string.format("You have been paid $ %s", ESX.Math.GroupDigits(invoice.amount)), "success")
        player.showNotification(string.format("You have paid $ %s", ESX.Math.GroupDigits(invoice.amount)), "success")
    end

    TriggerEvent("stem_common:payment_terminal:invoiceComplete", initPlayer.source, player.source, invoice)
    TriggerClientEvent("stem_common:payment_terminal:complete", initPlayer.source)

    TriggerClientEvent("stem_common:payment_terminal:playSound", initPlayer.source, "WEAPON_PURCHASE", "HUD_AMMO_SHOP_SOUNDSET")
    TriggerClientEvent("stem_common:payment_terminal:playSound", player.source, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    
    Player(initPlayer.source).state.invoice = nil
end)

RegisterNetEvent("stem_common:payment_terminal:finish", function (initPlayer) 
    local player = ESX.GetPlayerFromId(source)
    player.showNotification("Payment Canceled")
    TriggerClientEvent('stem_common:payment_terminal:complete', player.source)
    Player(initPlayer).state.invoice = nil
end)


ESX.RegisterUsableItem("pos_terminal", function (source, itemName, data)
    TriggerClientEvent('stem_common:payment_terminal:beginTerminal', source, nil, nil, data.metadata)
end)

ESX.RegisterCommand("registerpos", {"admin"}, function (player, args)
    local item = exports.ox_inventory:GetSlot(player.source, args.slot)
    if (not item) then return print("item not found") end
    if (item.name ~= "pos_terminal") then return print("invalid terminal") end
    
    exports.ox_inventory:SetMetadata(player.source, args.slot, {
        society = args.society,
        ppratio = args.ppratio
    })
end, false, {help = 'Register a POS terminal', validate = true, arguments = {
	{ name = 'slot', help = 'Slot', type = 'number' },
	{ name = 'society', help = 'Society', type = 'string' },
	{ name = 'ppratio', help = 'Player Payout Ratio', type = 'number' }
}})

RegisterNetEvent("stem_common:payment_terminal:purchaseTerminal", function (total, societyName, ppratio) 
    local player = ESX.GetPlayerFromId(source)
    
    local totalPrice = total * 250
    if (player.job.name ~= societyName) then 
        return player.showNotification("You must be apart of the society to do this")
    end
    
    local society = exports.esx_society:GetSociety(societyName)

    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
        if not account then return end
        if (account.money < totalPrice) then
            return player.showNotification("The society does not have enough money for these")
        end
        account.removeMoney(totalPrice)
        player.showNotification(("The society has been charged **$%s** for x%s payment terminals"):format(ESX.Math.GroupDigits(totalPrice), total))
    

        exports.ox_inventory:AddItem(player.source, "pos_terminal", total, 
        {
            ppratio = ppratio,
            society = societyName
        })
    end)
end)
