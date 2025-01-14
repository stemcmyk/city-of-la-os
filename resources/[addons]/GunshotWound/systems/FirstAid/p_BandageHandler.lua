-- VARIABLES --

local config = {}
local vars = {}

vars.ResourceName = GetCurrentResourceName()
vars.BandageName = 0

-- DEBUG INFO --

function BandageHandlerDebug(f, t, v)
    if config.Debug == true then
        local m = (tostring(f) .. " || " .. tostring(t) .. tostring(v))
        print(m)
    end
end

-- GET CONFIG --

RegisterNetEvent("c_BandageHandler_ConfigSet")
AddEventHandler(
    "c_BandageHandler_ConfigSet",
    function(configSent)
        config = configSent
        FirstAidDebug(
            "c_BandageHandler_ConfigSet",
            "Config sent, debug status: ",
            "From Sent: " .. tostring(configSent.Debug) .. ". From Config: " .. tostring(config.Debug)
        )
    end
)

-- FUNCTIONS --

function DisplayMsg(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function FirstAid(bT)
    if bT == 1 then
        for i, v in pairs(config.BandageTypes) do
            if v.TypeID == 1 then
                vars.BandageName = v.Name
                exports[vars.ResourceName]:SetBleedoutVariable(true, false)
            end
        end
    end
    if bT == 2 then
        for i, v in pairs(config.BandageTypes) do
            if v.TypeID == 2 then
                vars.BandageName = v.Name
                exports[vars.ResourceName]:SetBleedoutVariable(true, true)
            end
        end
    end
    if bT == 3 then
        for i, v in pairs(config.BandageTypes) do
            if v.TypeID == 2 then
                vars.BandageName = v.Name
                exports[vars.ResourceName]:SetBleedoutVariable(true, false)
                exports[vars.ResourceName]:SetEffectsVariable(6, true, PlayerPedId())
            end
        end
    end
    if bT == 4 then
        for i, v in pairs(config.BandageTypes) do
            if v.TypeID == 2 then
                vars.BandageName = v.Name
                exports[vars.ResourceName]:SetBleedoutVariable(true, true)
                exports[vars.ResourceName]:SetEffectsVariable(3, false, PlayerPedId())
            end
        end
    end
end

function GetServerId()
    local players = GetPlayers()
    for i, v in ipairs(players) do
        local target = GetPlayerPed(v)
        if (target == PlayerPedId()) then
            return target
        end
    end
end

-- EVENTS --

RegisterNetEvent("PlayerFirstAidSide")
AddEventHandler(
    "PlayerFirstAidSide",
    function(pId, BType)
        if GetPlayerPed(pId) == GetServerId() then
            FirstAid(bT)
            SetNotificationTextEntry("STRING")
            AddTextComponentString("Someone used bandages on you.")
            DrawNotification(true, false)
        end
    end
)

AddEventHandler(
    "BandageHandlerExecute",
    function(bT)
        FirstAid(bT)
    end
)
