-- ======[EDITABLE FUNCTIONS]======

function RevivePlayer(playerId)
    if Config.FrameWork.FRAMEWORK == "ESX" then
        TriggerClientEvent("esx_ambulancejob:revive", playerId)
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        TriggerClientEvent('hospital:client:Revive', playerId)
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
    end
end

function WipePlayer(playerId, identifier, license)
    if Config.FrameWork.FRAMEWORK == "ESX" then
        MySQL.Sync.execute("DELETE FROM `users` WHERE `identifier` = ?",{identifier})
        MySQL.Sync.execute("DELETE FROM `user_licenses` WHERE `owner` = ?",{identifier})
        MySQL.Sync.execute("DELETE FROM `owned_vehicles` WHERE `owner` = ?",{identifier})
        MySQL.Sync.execute("DELETE FROM `addon_account_data` WHERE `owner` = ?",{identifier})
        MySQL.Sync.execute("DELETE FROM `addon_inventory_items` WHERE `owner` = ?",{identifier})
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        QBCore.Player.ForceDeleteCharacter(identifier)
        MySQL.Sync.execute("DELETE FROM `players` WHERE `citizenid` = ?",{identifier})
        MySQL.Sync.execute('DELETE FROM `player_vehicles` WHERE `citizenid` = ?', { citizenid })
        MySQL.Sync.execute('DELETE FROM `player_outfits` WHERE `citizenid` = ?', { citizenid })
        MySQL.Sync.execute('DELETE FROM `player_houses` WHERE `citizenid` = ?', { citizenid })
        MySQL.Sync.execute('DELETE FROM `player_contacts` WHERE `citizenid` = ?', { citizenid })
        MySQL.Sync.execute('DELETE FROM `playerskins` WHERE `citizenid` = ?', { citizenid })
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
    end
end

function GetMoneyAccounts()
    if Config.FrameWork.FRAMEWORK == "ESX" then
        return {"bank", "money", "black_money"}
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        return {"bank", "cash", "crypto"}
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
        return {}
    end
end

function GetAllItems()
    local allItems = {}
    if Config.FrameWork.FRAMEWORK == "ESX" then
        local p = promise.new()
        MySQL.Async.fetchAll('SELECT * FROM `items`', {}, function(items)
            for k, v in pairs(items) do
                table.insert(allItems, {Item = v.name, Name = v.label})
            end
            p:resolve()
        end)
        Citizen.Await(p)
        return allItems
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        for k,v in pairs(QBCore.Shared.Items) do
            table.insert(allItems, {Item = v.name, Name = v.label})
        end
        return allItems
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
        return allItems
    end
end

function GetAllJobs()
    local allJobs = {}
    if Config.FrameWork.FRAMEWORK == "ESX" then
        local p = promise.new()
        MySQL.Async.fetchAll('SELECT * FROM `jobs`', {}, function(jobs)
            for k, v in pairs(jobs) do
                allJobs[v.name] = {Label = v.label, Grades = {}}
            end
            p:resolve()
        end)
        Citizen.Await(p)

        local p2 = promise.new()
        MySQL.Async.fetchAll('SELECT * FROM `job_grades`', {}, function(jobGrades)
            for k, v in pairs(jobGrades) do
                if allJobs[v.job_name] then
                    allJobs[v.job_name].Grades[tostring(v.grade)] = v.label
                end
            end
            p2:resolve()
        end)
        Citizen.Await(p2)

        return allJobs
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        for k,v in pairs(QBCore.Shared.Jobs) do
            allJobs[k] = {Label = v.label, Grades = {}}
            for k2, v2 in pairs(v.grades) do
                allJobs[k].Grades[tostring(k2)] = v2.name
            end
        end
        return allJobs
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
        return allJobs
    end
end

function GetAllGangs()
    local allGangs = {}
    if Config.FrameWork.FRAMEWORK == "ESX" then
        local gangTable
        local p0 = promise.new()
        MySQL.Async.fetchAll('SHOW TABLES LIKE @table', { ["table"] = "jobs2" }, function(affectedRows)
            if affectedRows ~= nil and #affectedRows > 0 then
                gangTable = "jobs2"
                p0:resolve()
            else
                MySQL.Async.fetchAll('SHOW TABLES LIKE @table', { ["table"] = "gangs" }, function(affectedRows2)
                    if affectedRows2 ~= nil and #affectedRows2 > 0 then
                        gangTable = "gangs"
                        p0:resolve()
                    else
                        gangTable = nil
                        p0:resolve()
                    end
                end)
            end
        end)
        Citizen.Await(p0)

        if gangTable ~= nil then
            local p = promise.new()
            MySQL.Async.fetchAll("SELECT * FROM `"..gangTable.."`", {}, function(gangs)
                for k, v in pairs(gangs) do
                    allGangs[v.name] = {Label = v.label, Grades = {}}
                end
                p:resolve()
            end)
            Citizen.Await(p)

            local p2 = promise.new()
            MySQL.Async.fetchAll("SELECT * FROM `"..(gangTable == "jobs2" and "job2_grades" or "gang_grades").."`", {}, function(gangGrades)
                for k, v in pairs(gangGrades) do
                    if allGangs[v.job_name] then
                        allGangs[v.job_name].Grades[tostring(v.grade)] = v.label
                    end
                end
                p2:resolve()
            end)
            Citizen.Await(p2)
        end

        return allGangs
    elseif Config.FrameWork.FRAMEWORK == "QBCORE" then
        for k,v in pairs(QBCore.Shared.Gangs) do
            allGangs[k] = {Label = v.label, Grades = {}}
            for k2, v2 in pairs(v.grades) do
                allGangs[k].Grades[tostring(k2)] = v2.name
            end
        end
        return allGangs
    elseif Config.FrameWork.FRAMEWORK == 'CUSTOM' then
        -- your own function
        return allGangs
    end
end

-- ======[Callback Events]======
local ServerCallbacks = {}

function RegisterServerCallback(name, cb)
    ServerCallbacks[name] = cb
end

local function TriggerServerCallback(name, source, cb, ...)
    if not ServerCallbacks[name] then return end
    ServerCallbacks[name](source, cb, ...)
end

RegisterNetEvent(GetCurrentResourceName()..':TriggerServerCallback', function(name, ...)
    local src = source
    TriggerServerCallback(name, src, function(...)
        TriggerClientEvent(GetCurrentResourceName()..':TriggerServerCallback', src, name, ...)
    end, ...)
end)