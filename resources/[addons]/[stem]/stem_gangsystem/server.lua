GlobalState.MinGangwarPrice = 5000

function daysSinceTimestamp(timestamp)
    local current_time_seconds = os.time()
    local difference_seconds = current_time_seconds - (timestamp / 1000)
    local days_difference = difference_seconds / (24 * 60 * 60) 
    return days_difference
end

function getJobData(jobName, grade, cb) 
    MySQL.Async.fetchSingle("SELECT type, skin_male, skin_female, job_name, label, grade FROM job_grades WHERE job_name = @jobName AND grade = @grade", {
        ["@jobName"] = jobName,
        ["@grade"] = grade
    }, function (result) 
        MySQL.Async.fetchSingle("SELECT label FROM jobs WHERE name = @jobName", {
            ["@jobName"] = jobName,
        }, function (jobResult)
            if (not jobResult) then cb(nil) end
            result.job_label = jobResult.label
            cb(result)
        end)
    end)
end

function fetchPlayer(playerIdentifier, cb)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then 
        return cb({
            job = player.job.name,
            name = player.name,
            last_seen = "Currently Online"
        }) 
    end
    MySQL.Async.fetchSingle("SELECT job, firstname, lastname, last_seen FROM users WHERE identifier = @player", {
        ["@player"] = playerIdentifier
    } ,function (result) 
        if (not result) then return nil end;
        return cb({
            job = result.job,
            name = result.firstname .. " " .. result.lastname,
            last_seen = daysSinceTimestamp(result.last_seen)
        })
    end)
end 

function fetchGangMember(playerIdentifier, cb)
    MySQL.Async.fetchSingle("SELECT gang, grade FROM stem_gangmembers WHERE player = @player", {
        ["@player"] = playerIdentifier,
    }, function (gangMemberResult) 
        cb(gangMemberResult)
    end)
end
exports("fetchGangMember", fetchGangMember)

function isMemberInAnyGang(playerIdentifier, cb)
    MySQL.Async.fetchSingle("SELECT grade FROM stem_gangmembers WHERE player = @player", {
        ["@player"] = playerIdentifier,
    }, function (gangMemberResult) 
        cb(not not gangMemberResult)
    end)
end

function populateMemberWithGangData(gang, data, cb)
    fetchPlayer(data.player, function (playerData) 
        if (not playerData) then return nil end;
        getJobData(gang, data.grade, function (result) 
            if (not result) then return nil end;
            cb({
                player = data.player,
                name = playerData.name,
                last_seen = playerData.last_seen,
                job_grade = data.grade,
                job_label = result.label,
                stats = data.stats and json.decode(data.stats) or nil
            })
        end)
    end)
end

