local loadedEUPs = {}

function saveEUPToDB(name, job, grade, data) 
    return MySQL.insert.await("INSERT INTO stem_eup (name, job, grade, data) VALUES (?,?,?,?)", {
        name,
        job, 
        grade,
        json.encode(data)
    })
end

function updateEUP(id, name, job, grade, data) 
    return MySQL.query.await("UPDATE stem_eup SET `name` = @name, `job` = @job, `grade` = @grade, `data` = @data WHERE id = @id", {
        ["@name"] = name,
        ["@job"] = job, 
        ["@grade"] = grade,
        ["@data"] = json.encode(data),
        ["@id"] = id 
    })
end


function getEUPsByJob(job) 
    return MySQL.query.await("SELECT * FROM stem_eup WHERE job = ?", {
        job, 
    })
end

function deleteEUPById(id) 
    return MySQL.update.await("DELETE FROM stem_eup WHERE id = ?", {
        id 
    })
end

function getGrades(job) 
    local jobGradesResult = MySQL.query.await("SELECT * FROM job_grades WHERE job_name = @job_name", {
        ["@job_name"] = job
    })
    
    local jobGrades = {}
    
    for key, value in pairs(jobGradesResult) do
        jobGrades[value.grade] = value
    end

    return jobGrades
end

function refreshEUP() 
    for index, value in pairs(config.groups) do
        local eups = getEUPsByJob(index)
        local grades = getGrades(index)
        if (not loadedEUPs[index]) then loadedEUPs[index] = {} end
        loadedEUPs[index] = exports.stem_common:tableMap(eups, function (eup) 
            eup.data = json.decode(eup.data)
            local grade = grades[eup.grade]
    
            if (grade) then
                eup.grade_name = grade.label
            end
            return eup
        end)
    end
    TriggerClientEvent("stem_eup:loadEUPs", -1, loadedEUPs)
end

lib.addCommand("saveeup", {
    help = "Save an outfit to the EUP menu.",
}, function (source, args, raw)
    local player = ESX.GetPlayerFromId(source)
    if (not config.groups[player.job.name] or player.job.grade < config.groups[player.job.name].editGrade ) then
        return player.showNotification("You do not have permission to edit EUPs")
    end  

    ESX.TriggerClientCallback(player.source, "stem_eup:saveEUPMenu", function (name, grade, props, components)
        if (not name) then return end;
        local id = saveEUPToDB(name, player.job.name, grade, {props = props, components = components})
        refreshEUP()
    end, player.job.name, getGrades(player.job.name))
end)

lib.addCommand("deleteeup", {
    help = "Delete an eup item",
    params = {
        {
            name = "id",
            help = "Id of the EUP item",
            type = "number"
        }
    }
}, function (source, args) 

    local player = ESX.GetPlayerFromId(source)
    if (not config.groups[player.job.name] or player.job.grade < config.groups[player.job.name].editGrade ) then
        return player.showNotification("You do not have permission to edit EUPs")
    end
    if (deleteEUPById(args.id)) then SetTimeout(500, refreshEUP) end 
end)

lib.addCommand("updateeup", {
    help = "Delete an eup item",
    params = {
        {
            name = "id",
            help = "Id of the EUP item",
            type = "number"
        }
    }
}, function (source, args) 
    local player = ESX.GetPlayerFromId(source)
    if (not config.groups[player.job.name] or player.job.grade < config.groups[player.job.name].editGrade ) then
        return player.showNotification("You do not have permission to edit EUPs")
    end

    ESX.TriggerClientCallback(player.source, "stem_eup:saveEUPMenu", function (name, grade, props, components)
        if (not name) then return end;
        updateEUP(args.id, name, player.job.name, grade, {props = props, components = components})
        refreshEUP()
    end, player.job.name, getGrades(player.job.name), args.id)
end)


RegisterNetEvent("esx:playerLoaded", function (source, player)
    TriggerClientEvent("stem_eup:loadEUPs", source, loadedEUPs)
end)

RegisterNetEvent("esx:setJob", function (source, job) 
    TriggerClientEvent("stem_eup:loadEUPs", source, loadedEUPs)
end)

RegisterNetEvent("stem_eup:requestEUP", function () 
    TriggerClientEvent("stem_eup:loadEUPs", source, loadedEUPs)
end)

Citizen.CreateThread(function () 
    MySQL.ready(function () 
        refreshEUP() 
    end)
end)