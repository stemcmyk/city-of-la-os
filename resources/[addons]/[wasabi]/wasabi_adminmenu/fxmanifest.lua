-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Wasabi ESX/QBCore Admin Menu'
author 'wasabirobby'
version '1.1.4'

shared_scripts {'@ox_lib/init.lua', '@wasabi_bridge/import.lua', 'configs/strings.lua', 'configs/config.lua'}

client_scripts {'configs/peds.lua', 'configs/cl_modifyme.lua', 'client/*.lua'}

server_scripts {'@oxmysql/lib/MySQL.lua', 'configs/sv_modifyme.lua','configs/webhooks.lua', 'server/*.lua'}

dependencies {'ox_lib', 'oxmysql', 'wasabi_bridge'}

escrow_ignore {'configs/*.lua'}

dependency '/assetpacks'