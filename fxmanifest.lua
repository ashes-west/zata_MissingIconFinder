fx_version 'cerulean'
games { 'rdr3' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'
author 'Zatarion'
description 'This script checks which items in the `items` database table are missing an associated icon (`.png`) in the inventory image folder (`html/img/items/`).'
version '0.1.0'

client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
    '@oxmysql/lib/MySQL.lua',
}

ui_page "ui/index.html"

files {
    "ui/index.html",
}