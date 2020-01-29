resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX KUANA_GARAGE'

version '1.0.0'

ui_page "nui/index.html"

files {
	"nui/index.html",
    "nui/oie_transparent.png",
	"nui/ui.js",
   	"nui/gothicb.ttf",
   	"nui/signpainter.ttf",
   	"nui/bootstrap.min.js",
   	"nui/bootstrap.min.css",
	"nui/ui.css",
	"nui/responsive.css"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server.lua'
}
client_script {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client.lua',
	'click.lua'
}

