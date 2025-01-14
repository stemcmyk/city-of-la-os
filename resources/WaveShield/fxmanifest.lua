fx_version 'cerulean'
game 'gta5'

version '4.0.0'
author 'ayznnn#0667'
description 'WaveShield, the best Anti-Cheat that protects you from all cheaters.'
discord 'https://discord.com/invite/CXZwrZx'
website 'https://waveshield.xyz'

lua54 'yes'

ui_page "web/index.html"

client_scripts {
    "resource/waveshield.lua",
    "resource/waveshield.js",
    "resource/client/main.lua",
}

server_scripts {
    "resource/waveshield.lua",
    "resource/waveshield.js",
    "resource/server/exports.lua",
    "resource/server/auth.lua",
}

files {
    "web/index.html"
}

data_file 'DLC_ITYP_REQUEST' 'stream/mads_no_exp_pumps.ytyp'

dependencies {
    "/server:6208",
    "/onesync",
}