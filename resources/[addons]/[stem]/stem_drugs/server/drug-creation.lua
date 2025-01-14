local tables = {}
local zones = {}
local zoneUsage = {}

lib.addCommand({"giveuncut"}, {
	help = 'Gives an item to a player with the given id',
	restricted = 'group.admin',
}, function(source, args)
    exports.ox_inventory:AddItem(source, "cocaine_uncut", 10, {quality = 100})
end)


local coke_locations = {
    ["cayo"] = {
        tables = {
            {
                text = "Gather 1x Pure Uncut Cocaine",
                icon = "fas fa-credit-card",
                progress = {text = "Gathering 1x Pure Uncut Cocaine...", time = 15000},
                coords = {               
                    vector4(5212.96, -5130.94, 5.55 + 0.5, 181.42),
                    vector4(5212.73, -5128.27, 5.55 + 0.5, 2.13),
                    vector4(5212.48, -5125.81, 5.55 + 0.5, 184.26)
                },
                output = {
                    ["cocaine_uncut:99"] = 1
                },
            },
            {
                text = "Process 5x Pure Uncut Concaine",
                icon = "fas fa-credit-card",
                progress = {text = "Processing 5x Pure Uncut cocaine...", time = 26000},
                coords = {               
                    vector4(5216.76, -5127.17, 5.93, 184.15),
                },
                input = {
                    ["cocaine_uncut:99"] = 5
                },
                output = {
                    ["cocaine_cut:99"] = 1
                },
            },
            {
                text = "Package 1x Pure Cut Concaine",
                icon = "fas fa-gift",
                progress = {text = "Packaging 1x Pure Cut cocaine...", time = 26000},
                coords = {               
                    vector4(5216.82, -5129.5, 6.3, 6.84)
                },
                input = {
                    ["cocaine_cut:99"] = 1
                },
                output = {
                    ["cocaine_packaged:99"] = 1
                },
            },
        },
    },
    -- ["docks"] = {
    --     tables = {
    --         {
    --             text = "Gather 1x Uncut Cocaine",
    --             icon = "fas fa-credit-card",
    --             progress = {text = "Gathering 1x Uncut Cocaine...", time = 15000},
    --             coords = {               
    --                 vector4(-329.62, -2443.38, 7.16, 320.39),
    --                 vector4(-331.24, -2445.38, 7.16, 320.398),
    --                 vector4(-332.80, -2447.30, 7.16, 320.39)
    --             },
    --             output = {
    --                 ["cocaine_uncut:50"] = 1
    --             },
    --         },
    --         {
    --             text = "Process 5x Uncut Concaine",
    --             icon = "fas fa-credit-card",
    --             progress = {text = "Processing 5x Uncut cocaine...", time = 26000},
    --             coords = {               
    --                 vector4(-328.61, -2439.98, 7.16, 49.57),
    --                 vector4(-327.83, -2436.67, 7.16, 140.25)
    --             },
    --             input = {
    --                 ["cocaine_uncut:50"] = 5
    --             },
    --             output = {
    --                 ["cocaine_cut:50"] = 1
    --             },
    --         },
    --         {
    --             text = "Package 1x Cut Concaine",
    --             icon = "fas fa-gift",
    --             progress = {text = "Packaging 1x Cut cocaine...", time = 26000},
    --             coords = {               
    --                 vector4(-323.16, -2441.70, 7.09, 140.42)
    --             },
    --             input = {
    --                 ["cocaine_cut:50"] = 1
    --             },
    --             output = {
    --                 ["cocaine_packaged:50"] = 1
    --             },
    --         },
    --     },
    --     interior_coords = vector3(-331.41, -2445.34, 8.16),
    --     door_coords = vector4(-339.27, -2444.29, 7.3, 52.41),
    --     doorId = GetConvar("environment") == "production" and 263 or 189,
    --     time = {0200, 1400}
    -- },
    ["mesa"] = {
        tables = {
            {
                text = "Gather 1x Uncut Cocaine",
                icon = "fas fa-credit-card",
                progress = {text = "Gathering 1x Uncut Cocaine...", time = 15000},
                coords = {               
                    vector4(881.43, -1144.44, 26.0, 357.98),
                    vector4(881.42, -1141.7, 26.0, 178.25),
                    vector4(881.37, -1139.32, 26.0, 179.25)
                },
                output = {
                    ["cocaine_uncut:33"] = 1
                },
            },
            {
                text = "Process 5x Uncut Concaine",
                icon = "fas fa-credit-card",
                progress = {text = "Processing 5x Uncut cocaine...", time = 26000},
                coords = {               
                    vector4(880.19, -1133.99, 26, 84.78),
                },
                input = {
                    ["cocaine_uncut:33"] = 5
                },
                output = {
                    ["cocaine_cut:33"] = 1
                },
            },
            {
                text = "Package 1x Cut Concaine",
                icon = "fas fa-gift",
                progress = {text = "Packaging 1x Cut cocaine...", time = 26000},
                coords = {               
                    vector4(885.29, -1133.9, 26, 179.01)
                },
                input = {
                    ["cocaine_cut:33"] = 1
                },
                output = {
                    ["cocaine_packaged:33"] = 1
                },
            },
        },
        interior_coords = vector3(879.61, -1140.05, 26.04),
        door_coords = vector4(871.82, -1146.18, 25.99, 91.05),
        doorId = GetConvar("environment") == "production" and 262 or 188,
        time = {0001, 0000}
    },
    ["sandy"] = {
        tables = {
            {
                text = "Gather 1x Clean Uncut Cocaine",
                icon = "fas fa-credit-card",
                progress = {text = "Gathering 1x Clean Uncut Cocaine...", time = 15000},
                coords = {               
                    vector4(1535.23, 3584.4, 39.61 - 1, 302.95),
                },
                output = {
                    ["cocaine_uncut:66"] = 1
                },
            },
            {
                text = "Process 5x Clean Uncut Concaine",
                icon = "fas fa-credit-card",
                progress = {text = "Processing 5x Clean Uncut cocaine...", time = 26000},
                coords = {               
                    vector4(1533.41, 3587.94, 39.61 - 1, 124.11),
                },
                input = {
                    ["cocaine_uncut:66"] = 5
                },
                output = {
                    ["cocaine_cut:66"] = 1
                },
            },
            {
                text = "Package 1x Clean Cut Concaine",
                icon = "fas fa-gift",
                progress = {text = "Packaging 1x Clean Cut cocaine...", time = 26000},
                coords = {               
                    vector4(1533.41, 3587.94, 39.61 - 1, 124.11)
                },
                input = {
                    ["cocaine_cut:66"] = 1
                },
                output = {
                    ["cocaine_packaged:66"] = 1
                },
            },
        },
        time = {1930, 2330}
    },
    ["bestbuds"] = {
        tables = {
            {
                text = "Gather Cannabis",
                icon = "fas fa-cannabis",
                progress = {text = "Gathering Cannabis...", time = 15000},
                animation = {
                    scenario = "PROP_HUMAN_BUM_BIN",
                },
                scale = vector3(3, 6, 2),
                coords = {               
                    vector4(380.71, -812.35, 29.3, 89.54)
                },
                output = {
                    ["weed_untrimmed"] = 1
                },
                maxuse = 50
            },
            {
                text = "Roll Joint",
                icon = "fas fa-joint",
                progress = {text = "Rolling A joint...", time = 15000},
                animation = {
                    scenario = "PROP_HUMAN_BUM_BIN",
                },
                scale = vector3(2, 1, 2),
                coords = {               
                    vector3(382.48, -817.43, 30.16 - 1)
                },
                input = {
                    ["weed_untrimmed"] = 2
                },
                output = {
                    ["joint"] = 1
                },
                maxuse = 5
            },
        },
       
    },

    
}

