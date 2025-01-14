-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

author 'Randolio'
description 'Trucking Job'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
}

client_scripts {
    'bridge/client/**.lua',
    'cl_trucking.lua'
}

server_scripts {
    'bridge/server/**.lua',
    'sv_config.lua',
    'sv_trucking.lua',
}

lua54 'yes'
dependency 'es_extended'