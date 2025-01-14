-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version "cerulean"
game "common"

name "httpmanager"
author "kibukj"
description "HTTP handler library for FiveM and RedM"
repository "https://github.com/kibook/httpmanager"

server_scripts {
	"url.lua",
	"mime.lua",
	"base64.lua",
	"hash.lua",
	"realms.lua",
	"httphandler.lua",
	"main.lua"
}