function getZoneById(id) 
    for key, value in pairs(zones) do
        if (value.id == id) then
            return value
        end
    end
    return nil
end

RegisterNetEvent("stem_drugs:fetchZones", function () 
    if (#zones < 1) then
        zones = refreshZones()  
    end

    local serverHour = tonumber(os.date("%H%M"))
    for key, value in pairs(coke_locations) do
        if (value.time and not isTimeBetween(serverHour, value.time[1], value.time[2])) then
            TriggerClientEvent("stem_drugs:kickFromInterior", source, value.interior_coords, value.door_coords)
        end
    end

    TriggerClientEvent("stem_drugs:setupZones", source, zones)
end)

local zoneInUse = {}


RegisterNetEvent("playerDropped", function () 
    if (Player(source).state.drugProcess) then
        zoneInUse[Player(source).state.drugProcess.zone] = nil
    end
end)

function split(inputstr, sep)
    if sep == nil then
        sep = "%s"  -- Default to whitespace if no separator is provided
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function checkItems(player, input, output) 
    if(input) then
        for key, value in pairs(input) do
            local itemName = string.find(key, ":")
            if (not itemName) then
                if (not player.hasItem(itemName).count >= value) then
                    player.showNotification(("You do not have enough %s"):format(player.hasItem(itemName).label))
                    return false
                end
            end
            local itemName, itemQuality = split(key, ":")[1], split(key, ":")[2]
            local item = exports.ox_inventory:GetSlotWithItem(player.source, itemName, {
                quality = tonumber(itemQuality)
            }, true)
            if (not item) then 
                player.showNotification(("You do not have enough **%s** **%s**"):format("%"..itemQuality, player.hasItem(itemName).label))
                return false
            end
            if (item.count < value) then
                player.showNotification(("You do not have enough of **%s** **%s**"):format("%"..itemQuality, player.hasItem(itemName).label))
                return false
            end
        end 
    end
    if(output) then
        for key, value in pairs(output) do
            local itemName = string.find(key, ":") and split(key, ":")[1] or key
            if (not player.canCarryItem(itemName, value)) then
                player.showNotification(("You cannot carry more of %s"):format(player.hasItem(itemName).label))
                return false
            end
        end 
    end
    return true
end

RegisterNetEvent("stem_drugs:finishProcess", function (state)  
    local player = ESX.GetPlayerFromId(source)
    local process = Player(player.source).state.drugProcess
    if (not process) then return end;
    local zone = getZoneById(process.zoneId)
    if (not zone or not zoneInUse[process.zoneId]) then return end

    if (state) then
        if (GetGameTimer() < process.timeExpect) then
            return print("to early")
        end
        if (not checkItems(player, zone.input, zone.output)) then return end
        
        if(zone.input) then
            for key, value in pairs(zone.input) do
                local itemName, itemQuality = split(key, ":")[1], split(key, ":")[2]
                local item = exports.ox_inventory:GetSlotWithItem(player.source, itemName, {
                    quality = tonumber(itemQuality)
                }, true)
                
                exports.ox_inventory:RemoveItem(player.source, itemName, value, {quality = tonumber(itemQuality)}, item.slot)
            end
        end
        if(zone.output) then
            for key, value in pairs(zone.output) do
                local itemName, itemQuality = split(key, ":")[1], split(key, ":")[2]
                exports.ox_inventory:AddItem(player.source, itemName, value, {quality = tonumber(itemQuality)})
            end
        end
    end
    
    Player(player.source).state.drugProcess = nil
    zoneInUse[process.zoneId] = nil
    if (zone.maxuse) then
        if (not zoneUsage[process.zoneId]) then zoneUsage[process.zoneId] = 0 end
        zoneUsage[process.zoneId] = zoneUsage[process.zoneId] + 1
    end
end)

ESX.RegisterServerCallback("stem_drugs:beginProcess", function (source, cb, zoneId) 
    local player = ESX.GetPlayerFromId(source)
    local zone = getZoneById(zoneId)
    if (not zone) then return cb(false) end
    if (zoneInUse[zoneId]) then
        return player.showNotification("This table is alreay in use", "error")
    end
    local distance = exports.stem_common:getDistanceToCoord(player.source, zone.coords)
	if (distance >= 10)  then
		cb(false)
        return TriggerEvent("stem_ac:player:sus", {
			source = player.source, 
			event = "stem_drugs:beginProcess",
			reason = "Player was too far away from the process table.",
			metadata = {
				distance = distance
			}
		})
	end

    if (not checkItems(player, zone.input, zone.output)) then return cb(false) end
    
    if (zone.maxuse and zoneUsage[zoneId] and zoneUsage[zoneId] >= zone.maxuse) then
        return player.showNotification("This plantation has ran out of buds")
    end

    Player(source).state.drugProcess = {
        timeExpect = GetGameTimer() + zone.progress.time,
        zoneId = zoneId,
    }
    zoneInUse[zoneId] = source
    cb(true)
end)

function isTimeBetween(hour, startHour, endHour)
    hour = hour % 2400
    startHour = startHour % 2400
    endHour = endHour % 2400

    if endHour >= startHour then
        return hour >= startHour and hour < endHour
    else
        return hour >= startHour or hour < endHour
    end
end


function refreshZones () 
    zones = {}
    for locKey, loc in pairs(coke_locations) do
        local serverHour = tonumber(os.date("%H%M"))
        if (not loc.time or isTimeBetween(serverHour, loc.time[1], loc.time[2])) then
            if (loc.doorId and exports.ox_doorlock:getDoor(loc.doorId).state == 1) then
                exports.ox_doorlock:setDoorState(loc.doorId, false)
            end
            for tableId, tableItem in next, loc.tables do
                for key, coords in next, tableItem.coords do
                    local zoneId = ("%s:%s:%s"):format(locKey, tableId, key)
                    local tableId = ("%s:%s"):format(locKey, tableId)
                    table.insert (zones, {
                        coords = coords,
                        scale = tableItem.scale,
                        id = zoneId,
                        tableId =  tableId,
                        text = tableItem.text,
                        progress = tableItem.progress,
                        input = tableItem.input,
                        output = tableItem.output,
                        animation = tableItem.animation,
                        maxuse = tableItem.maxuse
                    })
                    if not tables[tableId] then
                        tables[tableId] = {
                            input = tableItem.input,
                            output = tableItem.output,
                            maxuse = tableItem.maxuse
                        }
                    end
                end
            end
        else
            if (loc.doorId and exports.ox_doorlock:getDoor(loc.doorId).state == 0) then
                TriggerClientEvent("stem_drugs:kickFromInterior", -1, loc.interior_coords, loc.door_coords)
                exports.ox_doorlock:setDoorState(loc.doorId, true)
            end
        end
    end 

    return zones
end

lib.cron.new("0 * * * *", function ()
    Citizen.Wait(5000)
    refreshZones() 
    TriggerClientEvent("stem_drugs:setupZones", -1, zones)
end)
