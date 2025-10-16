fx_version 'cerulean'

game 'gta5'

lua54 'yes'

client_scripts {
    'src/client.lua'
}

shared_scripts {
    'shared/Config.lua',
    '@ox_lib/init.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/script.js',
    'web/style.css',
}