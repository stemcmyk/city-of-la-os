
local RESOURCE_STOP_WEBHOOK = GetConvar("job_payout_webhook", nil)
RegisterNetEvent("stem_common:resourceStop", function (resource) 
    print(("%s killed resource %s"):format(source, resource))

    if (RESOURCE_STOP_WEBHOOK) then
        exports.stem_discord:sendThroughWebhook({
            webhook = RESOURCE_STOP_WEBHOOK, 
            params = {
                username = "Resource Stops",
                content = ("%s killed resource %s"):format(source, resource)
            }
        })
    else
        print("No resource_stop_webhook found")
    end
    return 
end)