-- shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

fx_version 'adamant'

game 'gta5'

description 'Provides a way for Jobs to have a society system. (boss menu, salaries, funding etc)'
lua54 'yes'
version '1.0'

shared_script {'@es_extended/imports.lua', "@ox_lib/init.lua"}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
    'config.lua',
    'client/main.lua'
}

export "setBossGradeName"

dependencies {
    'es_extended',
    'cron',
    'esx_addonaccount'
}
