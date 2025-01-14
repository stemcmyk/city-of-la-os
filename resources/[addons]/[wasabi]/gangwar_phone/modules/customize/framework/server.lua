-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
------------------------------------
-- Custom framework modifications --
------------------------------------
function GivePlayerFundsOffline(identifier, amount)
    if amount < 1 then return end
    if wsb.framework == 'esx' then

        -- ESX write to SQL funds
        local accounts = MySQL.query.await('SELECT `accounts` FROM `users` WHERE `identifier` = ?', {
            identifier
        })
        if not accounts or not accounts[1].accounts then return end
        accounts = json.decode(accounts[1].accounts)
        if Config.PayWagerAccount == 'cash' then Config.PayWagerAccount = 'money' end
        accounts[Config.PayWagerAccount] = math.floor(accounts[Config.PayWagerAccount] + amount)
        local updated = MySQL.update.await('UPDATE users SET accounts = ? WHERE identifier = ?', {
            json.encode(accounts), identifier
        })
        return updated


    elseif wsb.framework == 'qb' then

        -- QBCore write to SQL funds
        local accounts = MySQL.query.await('SELECT `money` FROM `players` WHERE `citizenid` = ?', {
            identifier
        })
        if not accounts or not accounts[1].money then return end
        accounts = json.decode(accounts[1].money)
        if Config.PayWagerAccount == 'money' then Config.PayWagerAccount = 'cash' end
        accounts[Config.PayWagerAccount] = math.floor(accounts[Config.PayWagerAccount] + amount)
        local updated = MySQL.update.await('UPDATE players SET money = ? WHERE citizenid = ?', {
            json.encode(accounts), identifier
        })
        return updated

    else
        -- Custom Framework??
    end
end