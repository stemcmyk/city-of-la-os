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
---@param ... any Data to pass to the server
---@return ... Response from the server
function lib.await(eventName, ...)
    local promise = promise.new()
    local key = GetGameTimer()
    local data = {...}

    cache.events[key] = function (...)
        promise:resolve(...)
        cache.events[key] = nil
    end

    Citizen.CreateThread(function ()
        local startTime = GetGameTimer()
        while cache.events[key] ~= nil do
            if (GetGameTimer() - startTime) > 10000 then
                warn("[REAPER] [callback.await] [" .. eventName .. "] - Failed to receive response from the server")
                promise:resolve("RESPONSE_FAILED")
                break
            end 

            TriggerServerEvent(formatEvent(eventName), cache.resource, key, table.unpack(data))
            Citizen.Wait(2000)
        end
    end)

    if promise then
		return Citizen.Await(promise)
	end
end

---@param eventName string Event Name
---@param callback function Callback function when event is received
function lib.register(eventName, callback)
    RegisterNetEvent(formatEvent(eventName), function (resource, key, ...)
        TriggerServerEvent(formatEvent(resource), key, callback(...))
    end)
end

RegisterNetEvent(formatEvent(cache.resource), function (key, ...)
    if cache.events[key] then
        return cache.events[key](...)
    end
end)

return lib