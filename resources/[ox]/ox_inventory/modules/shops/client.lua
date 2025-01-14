if not lib then return end

local ox_target = exports.ox_target

local shopTypes = {}
local shops = {}
local createBlip = require 'modules.utils.client'.CreateBlip

for shopType, shopData in pairs(lib.load('data.shops') --[[@as table<string, OxShop>]]) do
	local shop = {
		name = shopData.name,
		groups = shopData.groups or shopData.jobs,
		blip = shopData.blip,
		label = shopData.label,
        icon = shopData.icon,
		maxDistance = shopData.maxDistance
	}

	if shopData.models then shop.models = shopData.models end

	if shared.target then
		shop.model = shopData.model
		shop.targets = shopData.targets
	else
		shop.targets = shopData.targets
		shop.locations = shopData.locations
	end

	shopTypes[shopType] = shop
	local blip = shop.blip

	if blip then
		blip.name = ('ox_shop_%s'):format(shopType)
		AddTextEntry(blip.name, shop.name or shopType)
	end
end

---@param point CPoint
local function nearbyShop(point)
	---@diagnostic disable-next-line: param-type-mismatch
	DrawMarker(2, point.coords.x, point.coords.y, point.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 30, 150, 30, 222, false, false, 0, true, false, false, false)

	if point.isClosest and point.currentDistance < 1.2 and IsControlJustReleased(0, 38) then
		client.openInventory('shop', { id = point.invId, type = point.type })
	end
end

---@param point CPoint
local function onEnterShop(point)
	if not point.entity then
		local model = lib.requestModel(point.ped)

		if not model then return end

		local entity = CreatePed(0, model, point.coords.x, point.coords.y, point.coords.z, point.heading, false, true)

		if point.scenario then TaskStartScenarioInPlace(entity, point.scenario, 0, true) end

		SetModelAsNoLongerNeeded(model)
		FreezeEntityPosition(entity, true)
		SetEntityInvincible(entity, true)
		SetBlockingOfNonTemporaryEvents(entity, true)

		exports.ox_target:addLocalEntity(entity, {
            {
                icon = point.icon or 'fas fa-shopping-basket',
                label = point.label,
                groups = point.groups,
                onSelect = function()
                    client.openInventory('shop', { id = point.invId, type = point.type })
                end,
                iconColor = point.iconColor,
                distance = point.shopDistance or 2.0
            }
		})

		point.entity = entity
	end
end

local Utils = require 'modules.utils.client'

local function onExitShop(point)
	local entity = point.entity

	if not entity then return end

	exports.ox_target:removeLocalEntity(entity)
	Utils.DeleteEntity(entity)

	point.entity = nil
end

local function hasShopAccess(shop)
	return not shop.groups or client.hasGroup(shop.groups)
end

local function wipeShops()
	for i = 1, #shops do
		local shop = shops[i]

		if shop.zoneId then
            exports.ox_target:removeZone(shop.zoneId)
            shop.zoneId = nil
		end

		if shop.remove then
			if shop.entity then onExitShop(shop) end

			shop:remove()
		end

		if shop.blip then
			RemoveBlip(shop.blip)
		end
	end

	table.wipe(shops)
end

local tillProp = "prop_till_01"
function map(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(v)
    end
    return t
end


function getClosestStore(stores, coords)
	-- if current coords is better than last overwrite
	local nearestStore = nil
	local nearestLocationDistance = nil
	for key, location in pairs(stores) do
		local distanceBetweenCoordsAndStore = GetDistanceBetweenCoords(location.x, location.y, location.z, coords.x, coords.y, coords.z, true) 
		if (nearestStore == nil) then 
			nearestStore = key 
			nearestLocationDistance = distanceBetweenCoordsAndStore
		end
		if (distanceBetweenCoordsAndStore < nearestLocationDistance) then 
			nearestStore = key 
			nearestLocationDistance = distanceBetweenCoordsAndStore
		end
	end
	return nearestStore, nearestLocationDistance
end

local function refreshShops()
	wipeShops()

	local id = 0

	for type, shop in pairs(shopTypes) do
		local blip = shop.blip
		local label = shop.label or locale('open_label', shop.name)

		if (shop.models and shop.targets) then
			for key, model in pairs(shop.models) do
				for index, coords in ipairs(shop.locations) do
					createBlip(blip, coords)
				end


				ox_target:addGlobalObject({
					{
						name = "store:"..type,
						event = 'ox_inventory:open_store',
						icon = 'fa-solid fa-basket-shopping',
						label = "Open store",
						distance = 2,
						canInteract = function(entity, distance, coords, name, bone) 
							local nearestStoreIndex, nearestStoreDistance = getClosestStore(map(shop.targets, function (item) return item.loc end), coords)
							if (nearestStoreDistance > shop.targets[nearestStoreIndex].distance) then return false end
							if (GetEntityModel(entity) == model) then return true end 
							return false
						end,
						onSelect = function(data)
							local nearestStoreIndex, nearestStoreDistance = getClosestStore(map(shop.targets, function (item) return item.loc end), GetEntityCoords(PlayerPedId()))
							client.openInventory('shop', { type = type, id = nearestStoreIndex })
						end
					}
				})
			end
		end

		::skipLoop::
	end
end

return {
	refreshShops = refreshShops,
	wipeShops = wipeShops,
}
