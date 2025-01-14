local data = {
    playerCountMax = 48,
    playerCount = #GetActivePlayers(),
    ping = 24,
}

RegisterNetEvent("stem_discord:embed:data")
AddEventHandler("stem_discord:embed:data", function (newData) 
    data = newData;
end)

AddEventHandler("onResourceStart", function (resourceName)
    if (resourceName ~= GetCurrentResourceName()) then return end;
    TriggerServerEvent("stem_discord:embed:fetch") 
end)


function updateInterval() 
    SetDiscordAppId(1231245959930052700)
    SetDiscordRichPresenceAsset('logo')
    SetRichPresence(string.format("%s / %s - %s ms", data.playerCount or #GetActivePlayers()  or 1 ,data.playerCountMax ,data.ping))
    SetDiscordRichPresenceAssetText()
    SetDiscordRichPresenceAssetSmallText('https://discord.gg/cityofla')
    SetDiscordRichPresenceAssetSmall('logo')
    SetDiscordRichPresenceAction(
        1,
        "Join our Discord",
        "https://discord.gg/cityofla"
    )
    SetDiscordRichPresenceAction(
        1,
        "Connect to the server",
        "https://cfx.re/join/wayjj3"
    )
end

Citizen.CreateThread(function () 
    while true  do
        updateInterval()
        Citizen.Wait(10000)
     end 
end)
