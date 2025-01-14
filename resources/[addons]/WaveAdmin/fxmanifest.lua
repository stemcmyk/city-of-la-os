-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'cerulean'
game 'gta5'

author 'ayznnn#0667'
description 'The most advanced NUI admin menu!'
version '1.0.0'


client_script {
   "configs/config.lua",
   "framework/**/shared.lua",
   "framework/**/client.lua",
   'client/main.lua',
   'client/functions/utils/*.lua',
   'client/functions/*.lua',
   'client/nui-callbacks.lua',
   'client/toggles.lua',
   'client/events.lua',
   'shared/*.lua',
}

server_script {
   "@mysql-async/lib/MySQL.lua",
   "configs/config.lua",
   "configs/webhooks.lua",
   "framework/**/shared.lua",
   "framework/**/server.lua",
   'server/main.lua',
   'server/toggles.lua',
   'server/admins.lua',
   'server/events.lua',
   'server/reports.lua',
   'server/bans.lua',
   'server/warns.lua',
   'shared/*.lua',
}

ui_page {
   "html/dist/index.html"
}

files {
   "html/dist/index.html",
   "html/dist/js/*.*",
   "html/dist/css/*.*"
}

escrow_ignore {
   "configs/*.lua",
   "framework/**/*.lua",
}

lua54 'yes'

dependencies {
   '/server:6208',
   '/onesync',
}
dependency '/assetpacks'