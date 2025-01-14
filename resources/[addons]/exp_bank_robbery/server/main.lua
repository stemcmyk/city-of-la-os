local bank_robbed = nil
local currentBankRobbery = nil;

RegisterServerCallback("exp_bank_robbery:CanBeRobbed", function(source, callback, bank_id)
    if bank_robbed then
        TriggerClientEvent("exp_bank_robbery:ShowNotification", source, {
            title = _("hack_vault_name"),
            message = _("vault_empty"),
            type = "error"
        })
        return
    end


    if (not BANKS[bank_id]) then  
        return 
    end 
    local policeCount = GlobalState.jobCount[BANKS[bank_id].jurisdiction]
    if (BANKS[bank_id].jurisdiction == "lspd") then
        print()
        policeCount = policeCount + (GlobalState.jobCount["lscso"] or 0)
    end
    
    if policeCount < POLICE_REQUIRED then
        ShowNotification(source, {
            title = _("not_enough_police_title"),
            message = _("not_enough_police"),
            type = "error"
        })
        return
    end

    Player(source).state.currentBankRobbery = bank_id

    callback()
end)

RegisterNetEvent("exp_bank_robbery:InitiateBankRobbery", function (bank_id) 
    DiscordLog(source, {
        name = "start",
        id = bank_id
    })

    bank_robbed = bank_id
    Wait(BANK_TIMER)
    TriggerClientEvent("exp_bank_robbery:CloseVaultDoor", -1, bank_id)
    bank_robbed = nil
    DiscordLog(source, {
        name = "reset",
        id = bank_id
    })
end)

RegisterServerEvent("exp_bank_robbery:GiveGrabbedCash")
AddEventHandler("exp_bank_robbery:GiveGrabbedCash", function(id, amount)
    local _source = source
    local ped = GetPlayerPed(_source)
    if (not currentBankRobbery) then 
        return DiscordLog(_source, {
            name = "cheat"
        })
    end

    if #(GetEntityCoords(ped) - BANKS[bank_robbed].vault_hack.position) > 50 then
        return DiscordLog(_source, {
            name = "cheat"
        })
    end

    local totalTake = 0
    for key, value in pairs(currentBankRobbery.cashStacks[id]) do
        if (key > amount) then
            DiscordLog(_source, {
                name = "cash",
                earnings = totalTake,
                bank_id = currentBankRobbery.id,
                id = id
            })
            return GiveGrabbedCash(_source, {earnings = totalTake})
        end
        totalTake = totalTake + currentBankRobbery.cashStacks[id][key]
    end

    DiscordLog(_source, {
        name = "cash",
        earnings = totalTake,
    })
    GiveGrabbedCash(_source, {earnings = totalTake})
end)

RegisterServerEvent("exp_bank_robbery:LockDoor")
AddEventHandler("exp_bank_robbery:LockDoor", function(bank, state)
    TriggerClientEvent("exp_bank_robbery:LockDoor", -1, bank, state)
end)

RegisterServerEvent("exp_bank_robbery:OpenVaultDoor")
AddEventHandler("exp_bank_robbery:OpenVaultDoor", function(bank_id)
    if (Player(source).state.currentBankRobbery ~= bank_id) then
        return DiscordLog(source, {
            name = "cheat",
            currentBankId = Player(source).state.currentBankRobbery,
            bank_id = bank_id
        })
    end


    currentBankRobbery = {
        id = bank_id,
        cashStacks = {}
    }

    for i2 = 1, 3 do
        if (not currentBankRobbery.cashStacks[i2]) then currentBankRobbery.cashStacks[i2] = {} end
        for i1 = 1, 60, 1 do 
            currentBankRobbery.cashStacks[i2][i1] = math.random(MONEY_PER_STACK - MONEY_PER_STACK * 0.10, MONEY_PER_STACK + MONEY_PER_STACK * 0.10)
        end    
    end

    DiscordLog(source, {
        name = "openvault"
    })
    TriggerClientEvent("exp_bank_robbery:OpenVaultDoor", -1, bank_id, currentBankRobbery.cashStacks)
end)

RegisterServerCallback("exp_bank_robbery:GetBankRobbed", function(source, callback)
    callback(bank_robbed)
end)

RegisterServerCallback("exp_bank_robbery:HasItem", function(source, callback, item)
    callback(DoesPlayerHaveItem(source, item))
end)

function ShowNotification(player_src, event)
    TriggerClientEvent("exp_bank_robbery:ShowNotification", player_src, event)
end