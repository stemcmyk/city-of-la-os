-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
game 'gta5'
lua54 'yes'

description 'Gang Wars Phone for ESX/QBCore'
author 'Wasabi Scripts'
version '1.0.3'

ui_page 'nui/index.html'
files { 'nui/index.html', 'nui/**/*' }

shared_scripts {
    '@wasabi_bridge/import.lua',
    'configuration/config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'modules/customize/framework/server.lua',
    'modules/customize/gang_systems/**/server.lua',
    'modules/admin/server.lua',
    'modules/data/server.lua',
    'modules/data/updater.lua',
    'modules/open/server.lua',
    'modules/invites/server.lua',
    'modules/notifications/server.lua',
    'modules/player/server.lua',
    'modules/ui/server.lua',
    'modules/wars/server.lua'
}

client_scripts {
    'modules/admin/client.lua',
    'modules/customize/integrations/client.lua',
    'modules/customize/gang_systems/**/client.lua',
    'modules/data/client.lua',
    'modules/open/client.lua',
    'modules/player/client.lua',
    'modules/ui/client.lua',
    'modules/wars/client.lua'
}

dependencies { 'wasabi_bridge' }

escrow_ignore { 'configuration/*.lua', 'modules/customize/**/*.lua', 'modules/customize/gang_systems/**/*.lua' }

dependency '/assetpacks'