
function filterDealership(data, k, v) 
    local filteredItems = {}
    for index, value in pairs(data) do
        if (value.type ~= "category" and value[k] == v) then
            table.insert(filteredItems, value)
        end
        if (value.items) then
            local newValue = {}
            for k,v in pairs(value) do newValue[k] = v end
            newValue.items = filterDealership(value.items, k, v)
            if (#newValue.items > 0) then
                table.insert(filteredItems, newValue)
            end
        end
    end

    return filteredItems
end

function flattenShop(shop, type, result, hash)
    for _, entry in pairs(shop) do
        if entry.type == "category" then
            if (entry.items) then
                flattenShop(entry.items, type, result, hash)
            end
        else
            if (#entry > 0) then
                flattenShop(entry, _, result, hash)
            else
                entry.type = type
                result[hash and GetHashKey(entry.model) or entry.model] = entry
            end
        end
    end
end

function flattenShopList(shop, hash)
    local result = {}
    flattenShop(shop, true, result, hash)
    return result
end