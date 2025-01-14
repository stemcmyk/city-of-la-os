-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

--[[ FX Information ]]--
fx_version   'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game         'gta5'

--[[ Resource Information ]]--
name         'stem_assist'
version      '1.0'
license      'GPL-3.0-or-later'
author       'stem'

--[[ Manifest ]]--
shared_scripts {
	"@es_extended/imports.lua",
	'@ox_lib/init.lua',
	'config.lua',
}

client_scripts {
	'client/main.lua',
	'client/utils.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua',
}

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
	"locales/*.json"
}

dependencies {
	'oxmysql',
	'ox_lib',
    "stem_common",
}


ox_libs {
    'locale',
    'table',
}
