-- {
--     source = player.source, 
--     event = "stem_drugs:sell:completeSale",
--     reason = "Invalid sale conditions",
--     metadata = {
--         validSale = validSale,
--         sellToPed = sellToPed,
--     }
-- }
local SUS_ACTIVITY_WEBHOOK = GetConvar("sus_activity", nil)
RegisterNetEvent("stem_ac:player:sus", function (data) 
    local player = ESX.GetPlayerFromId(data.source)
    local steamName = GetPlayerName(player.source)

    local susString = ("Sus activity from %s:%s:%s (%s) | E: %s | %s"):format("%s", player.source, steamName, player.identifier, data.event, data.reason)

    print("[stem_ac]", susString:format(""))
    if (data.metadata) then
        print("------- [ METADATA ] -------")
        print(json.encode(data.metadata))
        print("----------------------------")
    end
    

    if (SUS_ACTIVITY_WEBHOOK) then
        exports.stem_discord:getUserDiscord(player.source, function (discordId) 
            return exports.stem_discord:sendThroughWebhook({
                webhook = SUS_ACTIVITY_WEBHOOK,
                params = {
                    username = "Sussy Activity",
                    content = susString
                }
            })
        end)
    else
        print("No sus_activity found")
    end
end)