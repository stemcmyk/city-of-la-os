if Config.FrameWork.FRAMEWORK ~= 'QBCORE' then return end

QBCore = nil
GetFrameWorkObject(function(object)
    QBCore = object
end)

function RegisterUsableItem(...)
    QBCore.Functions.CreateUseableItem(...)
end

function GetPlayerFromId(source)
    if not QBCore then return end
    local xPlayer = {}
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then
        return nil
    end


    xPlayer.identifier = Player.PlayerData.citizenid
    xPlayer.license = Player.PlayerData.license
    xPlayer.name = Player.PlayerData.name
    xPlayer.source = tonumber(source)

    xPlayer.getGroup = function()
        return QBCore.Functions.GetPermission(source)
    end

    xPlayer.getJob = function()
        if not Player.PlayerData.job or not Player.PlayerData.job.grade then
            return {
                grade = 0,
                grade_name = nil,
                name = nil
            }
        end

        local gradeName = "none"
        local gradeLevel = -1

        if Player.PlayerData.job.grade then
            gradeName = Player.PlayerData.job.grade.name
            gradeLevel = Player.PlayerData.job.grade.level
        elseif Player.PlayerData.job.grades then
            gradeLevel = GetGreatestNumber(Player.PlayerData.job.grades)
        end

        return {
            grade = gradeLevel,
            grade_name = gradeName,
            name = Player.PlayerData.job.name or "none"
        }
    end

    xPlayer.getGang = function()
        if not Player.PlayerData.gang or not Player.PlayerData.gang.grade then
            return {
                grade = 0,
                grade_label = nil,
                name = nil
            }
        end

        local gradeName = "none"
        local gradeLevel = -1

        if Player.PlayerData.gang.grade then
            gradeName = Player.PlayerData.gang.grade.name
            gradeLevel = Player.PlayerData.gang.grade.level
        elseif Player.PlayerData.gang.grades then
            gradeLevel = GetGreatestNumber(Player.PlayerData.gang.grades)
        end

        return {
            grade = gradeLevel,
            grade_label = gradeName,
            name = Player.PlayerData.gang.name or "none"
        }
    end

    xPlayer.setInventoryItem = function(item, count)
        local qbItem = Player.Functions.GetItemByName(item) or {}
        Player.Functions.RemoveItem(item, qbItem.amount or 0)
        Player.Functions.AddItem(item, count)
    end

    xPlayer.clearInventory = function()
        exports["qb-inventory"]:ClearInventory(xPlayer.source)
    end

    xPlayer.addInventoryItem = function(item, count)
        Player.Functions.AddItem(item, count)
    end

    xPlayer.removeInventoryItem = function(item, count)
        Player.Functions.RemoveItem(item, count)
    end

    xPlayer.addWeapon = function(item)
        Player.Functions.AddItem(item, 1)
    end

    xPlayer.removeWeapon = function(item)
        Player.Functions.AddItem(item, 1)
    end

    xPlayer.getMoney = function()
        return Player.Functions.GetMoney("cash")
    end

    xPlayer.addMoney = function(money)
        Player.Functions.AddMoney("cash", money)
    end

    xPlayer.addAccountMoney = function(type, money)
        Player.Functions.AddMoney(type, money)
    end

    xPlayer.setAccountMoney = function(type, money)
        Player.Functions.SetMoney(type, money)
    end

    xPlayer.getAccount = function(type)
        return {
            money = Player.Functions.GetMoney(type) or 0
        }
    end

    xPlayer.removeAccountMoney = function(type, money)
        Player.Functions.RemoveMoney(type, money)
    end

    xPlayer.removeMoney = function(money)
        Player.Functions.RemoveMoney("cash", money)
    end

    xPlayer.setJob = function(job, grade)
        Player.Functions.SetJob(tostring(job), tonumber(grade))
    end

    xPlayer.setGang = function(gang, grade)
        Player.Functions.SetGang(tostring(gang), tonumber(grade))
    end

    xPlayer.setGroup = function(group)
        QBCore.Functions.AddPermission(Player.PlayerData.source, group)
    end

    xPlayer.getInventoryItem = function(itemName)
        local item = Player.Functions.GetItemByName(itemName) or {}

        local ItemInfo = {
            name = itemName,
            count = item.amount or 0,
            label = item.label or "none",
            weight = item.weight or 0,
            usable = item.useable or false,
            rare = false,
            canRemove = false
        }
        return ItemInfo
    end

    return xPlayer
end