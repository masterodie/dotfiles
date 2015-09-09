---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "Inconsolata for Powerline 8"

theme.path = "~/.config/awesome/themes/molokai"

theme.wallpaper = theme.path .. "/background.png"



local MOLOKAI_PINK = '#D7005F'
local MOLOKAI_ORANGE = '#EA7D02'
local MOLOKAI_PURPLE = '#AF5FFF'
local MOLOKAI_GREEN = '#87FF00'
local MOLOKAI_BLUE = '#5FD7FF'
local MOLOKAI_BG = '#1B1D1E'
local MOLOKAI_BG_LIGHT = '#808080'
local MOLOKAI_FG = "#F8F8F2"
local MOLOKAI_FG_MUTED = "#75715E"
local MOLOKAI_URGENT = "#CC9393"
local MOLOKAI_URGENT_BG = "#3F3F3F"

theme.font = AWESOME_FONT

-- {{{ Colors
theme.bg_focus  = MOLOKAI_BG -- "#1E2320"
theme.bg_minimize = MOLOKAI_BG
theme.bg_normal = MOLOKAI_BG -- "#3F3F3F"
theme.bg_urgent = MOLOKAI_URGENT_BG
theme.fg_focus  = MOLOKAI_BLUE -- "#F0DFAF"
theme.fg_minimize   = MONOKAI_FG
theme.fg_normal = MOLOKAI_FG
theme.fg_urgent = MOLOKAI_URGENT

-- }}}

-- {{ Status colors (battery, wifi, etc.)
theme.status_fg_good = MOLOKAI_BLUE
theme.status_fg_okay = MOLOKAI_GREEN
theme.status_fg_bad = MOLOKAI_ORANGE
-- }}

-- {{{ Borders
theme.border_width  = 1
theme.border_normal = MOLOKAI_URGENT_BG
theme.border_focus  = MOLOKAI_PINK
theme.border_marked = MOLOKAI_URGENT
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = MOLOKAI_URGENT_BG
theme.titlebar_bg_normal = MOLOKAI_URGENT_BG
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = MOLOKAI_URGENT

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
