-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end
if Config.GangSystem ~= 'esx' or wsb.framework == 'qb' then return end
Companion = 'esx_gangs'
local esxGangCache = {}

local function initESXGangs(tb)
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
            end
        end
    end
    return true
end

function SyncGangSystem()
    local players = MySQL.query.await('SELECT `identifier`, `firstname`, `lastname`, `gang`, `gang_rank` FROM `users`', {})
    local esx_gangs = MySQL.Sync.fetchAll('SELECT * FROM gangs', {})
    local gangs
    if not players or not esx_gangs then return end
    local missingGangs = {}
    for i=1, #esx_gangs do
        local gang = esx_gangs[i]
        if not gangs then gangs = {} end
        gangs[gang.name] = {name = gang.name, leaderRank = gang.leadership_rank}
    end
    if not gangs then return end
    esxGangCache = gangs
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
    local esxGangsInitialized
    if #missingGangs > 0 then esxGangsInitialized = initESXGangs(missingGangs) else esxGangsInitialized = true end
    while not esxGangsInitialized do Wait(0) end
    for _, player in ipairs(players) do
        local identifier = player.identifier
        if player.gang then
            local playerGang = {name = player.gang, rank = (player.gang_rank or 0)}
            local bossRank = gangs[player.gang].leaderRank
            if playerGang.rank >= bossRank then
                for _,gang in ipairs(Gangs) do
                    if gang.gangName == playerGang.name then
                        if not gang.leaders then gang.leaders = {} end
                        if #gang.leaders > 0 then
                            local found
                            for i=1, #gang.leaders do
                                if gang.leaders[i].id == identifier then found = true break end
                            end
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
            local foundPlayer = false
            for _, ply in ipairs(Players) do
                if ply.id == identifier then
                    foundPlayer = ply
                    break
                end
            end
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
    local foundGang
    for _,v in ipairs(Gangs) do
        if v.id == gangID then foundGang = v break end
    end
    if not foundGang then return end
    TriggerEvent('esx_gangs:server:InvitePlayer', id, foundGang.gangName)
end

function RemoveGangSystemMember(id, _gangID)
    if not id then return end
    TriggerEvent('esx_gangs:server:KickPlayer', id)
end

RegisterNetEvent('esx_gangs:server:OnGangUpdate', function(gang)
    local src = source
    local identifier = wsb.getIdentifier(src)
    local foundGang
    local foundPlayer
    if Players and #Players > 0 then
        for _,v in ipairs(Players) do
            if v.id == identifier then foundPlayer = v break end
        end
    end
    if not gang.name then
        if foundPlayer then RemoveGangMember(identifier, true) end
        return
    end
    if Gangs and #Gangs > 0 then
        for _,v in ipairs(Gangs) do
            if v.gangName == gang.name then foundGang = v break end
        end
    end
    if not foundGang then
        return print('^0[^3WARNING^0] Detected player change to a gang name not in initial load, please restart script '..GetCurrentResourceName())
    end
    if not foundPlayer then
        foundPlayer = {
            id = identifier,
            playerName = wsb.getName(src),
            gangID = foundGang.id,
            kills = 0,
            deaths = 0
        }
        MySQL.insert.await('INSERT INTO `gangwar_players` (`identifier`, `playerName`, `gangID`, `kills`, `deaths`) VALUES (?, ?, ?, 0, 0)', {identifier, foundPlayer.playerName, foundGang.id})
    end
    if foundGang.id == foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundGang.id)
        if wasLeader and gang.rank < esxGangCache[gang.name].leaderRank then
            RemoveGangLeader(identifier, foundGang.id)
        elseif (gang.rank >= esxGangCache[gang.name].leaderRank) and not wasLeader then
            AddGangMember(foundPlayer, foundGang.id, true)
            AddGangLeader(identifier, foundGang.id)
            return
        end
    elseif foundGang.id ~= foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundPlayer.gangID)
        if wasLeader then RemoveGangLeader(identifier, foundPlayer.gangID) end
        if gang.rank >= esxGangCache[gang.name].leaderRank then
            AddGangLeader(identifier, foundGang.id)
        end
    end
    AddGangMember(foundPlayer, foundGang.id, true)
end)