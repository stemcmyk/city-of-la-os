local config = {}
-- CONFIG --
config.Debug = true
-- END OF CONFIG --
-- DEBUG --
function DebugPrint(msg)
    if config.Debug == true then
        print("GSW | " .. tostring(msg))
    end
end
-- END OF DEBUG --
--Tables--
local Group1 = { -- FIRST TO CHECK
    [2725352035] = true,
    [1317494643] = true,
    [2508868239] = true,
    [1141786504] = true,
    [2227010557] = true,
    [3638508604] = true,
    [2484171525] = true,
    [419712736] = true,
    [2578778090] = true,
    [4192643659] = true,
    [2460120199] = true,
    [4191993645] = true,
    [3713923289] = true,
    [3756226112] = true,
    [3441901897] = true,
    [1737195953] = true
}
local Group2 = { -- SECOND TO CHECK
    [584646201] = true,
    [1593441988] = true,
    [3523564046] = true,
    [3218215474] = true,
    [453432689] = true,
    [3219281620] = true,
    [3696079510] = true,
    [137902532] = true,
    [2548703416] = true,
    [3249783761] = true
}
local Group3 = { -- THIRD TO CHECK
    [171789620] = true,
    [736523883] = true,
    [2024373456] = true,
    [324215364] = true,
    [3675956304] = true,
    [3173288789] = true,
    [162746534] = true,
    [4024951519] = true,
    [2741846334] = true
}
local Group4 = { -- FIFTH TO CHECK
    [2828843422] = true,
    [317205821] = true,
    [3800352039] = true,
    [2640438543] = true,
    [2017895192] = true,
    [487013001] = true,
    [1432025498] = true,
    [984333226] = true,
    [4019527611] = true
}
local Group5 = { -- FOURTH TO CHECK
    [1649403952] = true,
    [3231910285] = true,
    [2937143193] = true,
    [2228681469] = true,
    [2132975508] = true,
    [2210333304] = true,
    [4208062921] = true,
    [3220176749] = true,
    [961495388] = true
}
local Group6 = { -- SIXTH TO CHECK
    [3342088282] = true,
    [1785463520] = true,
    [100416529] = true,
    [2634544996] = true,
    [2144741730] = true,
    [205991906] = true,
    [177293209] = true,
    [2578377531] = true
}
--End of Tables--
--Variables--
local group = 0
local NeedToContinue = true
--End of Variables--
--Events--
AddEventHandler("c_ShotRegister_GetWeapon", function(ped)
    for i,v in pairs(Group1) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 1
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
    for i,v in pairs(Group2) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 2
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
    for i,v in pairs(Group3) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 3
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
    for i,v in pairs(Group5) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 5
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
    for i,v in pairs(Group4) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 4
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
    for i,v in pairs(Group6) do
        if HasEntityBeenDamagedByWeapon(ped, i, 0) == 1 then
            group = 6
            TriggerServerEvent("gotGroup_CtS", ped, group, i)
            NeedToContinue = false
        end
    end
    if NeedToContinue == false then
        NeedToContinue = true
        group = 0
        return
    end
end)
--End of Events--