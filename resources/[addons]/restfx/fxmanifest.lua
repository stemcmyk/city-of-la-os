shared_script '@WaveShield/resource/waveshield.js' --this line was automatically written by WaveShield

-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
games { 'gta5' }

author '5m1Ly'
description 'Easly built restfull apis for you fx server.'
version 'v1.0.0'

server_only 'yes'

-- load the RestFX library
server_scripts {
	"conf/*.lua",
	"build/modules/*.js",
	"build/modules/*.lua",
	"build/*.lua",
	"build/routes/*.lua"
}