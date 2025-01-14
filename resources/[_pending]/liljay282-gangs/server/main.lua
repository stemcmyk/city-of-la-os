ESX = exports['es_extended']:getSharedObject()

local function IsGangActive(name)
    local db = SQL.Execute('SELECT * FROM gangs WHERE name = ?', { name })
    return db[1]
end

function GetGangConfig(name)
    for key, gang in pairs(Config.Gangs) do
        if gang.Name == name then
            return gang
        end
    end
    return nil
end

local function GetMemberName(identifier)
    local db = SQL.Execute('SELECT * FROM users WHERE identifier = ?', { identifier })
    return db[1].firstname..' '..db[1].lastname
end

local function GetNewbieRank(name)
    local gangConfig = GetGangConfig(name)
    local newbieRank = gangConfig.Ranks[1]
    for key, rank in pairs(gangConfig.Ranks) do
        if rank.Rank < newbieRank.Rank then
            newbieRank = rank
        end
    end
    return newbieRank
end

local function GetPromoteRanks(name, rank)
    local gangConfig = GetGangConfig(name)
    local playerRank = nil
    local availableRanks = { }
    for key, cRank in pairs(gangConfig.Ranks) do
        if cRank.Name == rank then
            playerRank = cRank
        end
    end
    for key, cRank in pairs(gangConfig.Ranks) do
        if cRank.Rank > playerRank.Rank then
            table.insert(availableRanks, cRank)
        end
    end
    return availableRanks
end

local function GetDemoteRanks(name, rank)
    local gangConfig = GetGangConfig(name)
    local playerRank = nil
    local availableRanks = { }
    for key, cRank in pairs(gangConfig.Ranks) do
        if cRank.Name == rank then
            playerRank = cRank
        end
    end
    for key, cRank in pairs(gangConfig.Ranks) do
        if cRank.Rank < playerRank.Rank then
            table.insert(availableRanks, cRank)
        end
    end
    return availableRanks
end

function GetGangData(name)
    for key, gang in pairs(Config.Gangs) do
        if gang.Name == name then
            return gang
        end
    end
    return nil
end

function GetPlayerGang(source)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local gangsDB = SQL.Execute('SELECT * FROM gangs', { })
    local playerGang = nil
    for key, gang in pairs(gangsDB) do
        if gang.leader == esxPlayer.identifier then playerGang = gang end
        for key, member in pairs(json.decode(gang.members)) do
            if member.identifier == esxPlayer.identifier then
                playerGang = gang
            end
        end
    end
    return playerGang
end

local function GetGangZones(gang)
    local zonesDB = SQL.Execute('SELECT * FROM zones WHERE gang = ?', { gang })
    local gangZones = { }
    for key, zone in pairs(zonesDB) do
        table.insert(gangZones, zone.name)
    end
    return gangZones
end

function RequestGangUpdate(source)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    gang.members = json.decode(gang.members)
    for key, member in pairs(gang.members) do
        member.name = GetMemberName(member.identifier)
        member.promoteRanks = GetPromoteRanks(gang.name, member.rank)
        member.demoteRanks = GetDemoteRanks(gang.name, member.rank)
    end
    gang.zones = GetGangZones(gang.name)
    TriggerClientEvent('liljay282-gangs:updateGangData', source, gang)
end

local function GetAllGangs(playerGang)
    local gangsDB = SQL.Execute('SELECT * FROM gangs', { })
    local gangs = { }
    for key, gang in pairs(gangsDB) do
        if gang.name ~= playerGang then
            gang.label = GetGangData(gang.name).Label
            gang.members = json.decode(gang.members)
            for key, member in pairs(gang.members) do
                member.name = GetMemberName(member.identifier)
                member.promoteRanks = GetPromoteRanks(gang.name, member.rank)
                member.demoteRanks = GetDemoteRanks(gang.name, member.rank)
            end
            gang.label = GetGangConfig(gang.name).Label
            gang.zones = GetGangZones(gang.name)
            table.insert(gangs, gang)
        end
    end
    return gangs
end

ESX.RegisterServerCallback('liljay282-gangs:getData', function(source, cb)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    if not gang then cb(false, { }, { }) return end
    gang.members = json.decode(gang.members)
    for key, member in pairs(gang.members) do
        member.name = GetMemberName(member.identifier)
        member.promoteRanks = GetPromoteRanks(gang.name, member.rank)
        member.demoteRanks = GetDemoteRanks(gang.name, member.rank)
    end
    gang.label = GetGangConfig(gang.name).Label
    gang.zones = GetGangZones(gang.name)
    cb(true, gang, GetAllGangs(gang.name))
end)

ESX.RegisterServerCallback('liljay282-gangs:withdrawMoney', function(source, cb, amount)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    if gang.money >= tonumber(amount) then
        gang.money = gang.money - tonumber(amount)
        esxPlayer.addAccountMoney('black_money', tonumber(amount))
        SQL.Execute('UPDATE gangs SET money = ? WHERE name = ?', { gang.money, gang.name })
        cb(true)
        RequestGangUpdate(source)
    else
        cb(false)
    end
end)

