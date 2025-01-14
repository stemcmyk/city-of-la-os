-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

shared_scripts {
    "@ox_lib/init.lua",
    "@es_extended/imports.lua",
}

client_scripts {
    'client.lua',
    'config.lua'
}
server_scripts {
	'@restfx/build/import.lua',
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'config.lua'
}
dependencies {
    "stem_common",
}

