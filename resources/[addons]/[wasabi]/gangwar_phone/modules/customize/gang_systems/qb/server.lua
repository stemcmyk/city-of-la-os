-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
if Config.CleanDatabase then return end
if not wsb then return print('^0[^3WARNING^0] wasabi_bridge was NOT started AFTER framework and/or BEFORE resource: '..GetCurrentResourceName()) end

local QBCore = wsb.getCore()
if not QBCore then return end
if Config.GangSystem ~= 'qb' or wsb.framework == 'esx' then return end

Companion = 'qb-gangs'

local function initQBGangs(tb)
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
    local players = MySQL.query.await('SELECT `citizenid`, `charinfo`, `gang` FROM `players`', {})
    if not players then return end
    local missingGangs = {}
    for gangName,_ in pairs(QBCore.Shared.Gangs) do
        local isFound = false
        if gangName ~= 'none' then
            if #Gangs > 0 then
                for i=1, #Gangs do
                    if gangName == Gangs[i].gangName then isFound = true break end
                end
                if not isFound then missingGangs[#missingGangs+1] = gangName end
            else
                missingGangs[#missingGangs+1] = gangName
            end
        end
    end
    local qbGangsInitilized
    if #missingGangs > 0 then qbGangsInitilized = initQBGangs(missingGangs) else qbGangsInitilized = true end
    while not qbGangsInitilized do Wait(0) end -- Possibly remove with testing or promise lua function
    for _, player in ipairs(players) do
        local citizenid = player.citizenid
        local playerGang = json.decode(player.gang)
        if playerGang.name ~= 'none' then
            if playerGang.isboss then
                for _, gang in ipairs(Gangs) do
                    if gang.gangName == playerGang.name then
                        if not gang.leaders then gang.leaders = {} end
                        if #gang.leaders > 0 then
                            local found
                            for i=1, #gang.leaders do
                                if gang.leaders[i].id == citizenid then found = true break end
                            end
                            if not found then
                                gang.leaders[#gang.leaders+1] = {
                                    id = citizenid,
                                    name = json.decode(player.charinfo).firstname .. ' ' .. json.decode(player.charinfo).lastname
                                }
                            end
                        else
                            gang.leaders[#gang.leaders+1] = {
                                id = citizenid,
                                name = json.decode(player.charinfo).firstname .. ' ' .. json.decode(player.charinfo).lastname
                            }
                        end
                        MySQL.update.await('UPDATE `gangwar_gangs` SET `leaders` = ? WHERE `id` = ?', {json.encode(gang.leaders), gang.id})
                        break
                    end
                end
            end
            local foundPlayer = false
            for _, ply in ipairs(Players) do
                if ply.id == citizenid then
                    foundPlayer = ply
                    break
                end
            end
            if not foundPlayer then
                local correspondingGangID = nil
                for _, g in ipairs(Gangs) do
                    if g.gangName == playerGang.name then
                        correspondingGangID = g.id
                        break
                    end
                end
                if correspondingGangID then
                    Players[#Players+1] = {
                        id = citizenid,
                        playerName = json.decode(player.charinfo).firstname .. ' ' .. json.decode(player.charinfo).lastname,
                        gangID = correspondingGangID,
                        kills = 0,
                        deaths = 0
                    }
                    MySQL.insert.await('INSERT INTO `gangwar_players` (`identifier`, `playerName`, `gangID`, `kills`, `deaths`) VALUES (?, ?, ?, 0, 0)', {citizenid, json.decode(player.charinfo).firstname .. ' ' .. json.decode(player.charinfo).lastname, correspondingGangID})  
                end
            elseif foundPlayer and playerGang.name ~= 'none' then
                local correspondingGangID = nil
                for _, g in ipairs(Gangs) do
                    if g.gangName == playerGang.name then
                        correspondingGangID = g.id
                        break
                    end
                end
                if correspondingGangID and (foundPlayer.gangID ~= correspondingGangID) then
                    foundPlayer.gangID = correspondingGangID
                    MySQL.update.await('UPDATE `gangwar_players` SET `gangID` = ? WHERE `identifier` = ?', {correspondingGangID, citizenid})
                end
            end
            GlobalState.gangwar_players = Players
        end
    end
end

function AddGangSystemMember(id, gangID)
    local player = wsb.getPlayerFromIdentifier(id)
    local foundGang
    for _,v in ipairs(Gangs) do
        if v.id == gangID then foundGang = v break end
    end
    if not foundGang then return end
    if not player then
        local QBGangs = QBCore.Shared.Gangs
        local gangTable = {
            label = QBGangs[foundGang.gangName].label,
            name = foundGang.gangName,
            isboss = false,
            grade = {
                level = 0,
                name = QBGangs[foundGang.gangName].grades[0].name
            }
        }
        MySQL.update.await('UPDATE `players` SET `gang` = ? WHERE `citizenid` = ?', { json.encode(gangTable), id })
        return true
    end
    player.Functions.SetGang(foundGang.gangName)
    return true
end

function RemoveGangSystemMember(id, _gangID)
    local player = wsb.getPlayerFromIdentifier(id)
    if not player then
        local update = MySQL.update.await('UPDATE `players` SET `gang` = ? WHERE `citizenid` = ?', { json.encode({label = 'No Gang', name = 'none', isboss = false, grade = {level = 0, name = 'Unaffiliated'}}), id })
        if update then return true end
        return false
    end
    player.Functions.SetGang('none')
end

RegisterNetEvent('QBCore:Server:OnGangUpdate', function(source, gang)
    local identifier = wsb.getIdentifier(source)
    if not identifier then return end
    local foundGang
    if Gangs and #Gangs > 0 then
        for _,v in ipairs(Gangs) do
            if v.gangName == gang.name then foundGang = v break end
        end
    end
    if not foundGang and gang.name ~= 'none' then
        return print('^0[^3WARNING^0] Detected player change to a gang name not in initial load, please restart script '..GetCurrentResourceName())
    end
    local foundPlayer
    if Players and #Players > 0 then
        for _,v in ipairs(Players) do
            if v.id == identifier then foundPlayer = v break end
        end
    end
    if gang.name == 'none' then
        if foundPlayer then RemoveGangMember(identifier, true) end
        return
    end
    if not foundPlayer then
        foundPlayer = {
            id = identifier,
            playerName = wsb.getName(source),
            gangID = foundGang.id,
            kills = 0,
            deaths = 0
        }
        MySQL.insert.await('INSERT INTO `gangwar_players` (`identifier`, `playerName`, `gangID`, `kills`, `deaths`) VALUES (?, ?, ?, 0, 0)', {identifier, foundPlayer.playerName, foundGang.id})
    end
    if foundGang.id == foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundGang.id)
        if wasLeader and not gang.isboss then
            RemoveGangLeader(identifier, foundGang.id)
        elseif gang.isboss and not wasLeader then
            AddGangLeader(identifier, foundGang.id)
        end
    elseif foundGang.id ~= foundPlayer.gangID then
        local wasLeader = IsGangLeader(identifier, foundPlayer.gangID)
        if wasLeader then RemoveGangLeader(identifier, foundPlayer.gangID) end
        if gang.isboss then
            AddGangLeader(identifier, foundGang.id)
        end
    end
    AddGangMember(foundPlayer, foundGang.id, true)
end)