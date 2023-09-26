local beautiful = require("beautiful")

local M = {}

M.load_theme = function(theme_name, wallpaper_path)
    local config_dir = os.getenv("HOME") .. "/.config/awesome"
    local theme_dir = config_dir .. "/themes"

    beautiful.init(theme_dir .. "/" .. theme_name .. "/theme.lua")
    beautiful.wallpaper = wallpaper_path
end

return M
