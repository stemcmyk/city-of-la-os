if Config.FrameWork.FRAMEWORK ~= 'CUSTOM' then return end

function __TODO()
    print("You are not using a known framework, please configure framework/custom/server.lua")
end

function RegisterUsableItem(...)
    __TODO()
end

function GetPlayerFromId(source)
    local xPlayer = {}

    xPlayer.identifier = GetPlayerIdentifierByType(source, 'license')
    xPlayer.license = GetPlayerIdentifierByType(source, 'license')
    xPlayer.name = GetPlayerName(source)

    xPlayer.getGroup = function()
        return __TODO()
    end

    xPlayer.getJob = function()
        return __TODO()
    end

    xPlayer.getGang = function()
        return __TODO()
    end

    xPlayer.setInventoryItem = function(item, count)
        __TODO()
    end

    xPlayer.clearInventory = function()
        __TODO()
    end

    xPlayer.addInventoryItem = function(item, count)
        __TODO()
    end

    xPlayer.removeInventoryItem = function(item, count)
        __TODO()
    end

    xPlayer.addWeapon = function(item)
        __TODO()
    end

    xPlayer.removeWeapon = function(item)
        __TODO()
    end

    xPlayer.getMoney = function()
        return __TODO()
    end

    xPlayer.addMoney = function(money)
        __TODO()
    end

    xPlayer.addAccountMoney = function(type, money)
        __TODO()
    end

    xPlayer.getAccount = function(type)
        return __TODO()
    end

    xPlayer.removeAccountMoney = function(type, money)
        __TODO()
    end

    xPlayer.removeMoney = function(money)
        __TODO()
    end

    xPlayer.setJob = function(job, grade)
        __TODO()
    end

    xPlayer.setGang = function(gang, grade)
        __TODO()
    end

    xPlayer.setGroup = function(group)
        __TODO()
    end

    xPlayer.getInventoryItem = function(itemName)
        return __TODO()
    end

    return xPlayer
end