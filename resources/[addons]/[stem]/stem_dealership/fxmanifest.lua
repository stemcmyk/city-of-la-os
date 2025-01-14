-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'stemcmyk'
description 'stem custom dealrership'

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	"@ox_lib/init.lua",
    "config.lua",
	"lib.lua"
}

export "getVehicle"
server_export "getVehicle"

client_scripts {
    'client.lua',
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"ucl/client.lua"
}

server_scripts {
    'server.lua',
	'@oxmysql/lib/MySQL.lua',
	"ucl/server.lua"
}

dependencies {
	'es_extended',
	"stem_common"
}