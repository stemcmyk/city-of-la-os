-- 
--   ______ _      ______ _____ _______ _____   ____  _   _            _____ 
--  |  ____| |    |  ____/ ____|__   __|  __ \ / __ \| \ | |     /\   / ____|
--  | |__  | |    | |__ | |       | |  | |__) | |  | |  \| |    /  \ | |     
--  |  __| | |    |  __|| |       | |  |  _  /| |  | | . ` |   / /\ \| |     
--  | |____| |____| |___| |____   | |  | | \ \| |__| | |\  |  / ____ \ |____ 
--  |______|______|______\_____|  |_|  |_|  \_\\____/|_| \_| /_/    \_\_____|
-- 
--                   The most advanced fiveM anticheat.
--                        https://electron-ac.com
--


fx_version 'cerulean'
game 'gta5'

author 'Electron Services'
description 'The most advanced fiveM anticheat.'
version '1.0.0'
lua54 'yes'

files {
    "html/**/*",
}

ui_page "html/index.html"

shared_scripts {
    "src/shared/*.lua"
}

client_scripts {
    "src/client/*.lua",
    "src/client/*.js",
}

server_scripts {
    "src/server/*.lua",
    "src/server/*.js",
}

ac "electronac"

data_file "DLC_ITYP_REQUEST" "stream/mads_no_exp_pumps.ytyp"