-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'
games {'gta5'}

description 'ESX Community Service'

version '1.0.0'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    "config.lua"
}

server_scripts { 
	'@oxmysql/lib/MySQL.lua',
    'server.lua',
}

dependencies {
    "stem_common",
}

client_script 'client.lua'