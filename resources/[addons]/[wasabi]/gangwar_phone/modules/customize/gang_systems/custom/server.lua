-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end

if Config.GangSystem ~= 'custom' then return end


local function initCustomGangs(tb)
    -- tb : array of gang names 
    if not tb then return end
    for i=1, #tb do
        local gangName = tb[i]
        local response = MySQL.insert.await('INSERT INTO `gangwar_gangs` (`gangName`) VALUES (?)', { gangName })
        if response then
            local result = MySQL.single.await('SELECT `id` FROM `gangwar_gangs` WHERE `gangName` = ?', { gangName })
            if result then
                if not Gangs or #Gangs < 1 then Gangs = {} end
                Gangs[#Gangs+1] = {
                    id = result.id,
                    gangName = gangName,
                    logo = false,
                    leaders = false,
                    bankAccount = 0,
                    wins = 0,
                    losses = 0
                }
                GlobalState.gangwar_gangs = Gangs
            end
        end
    end
    return true
end

function SyncGangSystem()
    -- Logic for syncing gang system on initial start-up and
    -- send missing gangs to initCustomGangs here
    --
    -- See 'modules/customize/gang_systems/qb' for example
end

function AddGangSystemMember(id, gangID)
    local player = wsb.getPlayerFromIdentifier(id)
    local foundGang
    for _,v in ipairs(Gangs) do
        if v.id == gangID then foundGang = v break end
    end
    if not foundGang then return end
    if not player then
        -- Updating players gang while offline here
        -- See 'modules/customize/gang_systems/qb' for example

        return true
    end

    -- Updating player's gang while online here
    -- See 'modules/customize/gang_systems/qb' for example
end

function RemoveGangSystemMember(id, gangID)
    local player = wsb.getPlayerFromIdentifier(id)
    if not player then
        -- Updating players gang while offline here
        -- See 'modules/customize/gang_systems/qb' for example

        return false
    end


    -- Updating player's gang while online here
    -- See 'modules/customize/gang_systems/qb' for example
end


RegisterNetEvent('CUSTOM_EVENT_FOR_GANG_UPDATE_HERE', function()
    -- Add listener event in this place
    -- See 'modules/customize/gang_systems/qb' for example

    -- See docs for all options
end)