local function GetMemberRank(identifier, name, gangConfig)
    local db = SQL.Execute('SELECT * FROM gangs WHERE name = ?', { name })[1]
    if db.leader == identifier then
        for key, rank in pairs(gangConfig.Ranks) do
            if rank.Name == gangConfig.LeaderRank then
                return rank
            end
        end
    else
        for key, member in pairs(json.decode(db.members)) do
            if member.identifier == identifier then
                for key, rank in pairs(gangConfig.Ranks) do
                    if rank.Name == member.rank then
                        return rank
                    end
                end
            end
        end
    end
    return nil
end

ESX.RegisterServerCallback('liljay282-gangs:getPlayerData', function(source, cb)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local jobData = { job = esxPlayer.job.label, grade = esxPlayer.job.grade_label }
    local playerGang = GetPlayerGang(source)
    if not playerGang then
        cb(nil, jobData)
        return
    else
        local gangConfig = GetGangConfig(playerGang.name)
        local gangData = { name = gangConfig.Label, rank = GetMemberRank(esxPlayer.identifier, playerGang.name, gangConfig).Label }
        cb(gangData, jobData)
        return
    end
end)

ESX.RegisterServerCallback('liljay282-gangs:depositMoney', function(source, cb, amount)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    if esxPlayer.getAccount('black_money').money >= tonumber(amount) then
        esxPlayer.removeAccountMoney('black_money', tonumber(amount))
        gang.money = gang.money + tonumber(amount)
        SQL.Execute('UPDATE gangs SET money = ? WHERE name = ?', { gang.money, gang.name })
        cb(true)
        RequestGangUpdate(source)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('liljay282-gangs:getPlayerName', function(source, cb, id)
    local target = ESX.GetPlayerFromId(id)
    cb(GetMemberName(target.identifier))
end)

ESX.RegisterServerCallback('liljay282-gangs:checkIfInGane', function(source, cb, id)
    local esxPlayer = ESX.GetPlayerFromId(source)
    local target = ESX.GetPlayerFromId(id)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    local members = json.decode(gang.members)
    local found = false
    for key, member in pairs(members) do
        if member.identifier == target.identifier then
            found = true
        end
    end
    cb(found)
end)

RegisterServerEvent('liljay282-gangs:recruitPlayer', function(player)
    local src = source
    local esxPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromId(player.Id)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    local members = json.decode(gang.members)
    table.insert(members, { identifier = target.identifier, rank = GetNewbieRank(gang.name).Name })
    SQL.Execute('UPDATE gangs SET members = ? WHERE name = ?', { json.encode(members), gang.name })
    RequestGangUpdate(src)
    TriggerClientEvent('liljay282-gangs:updateHud', -1)
end)

RegisterServerEvent('liljay282-gangs:promotePlayer', function(player, rank)
    local src = source
    local esxPlayer = ESX.GetPlayerFromId(src)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    local members = json.decode(gang.members)
    for key, member in pairs(members) do
        if member.identifier == player then
            member.rank = rank
        end
    end
    SQL.Execute('UPDATE gangs SET members = ? WHERE name = ?', { json.encode(members), gang.name })
    RequestGangUpdate(src)
    TriggerClientEvent('liljay282-gangs:updateHud', -1)
end)

RegisterServerEvent('liljay282-gangs:demotePlayer', function(player, rank)
    local src = source
    local esxPlayer = ESX.GetPlayerFromId(src)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    local members = json.decode(gang.members)
    for key, member in pairs(members) do
        if member.identifier == player then
            member.rank = rank
        end
    end
    SQL.Execute('UPDATE gangs SET members = ? WHERE name = ?', { json.encode(members), gang.name })
    RequestGangUpdate(src)
    TriggerClientEvent('liljay282-gangs:updateHud', -1)
end)

RegisterServerEvent('liljay282-gangs:kickPlayer', function(player)
    local src = source
    local esxPlayer = ESX.GetPlayerFromId(src)
    local gang = SQL.Execute('SELECT * FROM gangs WHERE leader = ?', { esxPlayer.identifier })[1]
    local members = json.decode(gang.members)
    for key, member in pairs(members) do
        if member.identifier == player.identifier then
            table.remove(members, key)
        end
    end
    SQL.Execute('UPDATE gangs SET members = ? WHERE name = ?', { json.encode(members), gang.name })
    RequestGangUpdate(src)
    TriggerClientEvent('liljay282-gangs:updateHud', -1)
end)

local DiscordWebhook = ''

function SendToDiscord(firstGang, secondGang)
    local embed = {
        {
            ['title'] = 'New gang war',
            ['description'] = ('gang %s has declared war against gang %s'):format(firstGang, secondGang)
        }
    }
    PerformHttpRequest(DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({
        username = 'Gang System', embeds = embed
    }), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterCommand('creategang', 'admin', function(player, args, showError)
    local isActive = IsGangActive(args.name)
    if isActive then return player.showNotification('This gang is already registered') end
    local gangConfig = GetGangConfig(args.name)
    if not gangConfig then return player.showNotification('Invalid gang name') end
    SQL.Execute('INSERT INTO gangs (name, leader, members, money) VALUES (?, ?, ?, ?)', { args.name, args.player.identifier, json.encode({ }), 0 })
    TriggerClientEvent('liljay282-gangs:updateHud', -1)
end, false, {help = 'Creates a gang for the specified player', validate = true, arguments = {
	{ name = 'player', help = 'Player Id', type = 'player' },
	{ name = 'name', help = 'Gang name', type = 'string' }
}})