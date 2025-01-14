-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end
if Config.GangSystem ~= 'rcore' then return end
local rcoreGangCache = {}
Companion = 'rcore_gangs'

local function initRcoreGangs(tb)
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
                    losses = 0,
                    deleted = false
                }
                GlobalState.gangwar_gangs = Gangs
                if #tb == 1 then
                    return result.id
                end
            end
        end
    end
    return true
end

function SyncGangSystem()

    local players, gangs = {}, {}

    local rcoreGangs = MySQL.query.await('SELECT `id`, `identifier`, `name` FROM `gangs`', {})
    if not rcoreGangs then return end

    local missingGangs = {}
    for i=1, #rcoreGangs do
        local gang = rcoreGangs[i]
        if not gangs then gangs = {} end
        gangs[gang.name] = {name = gang.name, id = gang.id, leaderID = gang.identifier}
    end

    if not gangs then return end

    rcoreGangCache = gangs

    for gangName,_ in pairs(gangs) do
        local isFound = false
        if #Gangs > 0 then
            for i=1, #Gangs do
                if gangName == Gangs[i].gangName then isFound = true break end
            end
            if not isFound then missingGangs[#missingGangs+1] = gangName end
        else
            missingGangs[#missingGangs+1] = gangName
        end
    end

    if wsb.framework == 'qb' then

        local qbPlayers = MySQL.query.await('SELECT `citizenid`, `charinfo`, `ganginfo` FROM `players`', {})

        if not qbPlayers then return end

        for i=1, #qbPlayers do
            local qbPlayer = qbPlayers[i]

            if qbPlayer.ganginfo then

                local gangInfo = json.decode(qbPlayer.ganginfo)
                local gangID = gangInfo.id
                local foundGangName
                local leaderID

                for gangName,data in pairs(gangs) do
                    if data.id == gangID then
                        foundGangName = gangName
                        leaderID = data.leaderID
                    end
                    if foundGangName then break end
                end

                local firstname = json.decode(qbPlayers[i].charinfo).firstname
                local lastname = json.decode(qbPlayers[i].charinfo).lastname

                players[#players+1] = {
                    identifier = qbPlayers[i].citizenid,
                    firstname = firstname,
                    lastname = lastname,
                    gang = foundGangName,
                    leader = (leaderID == qbPlayers[i].citizenid)
                }

            end
        end
    elseif wsb.framework == 'esx' then
        local esxPlayers = MySQL.query.await('SELECT `identifier`, `firstname`, `lastname`, `gangInfo` FROM `users`', {})
        if not esxPlayers then return end
        for i=1, #esxPlayers do
            local esxPlayer = esxPlayers[i]
            if esxPlayer.ganginfo then
                local gangInfo = json.decode(esxPlayer.ganginfo)
                local gangID = gangInfo.id
                local foundGangName
                local leaderID
                for gangName,data in pairs(gangs) do
                    if data.id == gangID then
                        foundGangName = gangName
                        leaderID = data.leaderID
                    end
                    if foundGangName then break end
                end
                players[#players+1] = {
                    identifier = esxPlayers[i].identifier,
                    firstname = esxPlayers[i].firstname,
                    lastname = esxPlayers[i].lastname,
                    gang = foundGangName,
                    leader = (leaderID == esxPlayers[i].identifier)
                }
            end
        end
    end
    local rcoreGangsInitilized
    if #missingGangs > 0 then rcoreGangsInitilized = initRcoreGangs(missingGangs) else rcoreGangsInitilized = true end
    while not rcoreGangsInitilized do Wait(0) end
    for _, player in ipairs(players) do
        local identifier = player.identifier
        if player.gang then
            local playerGang = {name = player.gang, leader = player.leader}
            if playerGang.leader then
                for _,gang in ipairs(Gangs) do
                    if gang.gangName == playerGang.name then
                        if not gang.leaders then gang.leaders = {} end
                        if #gang.leaders > 0 then
                            local found = IsGangLeader(identifier, gang.id)
                            if not found then
                                gang.leaders[#gang.leaders+1] = {
                                    id = identifier,
                                    name = player.firstname..' '..player.lastname
                                }
                            end
                        else
                            gang.leaders[#gang.leaders+1] = {
                                id = identifier,
                                name = player.firstname..' '..player.lastname
                            }
                        end
                        MySQL.update.await('UPDATE `gangwar_gangs` SET `leaders` = ? WHERE `id` = ?', {json.encode(gang.leaders), gang.id})
                        break

                    end
                end
            end
            local foundPlayer = GetGangMember(identifier)
            if not foundPlayer then
                local correspondingGangID = nil
                for _,g in ipairs(Gangs) do
                    if g.gangName == playerGang.name then
                        correspondingGangID = g.id
                        break
                    end
                end
                if correspondingGangID then
                    Players[#Players+1] = {
                        id = identifier,
                        playerName = player.firstname..' '..player.lastname,
                        gangID = correspondingGangID,
                        kills = 0,
                        deaths = 0
                    }
                    MySQL.insert.await('INSERT INTO `gangwar_players` (`identifier`, `playerName`, `gangID`, `kills`, `deaths`) VALUES (?, ?, ?, 0, 0)', {identifier, player.firstname .. ' ' .. player.lastname, correspondingGangID})
                end
            else
                local correspondingGangID = nil
                for _,g in ipairs(Gangs) do
                    if g.gangName == playerGang.name then
                        correspondingGangID = g.id
                        break
                    end
                end
                if correspondingGangID and (foundPlayer.gangID ~= correspondingGangID) then
                    foundPlayer.gangID = correspondingGangID
                    MySQL.update.await('UPDATE `gangwar_players` SET `gangID` = ? WHERE `identifier` = ?', {correspondingGangID, identifier})
                end
            end
            GlobalState.gangwar_players = Players
        end
    end
end

function AddGangSystemMember(id, gangID)
    local gangInfo = GetGangByID(gangID)
    if not gangInfo then return end
    exports['rcore_gangs']:AddMember(id, gangInfo.gangName)
end

function RemoveGangSystemMember(id, gangID)
    local gangInfo = GetGangByID(gangID)
    if not gangInfo then return end
    exports['rcore_gangs']:KickMember(id, gangInfo.gangName)
end

RegisterNetEvent('rcore_gangs:server:onGangUpdate', function(gang)
    local src = source
    local identifier = wsb.getIdentifier(src)
    local foundPlayer = GetGangMember(identifier) or {}
    if not gang.name then
        if foundPlayer then RemoveGangMember(identifier, true) end
        return
    end
    local foundGang = GetGangByName(gang.name) or {}
    if not foundGang or not next(foundGang) then
        local gangID = initRcoreGangs({gang.name})
        if gangID then
            foundGang = {id = gangID}
            rcoreGangCache[gang.name] = {}
            rcoreGangCache[gang.name].leaderID = identifier
        end
    end
    if not foundGang then
        return print('^0[^3WARNING^0] New gang: '..gang.name..' was not properly synced, please restart script '..GetCurrentResourceName())
    end
    if not foundPlayer or not next(foundPlayer) then
        foundPlayer = {
            id = identifier,
            playerName = wsb.getName(src),
            gangID = foundGang.id,
            kills = 0,
            deaths = 0
        }
        MySQL.insert.await('INSERT INTO `gangwar_players` (`identifier`, `playerName`, `gangID`, `kills`, `deaths`) VALUES (?, ?, ?, 0, 0)', {identifier, foundPlayer.playerName, foundGang.id})
        Players[#Players+1] = foundPlayer
        GlobalState.gangwar_players = Players
    end
    if foundGang.id == foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundGang.id)
        if wasLeader and identifier ~= rcoreGangCache[gang.name].leaderID then
            RemoveGangLeader(identifier, foundGang.id)
        elseif identifier == rcoreGangCache[gang.name].leaderID and not wasLeader then
            AddGangMember(foundPlayer, foundGang.id, true)
            AddGangLeader(identifier, foundGang.id)
            return
        end
    elseif foundGang.id ~= foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundPlayer.gangID)
        if wasLeader then RemoveGangLeader(identifier, foundPlayer.gangID) end
        if identifier == rcoreGangCache[gang.name].leaderID then
            AddGangLeader(identifier, foundGang.id)
        end
    end
    AddGangMember(foundPlayer, foundGang.id, true)
end)