---@class Bill
---@field title string
---@field amount number
---@field category string | nil

--- func sendCriminalBillw
---@param playerid string
---@param bills Bill[]
function sendCriminalBills  (playerid, bills)
	local xTarget = ESX.GetPlayerFromId(playerid) 
	
	if #bills > 0 then
		local transactions = exports.stem_common:tableMap(bills, 
		--- func desc
		---@param bill Bill
		function (bill) 
			return {
				"INSERT INTO criminal_billing (caseId, identifier, label, amount, category, issue_date) VALUES (?, ?, ?, ?, ?, ?)",
                {
                    tonumber(bill.case),
                    xTarget.identifier,
                    bill.title,
                    bill.amount,
                    bill.category,
                    os.date('%Y-%m-%d %H:%M:%S', os.time()),
                }
			}
		end)

        local result = MySQL.transaction.await(transactions)
        print(result)
	end
end

-- expungeDate = os.time() + 60 * 60 * 24 * 7

exports("sendCriminalBills", sendCriminalBills )

local pleaTitle = {
    [1] = "Not Plead",
    [2] = "Not Guilty",
    [3] = "Guilty",
    [4] = "No Contest"
}

ESX.RegisterServerCallback("esx_billing:getCharges", function (source, cb, type, targetSource)
    local player = ESX.GetPlayerFromId(source)
    local target = not targetSource and player or ESX.GetPlayerFromId(targetSource)

    if (targetSource) then
        if (player.job.name ~= "doj") then
            return player.showNotification("You do not have permission to do this.")
        end
    end
 
    
    local result = {}
    
    if (type == "change_plea") then
        result = MySQL.query.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND NOT plea_entered = 3 AND not category = 'Ticket'", {
            ["@identifier"] = target.identifier
        })
    end
    if (type == "judge") then
        result = MySQL.query.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND NOT plea_entered = 3", {
            ["@identifier"] = target.identifier
        })
    end
    if (type == "bills") then
        result = MySQL.query.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND NOT plea_entered = 3 AND category = 'Ticket'", {
            ["@identifier"] = target.identifier
        })
    end
    if (type == "convictions") then
        result = MySQL.query.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND plea_entered = 3 OR plea_entered = 4", {
            ["@identifier"] = target.identifier
        })
    end
    table.sort(result, function (a, b)
        if (a.expunge_date and a.expunge_date > 0 and b.expunge_date and b.expunge_date > 0) then
            return a.expunge_date > b.expunge_date
        else
            return a.issue_date > b.issue_date
        end
    end)

    for key, value in pairs(result) do
        if (value.issue_date and value.issue_date > 0) then
            value.issue_date = os.date('%m/%d %H:%M', value.issue_date / 1000)
        end
        if (value.plea_entered_date and value.plea_entered_date > 0) then
            value.plea_entered_date = os.date('%m/%d %H:%M', value.plea_entered_date / 1000)
        end
        if (value.expunge_date and value.expunge_date > 0) then
            value.expunge_date = os.date('%m/%d %H:%M', value.expunge_date / 1000)
        end
        
        value.plea_entered = pleaTitle[value.plea_entered]
    end


    return cb(result)
end)

ESX.RegisterServerCallback("esx_billing:getCriminalCharges", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND plea_entered = 0 AND NOT category = 'Ticket'", {
        ["@identifier"] = player.identifier
    })

    for key, value in pairs(result) do
        if (value.issue_date) then
            value.issue_date = os.date('%m/%d %H:%M', value.issue_date / 1000)
        end
    end

    return cb(result)
end)

ESX.RegisterServerCallback("esx_billing:pleadGuiltyOrNoContest", function (source, cb, type, id) 
    local player = ESX.GetPlayerFromId(source)
    local charge = MySQL.single.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND id = @id", {
        ["@identifier"] = player.identifier,
        ["@id"] = id
    })


    local hasMoney = player.getAccount("bank").money >= charge.amount
    if (not hasMoney) then
        player.showNotification("You do not have enough to pay this fine", "error")
        return cb(false)
    end

	player.removeAccountMoney("bank", charge.amount)
    exports["stem_gangsystem"]:addToPlayerStatistics(player.identifier, {
        fines_paid = charge.amount,
    })

    local result = MySQL.query.await([[
        UPDATE criminal_billing 
        SET 
            plea_entered = @plea_entered, 
            plea_entered_date = @plea_entered_date, 
            expunge_date = @expunge_date
        WHERE 
            identifier = @identifier 
            AND 
            id = @id
        ]], 
        {
            ["@plea_entered"] = type == "ncontest" and 4 or 3 ,
            ["@plea_entered_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
            ["@expunge_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time() + 60 * 60 * 24 * 7),
            ["@identifier"] = player.identifier,
            ["@id"] = id
        }
    )
    cb(result)
end)

ESX.RegisterServerCallback("esx_billing:pleadNotGuilty", function (source, cb, id) 
    local player = ESX.GetPlayerFromId(source)
    local result = MySQL.query.await([[
        UPDATE criminal_billing 
        SET 
            plea_entered = @plea_entered, 
            plea_entered_date = @plea_entered_date
        WHERE 
            identifier = @identifier 
            AND 
            id = @id
        ]], 
        {
            ["@plea_entered"] = 2,
            ["@plea_entered_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
            ["@identifier"] = player.identifier,
            ["@id"] = id
        }
    )
    cb(result)
end)

ESX.RegisterServerCallback("esx_billing:payBill", function (source, cb, id) 
    local player = ESX.GetPlayerFromId(source)
    local charge = MySQL.single.await("SELECT * FROM criminal_billing WHERE identifier = @identifier AND id = @id", {
        ["@identifier"] = player.identifier,
        ["@id"] = id
    })

	if (not charge) then
		return player.showNotification("This bill does not exist", "error")
	end

    local hasMoney = player.getAccount("bank").money >= charge.amount
    if (not hasMoney) then
        player.showNotification("You do not have enough to pay this fine", "error")
        return cb(false)
    end

	player.removeAccountMoney("bank", charge.amount)
	
	player.showNotification(string.format("You've paid a fine of $%s", ESX.Math.GroupDigits(charge.amount)), "success")

	
    local charge = MySQL.single.await("UPDATE criminal_billing SET plea_entered = @plea_entered, expunge_date = @expunge_date WHERE identifier = @identifier AND id = @id", {
		["@plea_entered"] = 3,
		["@plea_entered_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time()),
		["@expunge_date"] = os.date('%Y-%m-%d %H:%M:%S', os.time() + 60 * 60 * 24 * 7),
        ["@identifier"] = player.identifier,
        ["@id"] = id
    })

    exports["stem_gangsystem"]:addToPlayerStatistics(player.identifier, {
        fines_paid = charge.amount,
    })

    cb(true)
end)

ESX.RegisterServerCallback('esx_billing:getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.query('SELECT amount, id, label FROM billing WHERE identifier = ?', {xPlayer.identifier},
	function(result)
		cb(result)
	end)
end)
