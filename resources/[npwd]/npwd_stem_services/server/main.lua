ESX.RegisterServerCallback("npwd:stem_services:getJobCounts", function (source, cb)
    local jobs = {}
    local esxJobs = ESX.Jobs

    for key, value in pairs(Config.jobsToCount) do
        if (type(value) == "string") then
            if (esxJobs[value]) then
                table.insert(jobs, {
                    title = esxJobs[value].label,
                    amount = GlobalState.jobCount[value]
                })
            end
        end
    end
    cb(jobs)
end)

