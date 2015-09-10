---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "Terminess Powerline 8"

theme.path = "~/.config/awesome/themes/molokai"

theme.wallpaper = theme.path .. "/background.png"

molokai = {}
molokai.bg = "#1b1d1e"
molokai.bg_light = '#808080'
molokai.bg_urgent = "#3F3F3F"
molokai.fg = "#f8f8f2"
molokai.fg_light = "#7e8e91"
molokai.fg_urgent = "#CC9393"
molokai.red = "#D25252"
molokai.green = "#7fb347"
molokai.orange = '#EA7D02'
molokai.purple = '#AF5FFF'
molokai.pink = '#D7005F'
molokai.blue = '#5FD7FF'

-- {{{ Colors
theme.bg_focus  = molokai.bg -- "#1E2320"
theme.bg_minimize = molokai.bg
theme.bg_normal = molokai.bg -- "#3F3F3F"
theme.bg_urgent = molokai.bg_urgent
theme.fg_focus  = molokai.blue -- "#F0DFAF"
theme.fg_minimize   = molokai.fg
theme.fg_normal = molokai.fg
theme.fg_urgent = molokai.fg_urgent

-- }}}

-- {{ Status colors (battery, wifi, etc.)
theme.status_fg_good = molokai.blue
theme.status_fg_okay = molokai.green
theme.status_fg_bad = molokai.red
-- }}

-- {{{ Borders
theme.border_width  = 1
theme.border_normal = molokai.bg
theme.border_focus  = molokai.pink
theme.border_marked = molokai.fg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = molokai.bg_urgent
theme.titlebar_bg_normal = molokai.bg_urgent
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = molokai.fg_urgent

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.menu_height = 15
theme.menu_width  = 150

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"
-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = theme.path .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = theme.path .. "/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = theme.path .. "/triforce-icon.png"
theme.menu_submenu_icon      = theme.path .. "/submenu.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme.path .. "/layouts/tile.png"
theme.layout_tileleft   = theme.path .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.path .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.path .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.path .. "/layouts/fairv.png"
theme.layout_fairh      = theme.path .. "/layouts/fairh.png"
theme.layout_spiral     = theme.path .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.path .. "/layouts/dwindle.png"
theme.layout_max        = theme.path .. "/layouts/max.png"
theme.layout_fullscreen = theme.path .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.path .. "/layouts/magnifier.png"
theme.layout_floating   = theme.path .. "/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme.path .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme.path .. "/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme.path .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme.path .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme.path .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme.path .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme.path .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme.path .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme.path .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme.path .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme.path .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme.path .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme.path .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme.path .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme.path .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme.path .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.path .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.path .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
