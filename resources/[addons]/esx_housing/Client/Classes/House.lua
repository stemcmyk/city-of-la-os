loaded_class = promise.new()

CheckNegativeNumber = function(number)
    if number < 0 then
        return 0
    else
        return number
    end
end

CreateHouse = function(data)
    local self = {}
    self.id = data.id
    self.data = data.data
    self.storage = data.storage
    self.keys = data.keys
    self.owner = data.owner
    self.owned = false
    self.doorpos = vector3(self.data.door.x, self.data.door.y, self.data.door.z-1)
    self.extradata = data.extradata


    if self.owner == ESX.PlayerData.identifier then
        self.owned = true
    end

    self.hasKeys = function()
        for k,v in pairs(self.keys) do
            if v == ESX.PlayerData.identifier then
                return true
            end
        end
        return false
    end

    self.getdistance = function(coords)
        local coords = vector3(coords.x, coords.y, coords.z)
        return #(coords - self.doorpos)
    end

    self.ring = function()
        TriggerServerEvent('esx_housing:Ring', self.id)
    end

    return self
end