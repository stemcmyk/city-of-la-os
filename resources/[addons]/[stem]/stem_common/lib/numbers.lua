function formatPrice(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
  
    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

exports("formatPrice", formatPrice)


function getDistanceToCoord(source, coords) 
	local playerCoords = GetEntityCoords(GetPlayerPed(source))
	return #(playerCoords - vec3(coords.x, coords.y, coords.z)) -- Weird workaround
end

exports("getDistanceToCoord", getDistanceToCoord)


function fluctuatePrice(current, minMax)
    local add = math.random(minMax) - (minMax / 2) 
    return current + add
end

exports("fluctuatePrice", fluctuatePrice)