function removeGangMember(playerIdentifier, roleId)
    local player = ESX.GetPlayerFromIdentifier(playerIdentifier)
    if (player) then
        player.setJob("unemployed", 0)
        local appearance = exports["illenium-appearance"]:GetAppearance(player.identifier)
        TriggerClientEvent("skinchanger:loadClothes", player.source, appearance, {
            tshirt_1 = 0,
            tshirt_2 = 0
        })
        
        exports.stem_discord:getUserDiscord(player.source, function (discordId) 
            exports.stem_discord:setRole(discordId, roleId, true)
        end)
        player.showNotification("You have been kicked from your gang", "error")
        return
    end
    MySQL.update.await("UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?", {
        "unemployed", 0, playerIdentifier
    })
    local user = MySQL.single.await("SELECT discord_ids FROM users WHERE identifier = ?", {playerIdentifier})
    if (not user or not user.discord_ids) then return end
    local discordIds = json.decode(user.discord_ids)
    if (not discordIds or #discordIds < 1) then return end
    for key, value in pairs(discordIds) do
        exports.stem_discord:setRole(value, roleId, false)
    end
end

---@class stats
---@type table

--- func desc
---@param playerIdentifier string
---@param data stats
function addToPlayerStatistics(playerIdentifier, data) 
    isMemberInAnyGang(playerIdentifier, function (isInGang) 
        if (not isInGang) then return end;
        MySQL.Async.fetchSingle("SELECT stats, gang FROM stem_gangmembers WHERE player = @identifier", {
            ["@identifier"] = playerIdentifier
        }, function (result)
            if (not result) then return print("fuck") end;
            local stats = json.decode(result.stats)
            if (not stats or type(stats) == "string") then stats = {} end
            for key, value in pairs(data) do
                if (not stats[key]) then
                    stats[key] = value
                else
                    stats[key] = stats[key] + value
                end
            end
            MySQL.Async.execute("UPDATE stem_gangmembers SET stats = @stats WHERE player = @identifier AND gang = @gang", {
                ["@stats"] = json.encode(stats),
                ["@identifier"] = playerIdentifier,
                ["@gang"] = result.gang
            })
        end)
    end)
end
exports("addToPlayerStatistics", addToPlayerStatistics)

RegisterNetEvent("stem_gangsystem:kickMember", function (modifyPlayer) 
    local player = ESX.GetPlayerFromId(source)
    
    fetchGangMember(modifyPlayer, function (gangMemberResult) 
        if (not gangMemberResult) then return player.showNotification("This player is not in your gang", "error") end;
        fetchPlayer(modifyPlayer, function (result) 
            local queries = {}
            if (not result) then return player.showNotification("This player does not exist", "error") end
            if (player.job.grade <= 2) then return player.showNotification("You are not a executive", "error") end
            if (player.job.grade > gangMemberResult.grade) then
                MySQL.Async.execute("DELETE FROM stem_gangmembers WHERE player = @player AND gang = @gang", {
                    ["@player"] = modifyPlayer,
                    ["@gang"] = player.job.name
                }, function (deleteResult) 
                    if (not deleteResult) then player.showNotification("Unable to kick player", "error") end
                    removeGangMember(modifyPlayer, ESX.Jobs[gangMemberResult.gang].grades[tostring(gangMemberResult.grade)].discordId)
                    player.showNotification("Kicked "..result.name.." from gang.", "success") 
                end)
            end
        end)
    end)
end)

RegisterNetEvent("stem_gangsystem:modifyMember", function (modifyPlayer, modifyData) 
    local player = ESX.GetPlayerFromId(source)
    
    fetchGangMember(modifyPlayer, function (gangMemberResult) 
        if (not gangMemberResult) then return player.showNotification("This player is not in your gang", "error") end;
        fetchPlayer(modifyPlayer, function (result) 
            local queries = {}
            if (not result) then return player.showNotification("This player does not exist", "error") end
            if (player.job.grade > gangMemberResult.grade) then
                if (modifyData.grade) then
                    if (player.job.grade <= modifyData.grade) then
                        return player.showNotification("You are not high enough rank to promote this player", "error")
                    end

                    table.insert(queries, {
                        query = "UPDATE stem_gangmembers SET `grade` = @newGrade WHERE player = @player",
                        parameters = {
                            ["@newGrade"] = modifyData.grade,
                            ["@player"] = modifyPlayer,
                        }
                    })
                end
            end
    
            if (#queries > 0) then 
                MySQL.transaction(queries)
                local toPlayer = ESX.GetPlayerFromIdentifier(modifyPlayer)
                if (toPlayer) then toPlayer.setJob(player.job.name, modifyData.grade) end
                return player.showNotification("Successfully updated player", "success")
            end

            player.showNotification("Unable to update player", "error")
        end)
    end)
end)

RegisterNetEvent("stem_gangsystem:respondToInvite", function (response) 
    local player = ESX.GetPlayerFromId(source)
    if (not Player(player.source).state.gangInvite) then
        return player.showNotification("You do not have a outstanding invite available.")
    end
    local from, gang = table.unpack(Player(player.source).state.gangInvite)
    
    local fromPlayer = ESX.GetPlayerFromId(from)
    if (fromPlayer.job.name ~= gang) then
        player.showNotification("The invite from "..gang.." returned invalid")
        fromPlayer.showNotification("The invite sent to "..player.name.." returned invalid") 
        return
    end 
    
    
    MySQL.Async.fetchSingle("SELECT label, name FROM jobs WHERE name = @gangName", {
        ["@gangName"] = fromPlayer.job.name
    }, function (gangResult) 
        MySQL.Async.execute("INSERT INTO stem_gangmembers (player, gang, grade) VALUES (?, ?, ?)", {
            player.identifier, gang, 0
        }, function (result) 
            if (result) then
                local job = ESX.Jobs[fromPlayer.job.name].grades["0"]
                player.showNotification("You have joined "..gangResult.label.."!", "success", 30000)
                fromPlayer.showNotification(player.name.." has joined "..gangResult.label.." as a Recruit!")
                player.setJob(gang, 0)
                exports.stem_discord:getUserDiscord(player.source, function (discordId) 
                    exports.stem_discord:setRole(discordId, job.discordId, true)
                end)
                return 
            end
            player.showNotification("You have declined the invite", "error", 30000)
            fromPlayer.showNotification(player.name.." has declined the invite from "..gangResult.label..".", "error") 
        end)
    end)
end)

ESX.RegisterServerCallback("stem_gangsystem:sendInvite", function(source, cb, playerId) 
    local fromPlayer = ESX.GetPlayerFromId(source)
    local toPlayer = ESX.GetPlayerFromId(playerId)

    if (not fromPlayer.job.name or fromPlayer.job.grade <= 2) then
        return fromPlayer.showNotification("You do not have high enough rank to invite players", "error")
    end 
    if (not toPlayer) then
        return fromPlayer.showNotification("This player is not online", "error")
    end

    isMemberInAnyGang(toPlayer.identifier, function (result) 
        if (result) then
            return cb("in_gang")
        end 
        MySQL.Async.fetchSingle("SELECT label, name FROM jobs WHERE name = @gangName", {
            ["@gangName"] = fromPlayer.job.name
        }, function (result) 
            if (not result) then return fromPlayer.showNotification("This gang does not exist", "error") end
            Player(toPlayer.source).state.gangInvite = {fromPlayer.source, result.name}
            TriggerClientEvent("stem_gangsystem:sendInvite", toPlayer.source, result.label)
            fromPlayer.showNotification("Invite sent to "..toPlayer.name, "success")
        end)
    end)
end)

ESX.RegisterServerCallback("stem_gangsystem:fetchGangList", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)

    getJobData(player.job.name, player.job.grade, function (result) 
        if (not result) then return end 
        if (result.type == "gang" and player.job.grade >= 2) then
            MySQL.Async.fetchAll("SELECT job_name FROM job_grades WHERE type = 'gang' AND grade = 0", function (result) 
                local gangs = exports.stem_common:tableFilter(exports.stem_common:tableMap(result, function (item) 
                    local leaderCounts = GlobalState.jobCount[("%s.2"):format(item.job_name)]
                    if (not leaderCounts or leaderCounts < 1) then
                        return false
                    end 
                    return item.job_name 
                end))
                if (#gangs < 1) then return cb({}) end
                MySQL.Async.fetchAll("SELECT label, name FROM jobs WHERE name IN (?)", { gangs }, function (result)
                    cb(result)
                end)
            end)
        end
        return nil
    end)

end)

function getGangWarStatistics(gangName, cb) 
    MySQL.Async.fetchAll("SELECT stats FROM stem_gangmembers WHERE gang = @gangName", {
        ["@gangName"] = gangName
    }, function (result) 
        local compiledStatistics = {}
        for key, value in pairs(result) do
            if (value and value.stats) then
                for statKey, statValue in pairs(json.decode(value.stats)) do
                    if (not compiledStatistics[statKey]) then 
                        compiledStatistics[statKey] = tonumber(statValue)
                    else
                        compiledStatistics[statKey] = compiledStatistics[statKey] + tonumber(statValue)
                    end 
                end
            end
        end
        cb(compiledStatistics)
    end)
end

ESX.RegisterServerCallback("stem_gangsystem:fetchGangStatistics", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)
    if (not player.job.name) then return cb(nil) end;
    getGangWarStatistics(player.job.name, cb)
end)


ESX.RegisterServerCallback("stem_gangsystem:fetchGangMember", function (source, cb, searchPlayer) 
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchSingle("SELECT * FROM stem_gangmembers WHERE gang = @gang AND player = @player", {
        ["@gang"] = player.job.name,
        ["@player"] = searchPlayer
    }, function (result) 
        populateMemberWithGangData(player.job.name, result, cb)
    end)
end)

ESX.RegisterServerCallback("stem_gangsystem:fetchGangMembers", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM stem_gangmembers WHERE gang = @gang", {
        ["@gang"] = player.job.name,
    }, function (result) 
        local data = exports.stem_common:tableMapCallback(result, function (item, key, cb) 
            populateMemberWithGangData(player.job.name, item, function (result) 
                cb(result)
            end)
        end)
        cb(data)
    end)
