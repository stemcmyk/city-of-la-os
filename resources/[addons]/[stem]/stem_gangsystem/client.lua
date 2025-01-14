local gangInviteAvailable

AddEventHandler(
    "playerSpawned",
    function()
        local relationshipTypes = {
            -- `PLAYER`,
            `CIVMALE`,
            `CIVFEMALE`,
            `GANG_1`,
            `GANG_2`,
            `GANG_9`,
            `GANG_10`,
            `AMBIENT_GANG_LOST`,
            `AMBIENT_GANG_MEXICAN`,
            `AMBIENT_GANG_FAMILY`,
            `AMBIENT_GANG_BALLAS`,
            `AMBIENT_GANG_MARABUNTE`,
            `AMBIENT_GANG_CULT`,
            `AMBIENT_GANG_SALVA`,
            `AMBIENT_GANG_WEICHENG`,
            `AMBIENT_GANG_HILLBILLY`,
            `DEALER`,
            `COP`,
            `PRIVATE_SECURITY`,
            `SECURITY_GUARD`,
            -- `ARMY`,
            `MEDIC`,
            `FIREMAN`,
            -- `HATES_PLAYER`,
            -- `NO_RELATIONSHIP`,
            `SPECIAL`,
            `MISSION2`,
            `MISSION3`,
            `MISSION4`,
            `MISSION5`,
            `MISSION6`,
            `MISSION7`,
            `MISSION8`,
            `PRISONER`
        }

        local playerHash = `PLAYER`
        for _, groupHash in pairs(relationshipTypes) do
            -- ACQUAINTANCE_TYPE_PED_NONE = 255,
            -- ACQUAINTANCE_TYPE_PED_RESPECT = 0,
            -- ACQUAINTANCE_TYPE_PED_LIKE,         //  1
            -- ACQUAINTANCE_TYPE_PED_IGNORE,       //  2
            -- ACQUAINTANCE_TYPE_PED_DISLIKE,      //  3
            -- ACQUAINTANCE_TYPE_PED_WANTED,       //  4
            -- ACQUAINTANCE_TYPE_PED_HATE,         //  5
            -- ACQUAINTANCE_TYPE_PED_DEAD          //  6

            SetRelationshipBetweenGroups(1, playerHash, groupHash)
            SetRelationshipBetweenGroups(1, groupHash, playerHash)
        end
    end
)


function OpenGangInteractionMenu()
    ESX.TriggerServerCallback(
        "stem_gangsystem:fetchGangList",
        function(result)
            
            if (not result) then return end;
            local options = exports.stem_common:tableFilter(exports.stem_common:tableMap(result, function (value)
                if (value.name ~= ESX.PlayerData.job.name) then
                    return {
                        title = string.format("Declare War: %s", value.label),
                        onSelect = function () 
                            ESX.TriggerServerCallback(
                                "stem_gangsystem:fetchGangStatistics",
                                function(serverResult)
                                    local netProfit = ((result?.dirty_earned or 0) * 0.25) - (result?.dirty_spent or 0)
                                    local minNetProfit = netProfit < 0 and 0 or netProfit
                            
                                    local gangwarPrice = math.ceil(minNetProfit * 0.10) + GlobalState.MinGangwarPrice
                                    
                                    local result = lib.alertDialog({
                                        header = string.format("Are you sure you want to declare war on **%s**", value.label),
                                        content = string.format("This will cost you **$%s**", ESX.Math.GroupDigits(gangwarPrice)),
                                        cancel = true,
                                        centered = true
                                    })

                                    if (result == "cancel") then
                                        return lib.showContext("gang_interaction_menu")
                                    end

                                    ESX.TriggerServerCallback("stem_gangsystem:declareWar", function(result)
                                        if (not result) then lib.showContext("gang_interaction_menu") end
                                    end, value.name)
                                end
                            )
                        end
                    }
                end
                return false
            end))


            lib.registerContext({
                id = "gang_interaction_menu",
                menu = "gang_menu",
                title = "Gang War",
                options = #options > 0 and options or {{
                    title = "There are no other active gangs."
                }}
            })
            lib.showContext("gang_interaction_menu")
        end
    )
