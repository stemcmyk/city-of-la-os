-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'

game 'gta5'
author 'ESX-Framework - Linden - KASH'
description 'Official Multicharacter System For ESX Legacy'
version '1.10.5'
lua54 'yes'

loadscreen_manual_shutdown 'yes'

dependencies { 'es_extended', 'esx_context', 'esx_identity', 'illenium-appearance', }

shared_scripts { '@es_extended/imports.lua', '@es_extended/locale.lua', 'locales/*.lua', 'config.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua' }

client_scripts { 'client/*.lua' }

ui_page { 'html/ui.html' }

files { 'html/ui.html', 'html/css/main.css', 'html/js/app.js', 'html/locales/*.js' }
