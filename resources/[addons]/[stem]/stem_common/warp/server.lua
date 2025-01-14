RegisterNetEvent("stem_common:warp:useWarp", function (data) 
    local player = ESX.GetPlayerFromId(source)
    local warp = Config_Warp.Warps[data.warpKey]
    local warpItem = warp.warps[data.warpIndex]
    if (exports.stem_common:tableContains(warp.jobs, player.job.name)) then
        TriggerClientEvent("stem_common:warp:teleport", player.source, warpItem.coords)
    end
end)