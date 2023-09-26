os.setlocale(os.getenv("LANG"))

pcall(require, "luarocks.loader")

local theme = "catppuccin"
local wallpaper = os.getenv("HOME") .. "/Bilder/wallpaper/pexels-kelly-2688664-scale.jpg"

require("error_handling")
require('theme').load_theme(theme, wallpaper)
require('client')
require('bar')
require('bindings')