end

function OpenGangAttributionMenu()
    ESX.TriggerServerCallback(
        "stem_gangsystem:fetchGangMembers",
        function(data)
            table.sort(data, function (a, b)
                return a.job_grade < b.job_grade 
            end)
            lib.registerContext({
                id = "gang_attribution",
                title = "Gang Attributions",
                menu = "gang_menu",
                options = exports.stem_common:tableMap(data, function (item) 
                    local stats = item.stats or {}
                    return {
                        title = item.name,
                        description = string.format("%s (%s)", item.job_label, item.job_grade),
                        metadata = {
                            {
                                label = "Dirty Earned",
                                value = ESX.Math.GroupDigits(stats.dirty_earned or 0) 
                            },
                            {
                                label = "Dirty Spent",
                                value = ESX.Math.GroupDigits(stats.dirty_spent or 0) 
                            },
                            {
                                label = "Dirty Net Gross",
                                value = ESX.Math.GroupDigits((stats.dirty_earned or 0) - (stats.dirty_spent or 0 ))
                            },
                            {
                                label = "Drugs Sold",
                                value = ESX.Math.GroupDigits(stats.drugs_sold  or 0) 
                            },
                            {
                                label = "Months Served",
                                value = ESX.Math.GroupDigits(stats.months_served  or 0) 
                            },
                            {
                                label = "Fines Paid",
                                value = ESX.Math.GroupDigits(stats.fines_paid or 0) 
                            },
                            {
                                label = "Gang War Kills",
                                value = ESX.Math.GroupDigits(stats.war_kills or 0) 
                            },
                        } or {
                            {
                                label = "Statistics",
                                value = "No Statistics Yet"
                            }
                        }
                    }
                end)
            })
            lib.showContext("gang_attribution")
        end
    )
end

function OpenGangMemberRosterMenu(player)
    ESX.TriggerServerCallback("stem_gangsystem:fetchGangMember", function(data)
        local options = {
            (ESX.PlayerData.job.grade > data.job_grade) and data.job_grade >= 1 and {
                title =  "Demote",
                onSelect = function () 
                    return TriggerServerEvent("stem_gangsystem:modifyMember", player, {
                        grade = data.job_grade - 1
                    })
                end
            } or false,

            (ESX.PlayerData.job.grade > data.job_grade)  and {
                title = "Kick",
                onSelect = function () 
                    local result = lib.alertDialog({
                        header = "Are you sure?",
                        content = "Are you sure you want to kick "..data.name.."? All their gang progess will be lost.",
                        cancel = true,
                        labels = { cancel = "No", confirm = "Yes" }
                    })
                    if (result == "cancel") then
                        return OpenGangMemberRosterMenu(player)
                    end
                    return TriggerServerEvent("stem_gangsystem:kickMember", player)
                end
            } or false,
            
            (ESX.PlayerData.job.grade > (data.job_grade + 1)) and {
                title = "Promote",
                onSelect = function () 
                    TriggerServerEvent("stem_gangsystem:modifyMember", player, {
                        grade = data.job_grade + 1
                    })
                end
            } or false,
        }

        lib.registerContext({
            id = "gang_roster:"..player,
            title = string.format("Gang Roster %s", data.name),
            menu = "gang_roster",
            options = exports.stem_common:tableFilter(options, function (e) return e ~= false end) 
        })
        lib.showContext("gang_roster:"..player)
    end, player)
end

function AddGangMemberDialog() 
    local result = lib.inputDialog("Who do you want to invite?", {
        {
            label = "Player Id",
            type = "number",
        },
    }, {
        cancel = true
    })

    if (not result) then
        return lib.showContext("gang_roster")
    end

    ESX.TriggerServerCallback("stem_gangsystem:sendInvite", function(result) 
        if (result == "in_gang") then
            lib.notify({
                title = "Member already in a gang",
                description = "This member is already part of another gang and cannot be invited.",
                type = "error"
            })
            lib.showContext("gang_menu")
            return
        end
        OpenGangRosterMenu()
    end, result[1])
