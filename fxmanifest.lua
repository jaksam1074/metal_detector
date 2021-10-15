version "1.0"

client_scripts {
    'utils/sh_utils.lua',
    'locales/*.lua',

    'sh_config.lua',

    'client/main.lua'
}

server_scripts {
    'utils/sh_utils.lua',
    'locales/*.lua',

    'sh_config.lua',
    'sv_config.lua',

    'server/main.lua',
}

fx_version 'cerulean'
game 'gta5'