---@param garage GarageData
local function createGarageBlip(garage)
    local data = Config.Blips[garage.Type]?.Garage

    if data then
        return Utils.createBlip(garage.Position or garage.PedPosition, data.Name, data.Sprite, data.Size, garage.Users and 2 or data.Color)
    else
        warn('Missing blip data for vehicle type: %s', garage.Type)
    end
end

---@param impound ImpoundData
local function createImpoundBlip(impound)
    local data = Config.Blips[impound.Type]?.Impound

    if data then
        Utils.createBlip(impound.Position or impound.PedPosition, data.Name, data.Sprite, data.Size, data.Color)
    else
        warn('Missing blip data for vehicle type: %s', impound.Type)
    end
end

local blips = {}

function refreshBlips(garages) 
    for key, value in pairs(blips) do
        RemoveBlip(value)
    end
    for _, garage in ipairs(garages or Config.Garages) do
        if garage.Visible then
            if (not garage.Users or exports.stem_common:tableContains(garage.Users, ESX.PlayerData.identifier)) then
                table.insert(blips, createGarageBlip(garage))
            end
        end
    end
end

refreshBlips()

for _, impound in ipairs(Config.Impounds) do
    if impound.Visible then
        createImpoundBlip(impound)
    end
end


RegisterNetEvent("lunar_garage:updateGarages", function (newGarages)
    Config.Garages = newGarages
    refreshBlips(newGarages)
end)