end

function OpenGangRosterMenu() 
    ESX.TriggerServerCallback("stem_gangsystem:fetchGangMembers", function(data)
        table.sort(data, function(a, b)
            return a.job_grade < b.job_grade 
        end)
        lib.registerContext({
            id = "gang_roster",
            title = "Gang Roster",
            menu = "gang_menu",
            options = exports.stem_common:tableMerge({{ 
                title = "Invite Member",
                onSelect = AddGangMemberDialog,
            }}, exports.stem_common:tableMap(data, function (item) 
                local stats = item.stats or {}
                return {
                    title = item.name,
                    description = string.format("%s (%s)", item.job_label, item.job_grade),
                    onSelect = function () 
                        OpenGangMemberRosterMenu(item.player)
                    end
                }
            end))
        })
        lib.showContext("gang_roster")
    end)
end

function OpenGangLeaderMenu()
    
    ESX.TriggerServerCallback("stem_gangsystem:fetchCurrentGang", function (result) 
        if (not result) then return end;
        if (result.job_name ~= ESX.PlayerData.job.name) then return end
        if (result.type == "gang" and ESX.PlayerData.job.grade >= 2) then
            lib.registerContext({
                id = "gang_menu",
                title = string.format("Gang Menu (%s)", result.job_label),
                options = exports.stem_common:tableFilter({
                    not GlobalState.gangWar and {
                        title = "Gang War",
                        onSelect = OpenGangInteractionMenu
                    } or false,  
                    {
                        title = "Member Attribution",
                        onSelect = OpenGangAttributionMenu
                    },
                    ESX.PlayerData.job.grade > 2 and {
                        title = "Roster Management",
                        onSelect = OpenGangRosterMenu
                    } or false
                }, function (e) return e ~= false end)
            })
    
            lib.showContext("gang_menu")
        end
    end)
end

function OpenGangInvite() 
    local response = lib.alertDialog({
        header = "Gang Invite",
        content = "You have been invited to **"..gangInviteAvailable.."**, how will you respond?",
        cancel = true,
        labels = {
            cancel = "Deny",
            confirm = "Accept"
        }
    })
    TriggerServerEvent("stem_gangsystem:respondToInvite", response == "cancel")
    gangInviteAvailable = nil;
end


function OpenGangMenu() 
    if (gangInviteAvailable) then return OpenGangInvite() end
    OpenGangLeaderMenu()
end


Citizen.CreateThread(function () 
    TriggerServerEvent("stem_gangsystem:fetchClothing")
end)

function checkClothingBlacklist(component)
    local cat = IsPedMale(PlayerPedId()) and "m" or "F"
    local clothingWhitelisted = Config.gangWhitelistedClothing[cat][string.format("%s:%s:%s", component.component_id, component.drawable, component.texture)]
    if (not clothingWhitelisted) then return end;
    ESX.TriggerServerCallback("esx:isUserAdmin", function(admin)
        if (admin) then return end
        ESX.TriggerServerCallback("stem_gangsystem:fetchCurrentGang", function(gangResult)
            if (not gangResult or clothingWhitelisted ~= ESX.PlayerData.job.name) then
                local newDrawable = component.drawable < 1 and 2 or component.drawable - 1
                SetPedComponentVariation(PlayerPedId(), component.component_id, newDrawable, 0)
                lib.notify({
                    type = "error",
                    title = "This is a gang whitelisted clothing item",
                    description = "Select a different piece of clothing"
                })
            end
        end)
    end)
end

RegisterNetEvent("stem_gangsystem:blacklistedClothing", function (data)

end)

RegisterNetEvent("stem_gangsystem:sendInvite", function (gangName) 
    lib.notify({
        duration = 30000,
        title = string.format("You have been invited to %s", gangName),
        description = "Press **F6** to open the invite.",
    })
    gangInviteAvailable = gangName
end)

exports("checkClothingBlacklist", checkClothingBlacklist)

RegisterCommand("gangmenu",  OpenGangMenu)
RegisterKeyMapping("gangmenu", "Open gang menu", "keyboard", "f6")
