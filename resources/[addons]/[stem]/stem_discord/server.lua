local ESX = exports["es_extended"]:getSharedObject()

function refreshPlayerEmbed(source)
    TriggerClientEvent("stem_discord:embed:data", source, {
        playerCountMax = GetConvar("sv_maxclients", 48),
        playerCount = #GetActivePlayers(),
        ping = GetPlayerPing(source)
    })
end

function refreshPlayerEmbeds()
    for index, player in ipairs(GetActivePlayers()) do
        refreshPlayerEmbed(player)
    end 
end

lib.cron.new("* * * * *", function () 
    refreshPlayerEmbeds()
end)

function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {};
    i = 1
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        t[i] = str
        i = i + 1
    end

    return t
end

local supporterRoles = {
    {id = "1227726547541168140", level = "bronze"},
    {id = "1227726480205807746", level = "silver"},
    {id = "1227726395950628905", level = "gold"},
    {id = "1227726268007714847", level = "diamond"},
    {id = "1227726107713998969", level = "emerald"},
    {id = "1255114512630153269", level = "master_chief"},
}

local staffRoles = {
    ["1221624077756665942"] = true, -- Client Support
    ["1234633199565672588"] = true, -- Trial Mod 
    ["1231414544400912445"] = true, -- Mod
    ["1221624077756665943"] = true, -- Admin
    ["1221624077756665944"] = true, -- Head Admin
    ["1221624077777764443"] = true, -- Management
}

function refreshDiscord(source, bool) 
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchScalar("SELECT discord_ids FROM users WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier }, function (result)
        if (not result) then 
            result = {}
        else
            result = json.decode(result)
        end
        local playerIdentifiers = GetPlayerIdentifiers(xPlayer.source)
        for key, value in pairs(playerIdentifiers) do
            local split = string.split(value, ":")
            if (split[1] == "discord" and not exports.stem_common:tableContains(result, split[2])) then
                table.insert(result, split[2])
            end 
        end

        MySQL.query.await("UPDATE users SET discord_ids = @discordIds WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
            ["@discordIds"] = json.encode(result)
        })

        local job = MySQL.single.await("SELECT discordId FROM job_grades WHERE job_name = @job_name AND grade = @grade", {
            ["@job_name"] = xPlayer.job.name,
            ["@grade"] = xPlayer.job.grade
        })

        if (bool) then
            xPlayer.showNotification("You've refreshed your discord", "success")
        end

        if (not job) then
            return 
        end

        exports.stem_discord:userHasRoleCallback(xPlayer.source, { job.discordId }, function (has)
            if (has) then return end
            xPlayer.setJob("unemployed", 0)
        end)
    end)

    exports.stem_discord:getRolesCallback(xPlayer.source, function (roles)
        local has = false;
        local supporterAccess = {}
        for key, value in next, exports.stem_common:tableReverse(supporterRoles) do
            if (exports.stem_common:tableContains(roles, value.id) or has) then
                has = true
                table.insert(supporterAccess, value.level)
            end
        end
        for key, value in pairs(roles) do
            if (staffRoles[value]) then
                Player(xPlayer.source).state.isStaff = true
            end
        end
        Player(xPlayer.source).state.supporterAccess = supporterAccess
        Player(xPlayer.source).state.discordRolesLoaded = true
        xPlayer.setMeta("supporterAccess", supporterAccess)
    end)
end

RegisterNetEvent("esx:playerLoaded", function (source) 
    local xPlayer = ESX.GetPlayerFromId(source)

    refreshPlayerEmbed(source)

    refreshDiscord(xPlayer.source) 
end)

local lastRan = {}

RegisterCommand("refreshdiscord", function (source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (lastRan[source] and GetGameTimer() < lastRan[source] + 30 * 1000) then
        return xPlayer.showNotification("Don't spam it, please wait 30 sec")
    end
    lastRan[source] = GetGameTimer()
    refreshDiscord(xPlayer.source, true) 
end)

Citizen.CreateThread(refreshPlayerEmbeds)

RegisterNetEvent("stem_discord:embed:fetch")
AddEventHandler("stem_discord:embed:fetch", function () 
    refreshPlayerEmbed(source)
end)

-- RegisterNetEvent("esx:onPlayerKilled", function (data)
--     print(json.encode(data))
-- end)