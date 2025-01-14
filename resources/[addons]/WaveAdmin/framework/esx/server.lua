if Config.FrameWork.FRAMEWORK ~= 'ESX' then return end

ESX = nil

GetFrameWorkObject(function(object)
    ESX = object
end)

function RegisterUsableItem(...)
    ESX.RegisterUsableItem(...)
end

function GetPlayerFromId(source)
    if not ESX then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return nil end

    local oldGetGang = xPlayer.getGang
    xPlayer.getGang = function()
        local getGang = (xPlayer.getJob2 ~= nil and xPlayer.getJob2()) or (oldGetGang ~= nil and oldGetGang()) or {}
        return {
            grade = getGang.grade or 0,
            grade_label = getGang.grade_label or nil,
            name = getGang.name or 0
        }
    end

    xPlayer.clearInventory = function()
        for k,v in ipairs(xPlayer.inventory) do
            if v.count > 0 then
                xPlayer.setInventoryItem(v.name, 0)
            end
        end
    end

    return xPlayer
end