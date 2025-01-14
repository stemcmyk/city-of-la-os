SQL = {}

SQL.Execute = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    if string.find(query, "INSERT") then
        if cb then
            exports.oxmysql:insert(query, parameters, function(result) cb(result) end)
        else
            res = exports.oxmysql:insert_async(query, parameters)
            IsBusy = false
        end
    elseif string.find(query, "UPDATE") then
        if cb then
            exports.oxmysql:update(query, parameters, function(result) cb(result) end)
        else
            res = exports.oxmysql:update_async(query, parameters)
            IsBusy = false
        end
    elseif string.find(query, "SELECT") then
        if cb then
            exports.oxmysql:query(query, parameters, function(result) cb(result) end)
        else
            res = exports.oxmysql:query_async(query, parameters)
            IsBusy = false
        end
    else
        if cb then
            exports.oxmysql:query(query, parameters, function(result) cb(result) end)
        else
            res = exports.oxmysql:query_async(query, parameters)
            IsBusy = false
        end
    end
    while IsBusy do Citizen.Wait(0) end
    return res
end