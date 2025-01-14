local jobsToSave = {
    "lspd",
    "sahp",
    "lscso",
    "amr",
    "sadot",
    "doj",
    "casino",
    "lux",
    "beanmachine",
    "upnatom",
    "hornys",
    "burgershot"
}
GlobalState.cooldown = {
    lspd = 0,
    sahp = 0
}
GlobalState.forcedCooldown = {
    lspd = false,
    sahp = false
}

function refreshJobs()
    local jobs = ESX.GetJobs()
    local jobCounts = tableMapWithKeys(jobs, function (job, data) 
        return job, 0
    end)
    
    for index, _player in pairs(GetActivePlayers()) do
        local player = ESX.GetPlayerFromId(_player)
        if (player and jobCounts[player.job.name]) then
            jobCounts[player.job.name] = jobCounts[player.job.name] + 1
            
            local grades = jobs[player.job.name].grades
            
            for index, value in pairs(grades) do
                if (player.job.grade == value.grade) then
                    if (not jobCounts[player.job.name.."."..value.name]) then
                        jobCounts[player.job.name.."."..value.name] = 0
                    end
                    jobCounts[player.job.name.."."..value.name] = jobCounts[player.job.name.."."..value.name] + 1
                    
                    for i = 1, value.grade, 1 do
                        if (not jobCounts[player.job.name.."."..i]) then
                            jobCounts[player.job.name.."."..i] = 0
                        end
                        jobCounts[player.job.name.."."..i] = jobCounts[player.job.name.."."..i] + 1
                    end
                end
            end

        end
    end

    GlobalState.jobCount = jobCounts
end

RegisterNetEvent("esx:setJob", function () 
    refreshJobs()
end)

RegisterNetEvent("esx:loadedPlayer", function () 
    refreshJobs()
end)

Citizen.CreateThread(function () 
    while true do
        refreshJobs()
        Citizen.Wait(15000)
    end
end)

lib.cron.new("* * * * *", function ()
    for key, value in pairs(GlobalState.cooldown) do
        if (value > 0) then
            local newCooldown = GlobalState.cooldown
            newCooldown[key] = value - 1
            GlobalState.cooldown = newCooldown
            
            print(string.format("New cooldown for %s is %s", key, value - 1))
        end
    end
    print(("LSPD: %s | LSSD: %s | SAHP: %s"):format(GlobalState.jobCount["lspd"], GlobalState.jobCount["lscso"], GlobalState.jobCount["sahp"]))
end)

refreshJobs()