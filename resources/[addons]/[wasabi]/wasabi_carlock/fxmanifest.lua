-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Car Lock'
author 'wasabirobby'
version '2.6.0'

shared_scripts { '@ox_lib/init.lua', '@wasabi_bridge/import.lua', 'configuration/*.lua', "@es_extended/imports.lua" }

client_scripts { 'client/client.lua', 'client/functions.lua' }

server_scripts { '@mysql-async/lib/MySQL.lua', 'server/*.lua' }

dependencies { 'mysql-async', 'ox_lib', 'wasabi_bridge' }

escrow_ignore {
  'configuration/*.lua',
  'client/client.lua',
  'server/sv_customize.lua'
}

dependency '/assetpacks'