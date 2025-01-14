local checkIfOnContactsNumber = function(source, checkedPhoneNumber)
    local result = MySQL.query.await('SELECT display FROM npwd_phone_contacts WHERE identifier = ? AND number = ?', {ESX.GetPlayerFromId(source).getIdentifier(), checkedPhoneNumber})
    if result[1] then
        return result[1].display
    else
        return checkedPhoneNumber
    end
end

local checkIfPhoneNumberEventExists = function(phoneNumber)
    local result = MySQL.query.await('SELECT accounts FROM users WHERE phone_number = ?', {phoneNumber})
    if result[1] then
        return result[1].accounts
    end
    return false
end

local formatData = function(transactionData, sourcePhoneNumber, source)
    local currentData = {
        type = 0,
        amount = transactionData.amount,
        name = "",
        date = transactionData.date
    }

    currentData.type = transactionData.from == sourcePhoneNumber and 0 or 1
    currentData.name = checkIfOnContactsNumber(source, transactionData.from == sourcePhoneNumber and transactionData.to or transactionData.from)

    print("Po ustaleniu ustalam że typ:", currentData.type, "Wyświetlana nazwa :", currentData.name)

    return currentData
end

local addMoneyToPhoneNumber = function(phoneNumber, accounts, amount)
    local accountsData = json.decode(accounts)
    print(accountsData, accountsData.bank)
    accountsData.bank = tonumber(accountsData.bank) + amount
    MySQL.query.await("UPDATE users SET accounts = ? WHERE phone_number = ?", {json.encode(accountsData), phoneNumber})
end


ESX.RegisterServerCallback('npwd:esx-banking:getBankingInfo', function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    local transactions = {}
    local info = exports['npwd']:getPlayerData({ source = src })
    local result = MySQL.query.await('SELECT * FROM npwd_phone_transactions WHERE `from` = ? OR `to` = ? ORDER BY id DESC LIMIT 4', {info.phoneNumber, info.phoneNumber})
    if result[1] then
        for transactionId,transactionData in pairs(result) do
            transactions[#transactions + 1] = formatData(transactionData, info.phoneNumber, src)
        end
    end
    cb( {
        amount = xPlayer.getAccount('bank').money,
        transactions = transactions
    })
end)

ESX.RegisterServerCallback('npwd:esx-banking:checkPhoneNumber', function(src,cb, phoneNumber, amount, date)
    local info = exports['npwd']:getPlayerData({ phoneNumber = phoneNumber })
    local sourceInfo = exports['npwd']:getPlayerData({ source = src })
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getAccount('bank').money < amount then
        cb("NMONEY")
        return
    end
    if info == nil then
        local exists = checkIfPhoneNumberEventExists(phoneNumber)
        if exists then
            xPlayer.removeAccountMoney('bank', amount)
            addMoneyToPhoneNumber(phoneNumber, exists, amount)
            MySQL.query.await("INSERT INTO npwd_phone_transactions(`from`, `to`, `amount`, `type`, `date`) VALUES (?,?,?,?,?)", {sourceInfo.phoneNumber, phoneNumber, tonumber(amount), 0, date})
            TriggerClientEvent('npwd:esx-banking:updateTransactions', src)
            cb("GOOD")
        else
            cb("NEXIST")
        end
    else
        local xTarget = ESX.GetPlayerFromIdentifier(info.identifier)
        xPlayer.removeAccountMoney('bank', amount)
        xTarget.addAccountMoney('bank', amount)
        MySQL.query.await("INSERT INTO npwd_phone_transactions(`from`, `to`, `amount`, `type`, `date`) VALUES (?,?,?,?,?)", {sourceInfo.phoneNumber, phoneNumber, tonumber(amount), 0, date})
        TriggerClientEvent('npwd:esx-banking:updateTransactions', src)
        TriggerClientEvent('npwd:esx-banking:updateTransactions', xTarget.source)
        xTargetxPlayer.triggerEvent('npwd:esx-banking:showNotify', amount, sourceInfo.phoneNumber)
        cb("GOOD")
    end
end)