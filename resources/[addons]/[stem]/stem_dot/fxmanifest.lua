-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'

game 'gta5'

description 'Allows players to RP as a mechanic (repair and modify vehicles)'
lua54 'yes'
version '1.0'
legacyversion '1.9.1'

shared_script {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	"@ox_lib/init.lua",
	'locales/*.lua',
	'config.lua',
}

client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/main.lua'
}

dependencies {
	'es_extended',
	'esx_society',
	'esx_billing'
}
