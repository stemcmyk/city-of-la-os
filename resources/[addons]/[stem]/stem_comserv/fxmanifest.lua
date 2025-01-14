-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'
games {'gta5'}

description 'ESX Community Service'

version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua'
}

server_scripts {
	'@restfx/build/import.lua',
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua',
	"server/api.lua"
}

client_scripts {
	'@es_extended/locale.lua',
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	'config.lua',
	'client/main.lua'
}

dependencies {
    "stem_common",
}


dependency 'es_extended'