local JOB_PAYOUT_WEBHOOK = GetConvar("job_payout_webhook", nil)
local SUS_ACTIVITY_WEBHOOK = GetConvar("sus_activity", nil)

ESX.RegisterServerCallback('void-busjob:updatedPoints', function(source, cb, collectedPoints)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE users SET busPoints = @busPoints WHERE identifier = @identifier', {
        ['@busPoints'] = collectedPoints,
        ['@identifier'] = xPlayer.identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            cb(true)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('void-busjob:getTotalPoints', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchScalar('SELECT busPoints FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(totalPoints)
        if totalPoints then
            cb(totalPoints)
        else
            cb(0)
        end
    end)
end)


ESX.RegisterServerCallback('void-busjob:payAndResetPoints', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchScalar('SELECT busPoints FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(currentPoints)
        if currentPoints and currentPoints > 0 then
            local totalPrice = currentPoints * Config.PricePerPoint

            xPlayer.addAccountMoney('bank', totalPrice)

            MySQL.Async.execute('UPDATE users SET busPoints = 0 WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.identifier
            })


            if (JOB_PAYOUT_WEBHOOK) then
                exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
                    exports.stem_discord:sendThroughWebhook({
                        webhook = JOB_PAYOUT_WEBHOOK,
                        params = {
                            username = "Job Delivery",
                            content = ([[
                                <@%s> ``%s (%s)`` **%s** was paid **$%s** for **x%s** Bus Driver points
                            ]]):format(
                                playerDiscord, xPlayer.name, GetPlayerName(xPlayer.source), xPlayer.identifier, totalPrice, currentPoints
                            ),
                        },
                        ignoreEnv = true,
                    })
                end)
            else
                print("No job_payout_webhook found")
            end
            

            cb(currentPoints, totalPrice)
        else
            cb(0, 0)
        end
    end)
end)

local playersDeposited = {}

ESX.RegisterServerCallback('void-busjob:deposit', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    

    if xPlayer.getAccount('bank').money >= Config.Deposit then
        xPlayer.removeAccountMoney('bank', Config.Deposit)
        playersDeposited[xPlayer.source] = true
        cb(true)
    else
        cb(false)
    end
end)


ESX.RegisterServerCallback('void-busjob:addDepositToBank', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (not playersDeposited[xPlayer.source]) then

        if (SUS_ACTIVITY_WEBHOOK) then
            exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
                exports.stem_discord:sendThroughWebhook({
                    webhook = SUS_ACTIVITY_WEBHOOK,
                    params = {
                        username = "Sus Activity",
                        content = ([[
                            <@%s> ``%s`` **%s** tried to cash in a deposit they didn't put in
                        ]]):format(
                            playerDiscord, xPlayer.identifier, xPlayer.name
                        ),
                    },
                    ignoreEnv = true,
                })
            end)
        else
            print("No sus_activity found")
        end
        return 
    end
    xPlayer.addAccountMoney('bank', Config.Deposit)
    cb(true)
end)

