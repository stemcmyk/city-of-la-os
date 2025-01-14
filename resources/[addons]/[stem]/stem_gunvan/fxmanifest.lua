-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'
game 'gta5'
lua54 'yes'

description 'ESX Weapon Shop'

version '1.1.0'

shared_scripts { 
    '@es_extended/imports.lua',
	'@es_extended/locale.lua',
    "@ox_lib/init.lua",
    'locales/*.lua',
	'config.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/EntityZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
	"@PolyZone/CircleZone.lua",
	'client.lua'
}

dependency 'es_extended'
