local lib = {}

local cache = {
    resource = GetCurrentResourceName(),
    events = {}
}

---@param event string Event Name
local function formatEvent(event)
    return ("__reaper_cb_%s"):format(event)
end

---@param eventName string Event Name
---@param callback function Callback function when event is received
function lib.register(eventName, callback)
    RegisterNetEvent(formatEvent(eventName), function (resource, key, ...)
        local player = source
        TriggerClientEvent(formatEvent(resource), player, key, callback(source, ...))
    end)
end

---@param eventName string Event Name
---@param data any Data to pass to the server
---@param retry number|nil
---@param timeout number|nil
---@return ... Response from the server
function lib.await(eventName, source, data, retry, timeout)
    local promise = promise.new()
    local key = GetGameTimer()

    cache.events[key] = function (...)
        cache.events[key] = nil
        promise:resolve(...)
    end

    Citizen.CreateThread(function ()
        local startTime = GetGameTimer()
        while cache.events[key] ~= nil do
            if (GetGameTimer() - startTime) > (timeout or 10000) then
                warn("[REAPER] [callback.await] [" .. eventName .. "] - Failed to receive response from client (id:" .. source .. ")")
                promise:resolve("RESPONSE_FAILED")
                break
            end

            TriggerClientEvent(formatEvent(eventName), source, cache.resource, key, table.unpack(data))
            Citizen.Wait(retry or 2000)
        end
    end)

    if promise then
		return Citizen.Await(promise)
	end
end

RegisterNetEvent(formatEvent(cache.resource), function (key, ...)
    if cache.events[key] then
        return cache.events[key](...)
    end
end)

return lib