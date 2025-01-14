-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
games { 'gta5' }
lua54 "yes"

author 'Caleb B.'
description 'GSWV5'
version 'BRANCH: PUBLIC | VERSION: 0.5.0'


shared_scripts {
	"@ox_lib/init.lua"
}

client_scripts {
	"config.lua",
	"systems/p_BoneEffects.lua",
	"systems/p_Bleedout.lua",
	"systems/p_Cache.lua",
	"systems/p_ShotRegister.lua",
	"systems/c_MiscSettings.lua",
	"systems/FirstAid/p_Bandages.lua",
	"systems/FirstAid/p_BandageHandler.lua",
	"systems/FirstAid/p_Hospitals.lua",
	"systems/FirstAid/p_HospitalEffects.lua",
	"datasets/dataset_Armor.lua",
	"datasets/dataset_Bone.lua",
	"datasets/dataset_Weapon.lua",
	"datasets/dataset_Weapon_Sorting.lua",
}
server_scripts {
	"server/s_EventPasser.lua",
}