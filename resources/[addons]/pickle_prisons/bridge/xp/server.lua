-- By default, this will use Pickle's XP, but you can change it to your system here.
if not Config.XPEnabled then return end

function AddPlayerXP(source, name, xp)
    TriggerClientEvent("gamz-skillsystem:updateSkill", source, name, xp)
end

function GetPlayerLevel(source, name)
    return exports["gamz-skillsystem"]:GetCurrentSkill(source, name)
end

function GetPlayerXPData(source, name)
    local data = {}
    for k,v in pairs(Config.XPCategories) do 
        local level = GetPlayerLevel(source, name)
        data[name] = {
            label = v.label,
            level = level,
        }
    end
    return data
end
