

function checkGangJob(identifier, jobName, grade)
    local esxJobs = ESX.GetJobs()
    local foundJob;
    for jobKey, jobValue in pairs(esxJobs) do
        for gradeKey, gradeValue in pairs(jobValue.grades) do
            if (gradeValue.grade == grade and jobValue.name == jobName) then
                foundJob = gradeValue
            end  
        end
    end 

    if (not foundJob) then return "not_found" end;
    if (foundJob.type ~= "gang") then return false end;
    
    local result = MySQL.single.await("SELECT gang, grade FROM stem_gangmembers WHERE player = @identifier", {
        ["@identifier"] = identifier
    })

    if (result.gang ~= jobName) then return "no_access_job" end
    if (result.grade ~= grade) then return "no_access_grade" end
    return result
end

local function GetJobsByKV(identifier, data, cb)
    local esxJobs = ESX.GetJobs()
    local jobs = {}
    local jobsByName = {}
    for jobDataKey, jobDataValues in pairs(data) do
        for jobKey, jobValue in pairs(esxJobs) do
            for gradeKey, gradeValue in pairs(jobValue.grades) do
                local isGradeAndCategoryMatch = jobDataKey ~= "gang" and gradeValue.type == "gang"
                local hasAccess = (jobDataKey == "gang") and checkGangJob(identifier, jobValue.name, gradeValue.grade) or true
            
                if (hasAccess == "no_access_job") then hasAccess = false end;
                if (hasAccess == "no_access_grade") then hasAccess = false end;

                if (jobDataValues and jobDataValues[2] and exports.stem_common:tableContains(jobDataValues[2], gradeValue[jobDataKey]) and jobDataKey ~= "gang" and hasAccess and not isGradeAndCategoryMatch) then
                    table.insert(jobs, {
                        title = jobValue.label .. " - " .. gradeValue.label,
                        id = jobValue.name, 
                        grade = gradeValue.grade,
                        jobCategory = jobDataValues[1]
                    })
                end
                if (jobDataValues and jobDataKey == "gang" and gradeValue.type == "gang" and hasAccess) then
                    table.insert(jobs, {
                        title = jobValue.label .. " - " .. gradeValue.label,
                        id = jobValue.name, 
                        grade = gradeValue.grade,
                        jobCategory = jobDataValues[1]
                    })
                end
            end
        end
    end
    return cb(jobs)
end


function hasAccessToJob(source, jobName, grade, cb)
    MySQL.Async.fetchSingle("SELECT job_name, discordId FROM job_grades WHERE job_name = @jobName AND grade = @grade", {
        ["@jobName"] = jobName,
        ["@grade"] = grade
    }, function (result)
        if (not result.discordId) then return cb(true) end

        exports.stem_discord:userHasRoleCallback(source, result.discordId, function (result) 
            cb(result)
        end)
    end)
end

ESX.RegisterServerCallback("npwd:stem_job_center:getJobs", function (source, cb)
    local player = ESX.GetPlayerFromId(source)
    exports.stem_discord:getRolesCallback(source, function (result)
        exports.stem_gangsystem:fetchGangMember(player.identifier, function (gangResult)
            GetJobsByKV(player.identifier, {
                job_name = {"Public Jobs", Config.publicJobs},
                discordId = result and #result > 0 and {"Whitelisted Jobs", result},
                gang = gangResult and {"Whitelisted Gangs", {gangResult.gang}}
            }, function (data) 
                cb(data)
            end)
        end)
    end)
end)


ESX.RegisterServerCallback("npwd:stem_job_center:getJob", function (source, cb)
    local player = ESX.GetPlayerFromId(source)
    cb({ name = player.job.name, grade = player.job.grade })
end)


ESX.RegisterServerCallback("npwd:stem_job_center:setJob", function (source, cb, data)
    local player = ESX.GetPlayerFromId(source)
    hasAccessToJob(player.source, data.id, data.grade, function (result) 
        if (result) then
            local result = checkGangJob(player.identifier, data.id, data.grade)
            if (result == "not_found" or result == "no_access_job") then
                cb(false)
                return player.showNotification("You do not have access to this job.")
            end

            if (result == "no_access_grade") then
                cb(false)
                return player.showNotification("You do not have access to this job's grade")
            end
            
            player.setJob(data.id, data.grade)
            return cb(true)
        end
        cb(false)
    end)
end)