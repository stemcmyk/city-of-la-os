-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'

game 'gta5'
author 'ESX-Framework'
version '1.10.5'
description 'ESX TextUI'
lua54 'yes'

client_scripts { 'TextUI.lua' }
shared_script '@es_extended/imports.lua'
ui_page 'nui/index.html'

files {
    'nui/index.html',
    'nui/js/*.js',
    'nui/css/*.css'
}
