
math.randomseed(math.floor(os.clock()*100000000000))
math.randomseed(math.floor(os.clock()*math.random()))
math.randomseed(math.floor(os.clock()*math.random()))

getChipsCallback = SetGetChipsCallback
takeChipsCallback = SetTakeChipsCallback
giveChipsCallback = SetGiveChipsCallback

local activeSlot = {}

ESX.RegisterServerCallback('casino:slots:isSeatUsed',function(source, cb, index)
	if activeSlot[index] ~= nil then
		if activeSlot[index].used then
			cb(true)
		else
			activeSlot[index].used = true
			cb(false)
		end
	else
		activeSlot[index] = {}
		activeSlot[index].used = true
		cb(false)
	end
end) 

RegisterNetEvent('casino:slots:notUsing')
AddEventHandler('casino:slots:notUsing',function(index)
	if activeSlot[index] ~= nil then
		activeSlot[index].used = false
	end
end)



RegisterNetEvent('casino:taskStartSlots')
AddEventHandler('casino:taskStartSlots',function(index, data)
	local player = ESX.GetPlayerFromId(source)
	local Chips = getChipsCallback(player.source)
	local minAmount = data.bet
	if Chips ~= nil then 
		if Chips >= minAmount then
			if activeSlot[index] then
				takeChipsCallback(player.source, minAmount)
				local w = {a = math.random(1,16),b = math.random(1,16),c = math.random(1,16)}
				local rnd1 = math.random(1,100)
				local rnd2 = math.random(1,100)
				local rnd3 = math.random(1,100)
				if Config_Slots.Offset then 
					if rnd1 > 70 then w.a = w.a + 0.5 end
					if rnd2 > 70 then w.b = w.b + 0.5 end
					if rnd3 > 70 then w.c = w.c + 0.5 end
				end
				TriggerClientEvent('casino:slots:startSpin', player.source, index, w)
				activeSlot[index].win = w
			end 
		else
			return TriggerClientEvent('esx:showNotification', player.source, 'You dont have enough white chips', 'error')
		end
	else
		return TriggerClientEvent('esx:showNotification', player.source, 'You dont have any white chips', 'error')
	end
end) 


RegisterNetEvent('casino:slotsCheckWin')
AddEventHandler('casino:slotsCheckWin',function(index, data, dt)
	if activeSlot[index] then
		if activeSlot[index].win then
			if activeSlot[index].win.a == data.a
			and activeSlot[index].win.b == data.b
			and activeSlot[index].win.c == data.c then
				CheckForWin(activeSlot[index].win, dt)
			end 
		end
	end
end)

function CheckForWin(w, data)
	local src = source 
	local a = Config_Slots.Wins[w.a]
	local b = Config_Slots.Wins[w.b]
	local c = Config_Slots.Wins[w.c]
	local total = 0
	if a == b and b == c and a == c then
		if Config_Slots.Mult[a] then
			total = data.bet*Config_Slots.Mult[a]
		end		
	elseif a == '6' and b == '6' then
		total = data.bet*5
	elseif a == '6' and c == '6' then
		total = data.bet*5
	elseif b == '6' and c == '6' then
		total = data.bet*5
		
	elseif a == '6' then
		total = data.bet*2
	elseif b == '6' then
		total = data.bet*2
	elseif c == '6' then
		total = data.bet*2
	end
	local player = ESX.GetPlayerFromId(src)
	if total > 0 then
		SetGiveChipsCallback(src, total)
		exports.stem_discord:getUserDiscord(player.source, function (playerDiscord) 
			exports.stem_discord:sendThroughWebhook({
				webhook = WEBHOOK,
				params = {
					username = "Roulette Win",
					content = ("<@%s> **%s**  ``%s (%s)`` has won **$%s** from **Slots** "):format(playerDiscord, player.name, GetPlayerName(player.source), total)
				}
			})
		end)
		TriggerClientEvent('esx:showNotification', src, "You Won "..total.." whitechip casino chips!")
	else
		TriggerClientEvent('esx:showNotification', src, "You Lost, Better luck next time!", 'error')
	end
end