end)


ESX.RegisterServerCallback("stem_gangsystem:fetchCurrentGang", function (source, cb) 
    local player = ESX.GetPlayerFromId(source)
    if (not player) then return cb(nil) end
    fetchGangMember(player.identifier,  function (result)
        if (not result) then return cb(nil) end;
        getJobData(result.gang, result.grade, function (result)
            return cb(result)
        end)
    end)
end)


CreateThread(function () 
    MySQL.ready(function ()
        MySQL.Async.fetchAll("SELECT job_name FROM job_grades WHERE type = 'gang' AND grade = 0", function (result) 
            MySQL.Async.fetchAll("SELECT label, name FROM jobs WHERE name IN (?)", { exports.stem_common:tableMap(result, function (item) return item.job_name end) }, function (result) 
                for key, value in pairs(result) do
                    exports.esx_society:registerSociety(
                        value.name, 
                        value.label, 
                        "society_"..value.name, 
                        "society_"..value.name, 
                        "society_"..value.name, 
                        {
                            type = "private"
                        }
                    )   
                end
            end)
        end)
        exports.esx_society:setBossGradeName("exec")
    end)
end)

function updateGangMemberClothing(source)
    local player = ESX.GetPlayerFromId(source)

    getJobData(player.job.name, player.job.grade, function (result) 
        if (result.type == "gang") then
            Player(player.source).state.gangWhitelisted = true;
            local appearance = exports["illenium-appearance"]:GetAppearance(player.identifier)
            if appearance.sex == 0 then
                TriggerClientEvent('skinchanger:loadClothes', player.source, appearance, json.decode(result.skin_male))
            else
                TriggerClientEvent('skinchanger:loadClothes', player.source, appearance, json.decode(result.skin_female))
            end
        else
            Player(player.source).state.gangWhitelisted = false;
        end
    end)
end

AddEventHandler("esx:setJob", function (source, new, last) 
    updateGangMemberClothing(source)
end)

AddEventHandler("esx:onPlayerSpawned", function ()
    updateGangMemberClothing(source)
end)
