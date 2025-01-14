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

-- ARMOUR TABLES --
-- MALE --
local M_ArmourTable_Bags = {}
local M_ArmourTable_Shirt = {}
local M_ArmourTable_ShirtOverlay = {}
local M_ArmourTable_Armour = {}
local M_ArmourTable_Helmet = {}

-- FEMALE --
local F_ArmourTable_Bags = {}
local F_ArmourTable_Shirt = {}
local F_ArmourTable_ShirtOverlay = {}
local F_ArmourTable_Armour = {}
local F_ArmourTable_Helmet = {}
-- END OF ARMOUR TABLES --

-- EVENTS --
AddEventHandler("c_ShotRegister_GetArmor", function(ped) -- GET ARMOUR PED IS WEARING
	local ped_Parachute = GetPedDrawableVariation(ped, 5)
	local ped_Armour = GetPedDrawableVariation(ped, 9)
	local ped_Shirt = GetPedDrawableVariation(ped, 8)
	local ped_ShirtOver = GetPedDrawableVariation(ped, 11)
	local ped_Helmet = GetPedPropIndex(ped, 0)
	local ta_Shirt
	local ta_ShirtOverlay
	local ta_Armour
	local ta_Parachute
	local ta_Helmet
	if GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") then
		ta_Shirt = M_ArmourTable_Shirt[ped_Shirt]
		ta_ShirtOverlay = M_ArmourTable_ShirtOverlay[ped_ShirtOver]
		ta_Armour = M_ArmourTable_Armour[ped_Armour]
		ta_Parachute = M_ArmourTable_Bags[ped_Parachute]
		ta_Helmet = M_ArmourTable_Helmet[ped_Helmet]
	elseif GetEntityModel(PlayerPedId()) == GetHashKey("mp_f_freemode_01") then
		ta_Shirt = F_ArmourTable_Shirt[ped_Shirt]
		ta_ShirtOverlay = F_ArmourTable_ShirtOverlay[ped_ShirtOver]
		ta_Armour = F_ArmourTable_Armour[ped_Armour]
		ta_Parachute = F_ArmourTable_Bags[ped_Parachute]
		ta_Helmet = F_ArmourTable_Helmet[ped_Helmet]
	end

	local helmet = false
	local hits = 0
	local level = 0

	if ta_Shirt ~= nil then
		hits = hits + ta_Shirt.Hits
		level = ta_Shirt.Level
	end
	if ta_ShirtOverlay ~= nil then
		hits = hits + ta_ShirtOverlay.Hits
		level = ta_ShirtOverlay.Level
	end
	if ta_Parachute ~= nil then
		hits = hits + ta_Parachute.Hits
		level = ta_Parachute.Level
	end
	if ta_Armour ~= nil then
		hits = hits + ta_Armour.Hits
		level = ta_Armour.Level
	end
	if ta_Helmet ~= nil then
		helmet = true
	end

	if hits == 0 then
		TriggerServerEvent("s_ShotRegister_PassArmor", false)
	else
		TriggerServerEvent("s_ShotRegister_PassArmor", true, hits, level, helmet)
		local tts = {}
		tts.hits = hits
		tts.level = level
		tts.helmet = helmet
		TriggerEvent("pCache_SetArmor", true, tts)
	end

	hits = 0
	level = 0
	helmet = false
end)
-- END OF EVENTS --