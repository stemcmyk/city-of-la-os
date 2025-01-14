local lib = {}

--- Converts a string to a hash if needed
---@param hash string|number The hash or model name to convert
---@return number hash The converted hash value
function lib.ch(hash)
    if type(hash) == 'string' then return GetHashKey(hash) end
    return hash
end

--- Converts 1->true,0->false,else->false
---@param value number|boolean
---@return ... 
function lib.cv(value)
    if value == 1 then value = true elseif value == 0 then value = false end
    return value
end

return lib