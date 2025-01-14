-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
games {'gta5'}
author 'ilyaas#5276'

client_script 'cl_weaponNames.lua'

files {
	"**/weaponcomponents.meta",
	"**/weaponarchetypes.meta",
	"**/weaponanimations.meta",
	"**/pedpersonality.meta",
	"**/weapons.meta",
}

data_file "EXPLOSIONFX_FILE" "metas/explosionfx.dat"
data_file "WEAPONCOMPONENTSINFO_FILE" "**/weaponcomponents.meta"
data_file "WEAPON_METADATA_FILE" "**/weaponarchetypes.meta"
data_file "WEAPON_ANIMATIONS_FILE" "**/weaponanimations.meta"
data_file "PED_PERSONALITY_FILE" "**/pedpersonality.meta"
data_file "WEAPONINFO_FILE" "**/weapons.meta"
data_file "DLC_ITYP_REQUEST" "stream/shield.ytyp"

files {
	"weaponry/*.meta"
}
data_file 'WEAPONINFO_FILE_PATCH' 'weaponry/*.meta'
