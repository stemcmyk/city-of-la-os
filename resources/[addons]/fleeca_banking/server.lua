local BankStatus = {}

-- Trigger this event in your bank robbery scripts to disable bank services

RegisterServerEvent('fleeca_banking:server:SetBankState')
AddEventHandler('fleeca_banking:server:SetBankState', function(BankId, bool)
  BankStatus[BankId] = bool
  TriggerClientEvent('fleeca_banking:client:SetBankState', -1, BankId, bool)
end)

local BANKING_WEBHOOK = GetConvar("banking_webhook", nil)



RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('bank:result', _source, "error", "Insuccifient cash on you.")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
		TriggerClientEvent('bank:result', _source, "success", "Deposited successfully")
		if (BANKING_WEBHOOK) then
			exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
				exports.stem_discord:sendThroughWebhook({
					webhook = BANKING_WEBHOOK,
					params = {
						username = "Bank Transfer Log",
						content = ([[
							<@%s> ``%s`` **%s** deposited **$%s** to their bank\n
							New Bank Balance: **$%s** New Wallet Ballance **$%s**
						]]):format(
							playerDiscord, xPlayer.identifier, xPlayer.name, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(xPlayer.getAccount("bank").money), ESX.Math.GroupDigits(xPlayer.getAccount("money").money)
						),
					},
					ignoreEnv = true,
				})
	
			end)
		else
			print("No banking_webhook found")
		end
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('bank:result', _source, "error", "Insufficient funds in bank account.")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('bank:result', _source, "success", "Withdrawl successfully")
		if (BANKING_WEBHOOK) then

			exports.stem_discord:getUserDiscord(xPlayer.source, function (playerDiscord) 
				exports.stem_discord:sendThroughWebhook({
					webhook = BANKING_WEBHOOK,
					params = {
						username = "Bank Transfer Log",
						content = ([[
							<@%s> ``%s`` **%s** withdrew **$%s** from their bank\n
							New Bank Balance: **$%s** New Wallet Ballance **$%s**
						]]):format(
							playerDiscord, xPlayer.identifier, xPlayer.name, ESX.Math.GroupDigits(amount), ESX.Math.GroupDigits(xPlayer.getAccount("bank").money), ESX.Math.GroupDigits(xPlayer.getAccount("money").money)
						),
					},
					ignoreEnv = true,
				})
	
			end)
		else
			print("No banking_webhook found")
		end
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	local balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
end)


RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0

	if(zPlayer == nil or zPlayer == -1) then
		TriggerClientEvent('bank:result', _source, "error",  "Player is sleeping.")
	else
		balance = xPlayer.getAccount('bank').money
		zbalance = zPlayer.getAccount('bank').money
		
		if tonumber(_source) == tonumber(to) then
			TriggerClientEvent('bank:result', _source, "error", "You can't transfer money to yourself.")
		else
			if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent('bank:result', _source, "error", "Insufficient funds in bank account.")
			else
				xPlayer.removeAccountMoney('bank', tonumber(amountt))
				zPlayer.addAccountMoney('bank', tonumber(amountt))
				TriggerClientEvent('bank:result', _source, "success", "Successfully Transferred")
			end
		end
	end
end)

RegisterServerEvent('banking:server:giveCash')
AddEventHandler('banking:server:giveCash', function(trgtId, amount)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local zPlayer = ESX.GetPlayerFromId(trgtId)

	if src ~= trgtId then
		balance = xPlayer.getMoney()

		if balance <= 0 or balance < tonumber(amount) or tonumber(amount) <= 0 then
			TriggerClientEvent('bank:result', src, "error", "Insufficent cash.")
		else
			xPlayer.removeAccountMoney('cash', tonumber(amount))
			zPlayer.addAccountMoney('cash', tonumber(amount))
			TriggerClientEvent('bank:result', src, "success", "Successfully gave "..amount)
			TriggerClientEvent('bank:result', trgtId, "success", "Successfully received "..amount)
		end
	else
		TriggerClientEvent('bank:result', src, "error", "You can't transfer money to yourself.")
	end
end)

TriggerEvent('es:addGroupCommand', 'givecash', 'user', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local TargetId = tonumber(args[1])
	local zPlayer = ESX.GetPlayerFromId(TargetId)
	local amount = tonumber(args[2])

	if zPlayer ~= nil then
		if amount ~= nil then
		  if amount > 0 then
			if xPlayer.getMoney() >= amount and amount > 0 then
			  if TargetId ~= source then
				TriggerClientEvent('banking:client:CheckDistance', source, TargetId, amount)
			  else
				TriggerClientEvent('bank:result', source, "error", "You can't transfer money to yourself.")    
			  end
			else
				TriggerClientEvent('bank:result', source, "error", "Insufficent cash.")
			end
		  else
			TriggerClientEvent('bank:result', source, "error", "Sending 0 dumbfuck ?.")
		  end
		else
			TriggerClientEvent('bank:result', source, "error", "Enter Amount.")
		end
	  else
		TriggerClientEvent('bank:result', source, "error", "Player is sleeping.")
	  end  
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end,{
		help = ("Givecash to nearby player"),
	 	params = {
			 {name = "id", help = "PlayerID"},
			 {name = "amount", help = "Amount"}
		}
	}
)

ESX.RegisterServerCallback('fleeca_banking:fetchData', function(source, cb , data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local data = {}
	GetData(source, function(PlayerData)
		if PlayerData ~= nil then
			data.firstname = PlayerData.firstname ~= nil and PlayerData.firstname or "UNKNOWN"
			data.lastname = PlayerData.lastname ~= nil and PlayerData.lastname or "UNKNOWN"
			cb(data)
		else
			print('[NEW BANKING] Data is Nil')
		end
	end)
end)

function GetData(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT * FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		local data = {}
		if result[1] and result[1].firstname and result[1].lastname  then
			data.firstname = result[1].firstname
			data.lastname = result[1].lastname
			callback(data)
		else
			print('[NEW BANKING] -  Your database has some nil values in user table (firstname / lastname) of : ' .. xPlayer.identifier)
		end
	end)
end
