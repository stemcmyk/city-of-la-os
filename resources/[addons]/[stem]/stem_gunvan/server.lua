local locations = {
    vector4(275.34, 66.45, 94.58, 159.7),
    vector4(1103.38, -337.88, 67.21, 303.44),
    vector4(-73.4, 6387.19, 31.49, 134.3),
    vector4(1705.74, 4823.82, 42.02, 184.24),
    vector4(1795.25, 3897.34, 34.08, 12.1),
    vector4(1344.88, 2739.04, 52.18, 218.87),
    vector4(795.38, 1208.94, 339.16, 161.4),
    vector4(-3187.86, 1082.62, 20.84, 157.78),
    vector4(-787.29, 5400.88, 34.18, 266.85),
    vector4(-28.82, 3044.28, 40.99, 96.21),
    vector4(2663.71, 1468.8, 24.5, 91.1),
    vector4(-1461.6, 2674.08, 4.14, 138.41),
    vector4(2342.49, 3052.35, 48.15, 96.09),
    vector4(1518.06, -2145.8, 77.19, 93.22),
    vector4(1139.57, -1358.57, 34.59, 89.76),
    vector4(-57.3, -2659.68, 6.0, 181.5),
    vector4(1907.45, 569.37, 175.82, 65.17),
    vector4(973.4, -1718.36, 30.54, 266.5),
    vector4(779.08, -3264.78, 5.97, 356.44),
    vector4(-588.45, -1640.62, 19.81, 101.7),
    vector4(713.24, -725.77, 25.85, 94.1),
    vector4(-1701.74, -446.88, 41.62, 142.13),
    vector4(-1333.76, -1163.7, 4.55, 91.49),
    vector4(-497.02, 37.75, 52.58, 220.15),
    vector4(261.09, -762.74, 30.82, 159.96),
    vector4(-472.31, -726.64, 30.56, 356.94),
    vector4(895.1, 3579.63, 33.37, 175.29),
    vector4(-2167.98, 4279.8, 48.96, 335.31),
    vector4(1460.47, 6559.8, 13.96, 287.08),
    vector4(150.61, -1657.43, 29.29, 33.69),
    vector4(-1154.51, -1986.78, 13.16, 134.27)
}


local GunVan;

---@class GunVanItem
---@field title string
---@field itemName string
---@field price number
---@field max number

local gunVanItemsByItemName = {}
local gunVanItems = exports.stem_common:tableMap({
    {
        title = "Pain Killers",
        itemName = "painkillers",
        price = 500,
        max = 20,
    },
    {
        title = "ATM Hacker",
        itemName = "atmhacker",
        price = 750,
        max = 5,
    },
    {
        title = "Makarov",
        itemName = "WEAPON_PM",
        price = 1000,
        max = 12,
    }, 
    {
        title = "Glock 26",
        itemName = "WEAPON_APPISTOL",
        price = 5000,
        max = 8,
    }, 
    {
        title = "Mac 10",
        itemName = "WEAPON_MAC10",
        price = 4500,
        max = 12,
    },
    {
        title = "Katana",
        itemName = "WEAPON_KATANA",
        price = 3000,
        max = 4
    },
    {
        title = "Switchblade",
        itemName = "WEAPON_SWITCHBLADE",
        price = 2000,
        max = 4
    },
    {
        title = "AK47",
        itemName = "WEAPON_ASSAULTRIFLE",
        price = 11000,
        max = 1
    },
    {
        title = "Double Barrel Shotgun",
        itemName = "WEAPON_DBSHOTGUN",
        price = 3000,
        max = 10,
    },
    {
        title = "Draco",
        itemName = "WEAPON_COMPACTRIFLE",
        price = 10000,
        max = 2,
    },
    {
        title = "Tech-9",
        itemName = "WEAPON_MACHINEPISTOL",
        price = 5500,
        max = 5,
    },
    {
        title = "SMG",
        itemName = "WEAPON_SMG",
        price = 9000,
        max = 3,
    }
}, function (item) 
    item.price = exports.stem_common:fluctuatePrice(item.price, 1000)

    gunVanItemsByItemName[item.itemName] = item
    return item
end)
local serverStock = {}


function refreshGunVan()
    local location = locations[math.random(#locations)]

    TriggerClientEvent("stem_gunvan:clearProps", -1)
    if GunVan and DoesEntityExist(GunVan) then DeleteEntity(GunVan) end
    
    serverStock = {}

    GunVan = CreateVehicleServerSetter(
	    `speedo5`, 
		"automobile", 
        location.x,
        location.y,
        location.z,
        location.w
	);

    while not DoesEntityExist(GunVan) do
        Wait(100)
    end

    Entity(GunVan).state.GunVan = {
        position = location,
        rotation = GetEntityRotation(GunVan),
        items = gunVanItems
    }
end

lib.cron.new("0 * * * *", function (task, data) 
    refreshGunVan()
end)


ESX.RegisterServerCallback("stem_gunvan:purchaseWeapon", function (source, cb, weaponName, amount)
    local player = ESX.GetPlayerFromId(source)
    if (type(GunVan) ~= "number") then return error("invalid gun van") end
    
    if (exports.stem_common:getDistanceToCoord(player.source, GetEntityCoords(GunVan)) > 10) then
        player.showNotification("Invalid sale", "error")
        return TriggerEvent("stem_ac:player:sus", {
			source, 
			event = "esx:stem_gunvan:purchaseWeapon",
			reason = "Invalid sale conditions",
			metadata = {
                validSale = validSale,
                sellToPed = sellToPed,
			}
		})
    end 
    local gunVanItem = gunVanItemsByItemName[weaponName]
    local stockLeft = serverStock[weaponName] or gunVanItem.max
    if (amount > stockLeft) then
        return cb("no_stock", amount, stockLeft)
    end

    local totalPrice = gunVanItem.price * amount
    local accountMoney = player.getAccount("black_money").money
    if (accountMoney < totalPrice) then 
        return cb("no_funds", totalPrice, accountMoney)
    end

    if (not player.canSwapItem("black_money", totalPrice, weaponName, amount)) then
        return cb("no_space")
    end
    
    player.removeAccountMoney("black_money", totalPrice)
    player.addInventoryItem(weaponName, amount)
    serverStock[weaponName] = stockLeft - amount
    cb(true, totalPrice)
    
    
    Entity(GunVan).state.GunVan = {
        position = GetEntityCoords(GunVan),
        rotation = GetEntityRotation(GunVan),
        items = exports.stem_common:tableMap(gunVanItems, function (item) 
            if (item.itemName == weaponName) then
                item.stock = serverStock[weaponName]
            end
            return item
        end)
    }
    
    exports["stem_gangsystem"]:addToPlayerStatistics(player.identifier, {
        dirty_spent = totalPrice,
    })
end)

CreateThread(refreshGunVan)

AddEventHandler("onResourceStop", function (resourceName) 
    if (GetCurrentResourceName() == resourceName) then
        if (GunVan) then DeleteEntity(GunVan) end
    end
end)

function getGunVanLocation()
    return GetEntityCoords(GunVan)
end

exports("getGunVanLocation", getGunVanLocation)