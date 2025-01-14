-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    '@ox_lib/init.lua',
	'fps_aim.lua',
	"**/client.lua",
	"**/client-utils.lua",
	"mileage.lua",
	"no-gang-shooty-shooty.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
	"**/server.lua"
}

shared_scripts {
	"lib/numbers.lua",
	"lib/table.lua",
	"lib/string.lua",
	"**/config.lua",
	'@es_extended/imports.lua',
	"@ox_lib/init.lua",
	"**/shared.lua"
}

dependencies {
	"stem_common"
}