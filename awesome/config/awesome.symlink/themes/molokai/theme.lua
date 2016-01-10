---------------------------
-- Default awesome theme --
---------------------------

theme = {}

theme.font          = "Terminess Powerline 10"

theme.path = os.getenv('HOME') .. "/.config/awesome/themes/molokai"

theme.wallpaper = os.getenv('HOME') .. "/.wallpaper.jpg" or theme.path .. "/background.png"

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

theme.molokai = molokai

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

theme.tasklist_disable_icon = true

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
-- Icons {{{
theme.icon_ac_01 = theme_path .. "/icons/ac_01.png"
theme.icon_ac = theme_path .. "/icons/ac.png"
theme.icon_arch_10x10 = theme_path .. "/icons/arch_10x10.png"
theme.icon_arch = theme_path .. "/icons/arch.png"
theme.icon_bat_empty_01 = theme_path .. "/icons/bat_empty_01.png"
theme.icon_bat_empty_02 = theme_path .. "/icons/bat_empty_02.png"
theme.icon_bat_full_01 = theme_path .. "/icons/bat_full_01.png"
theme.icon_bat_full_02 = theme_path .. "/icons/bat_full_02.png"
theme.icon_bat_low_01 = theme_path .. "/icons/bat_low_01.png"
theme.icon_bat_low_02 = theme_path .. "/icons/bat_low_02.png"
theme.icon_bluetooth = theme_path .. "/icons/bluetooth.png"
theme.icon_bug_01 = theme_path .. "/icons/bug_01.png"
theme.icon_bug_02 = theme_path .. "/icons/bug_02.png"
theme.icon_cat = theme_path .. "/icons/cat.png"
theme.icon_clock = theme_path .. "/icons/clock.png"
theme.icon_cpu = theme_path .. "/icons/cpu.png"
theme.icon_dish = theme_path .. "/icons/dish.png"
theme.icon_diskette = theme_path .. "/icons/diskette.png"
theme.icon_empty = theme_path .. "/icons/empty.png"
theme.icon_eye_l = theme_path .. "/icons/eye_l.png"
theme.icon_eye_r = theme_path .. "/icons/eye_r.png"
theme.icon_fox = theme_path .. "/icons/fox.png"
theme.icon_fs_01 = theme_path .. "/icons/fs_01.png"
theme.icon_fs_02 = theme_path .. "/icons/fs_02.png"
theme.icon_full = theme_path .. "/icons/full.png"
theme.icon_fwd = theme_path .. "/icons/fwd.png"
theme.icon_half = theme_path .. "/icons/half.png"
theme.icon_info_01 = theme_path .. "/icons/info_01.png"
theme.icon_info_02 = theme_path .. "/icons/info_02.png"
theme.icon_info_03 = theme_path .. "/icons/info_03.png"
theme.icon_mail = theme_path .. "/icons/mail.png"
theme.icon_mem = theme_path .. "/icons/mem.png"
theme.icon_mouse_01 = theme_path .. "/icons/mouse_01.png"
theme.icon_net_down_01 = theme_path .. "/icons/net_down_01.png"
theme.icon_net_down_02 = theme_path .. "/icons/net_down_02.png"
theme.icon_net_down_03 = theme_path .. "/icons/net_down_03.png"
theme.icon_net_up_01 = theme_path .. "/icons/net_up_01.png"
theme.icon_net_up_02 = theme_path .. "/icons/net_up_02.png"
theme.icon_net_up_03 = theme_path .. "/icons/net_up_03.png"
theme.icon_net_wired = theme_path .. "/icons/net_wired.png"
theme.icon_next = theme_path .. "/icons/next.png"
theme.icon_note = theme_path .. "/icons/note.png"
theme.icon_pacman = theme_path .. "/icons/pacman.png"
theme.icon_pause = theme_path .. "/icons/pause.png"
theme.icon_phones = theme_path .. "/icons/phones.png"
theme.icon_play = theme_path .. "/icons/play.png"
theme.icon_plug = theme_path .. "/icons/plug.png"
theme.icon_prev = theme_path .. "/icons/prev.png"
theme.icon_rwd = theme_path .. "/icons/rwd.png"
theme.icon_scorpio = theme_path .. "/icons/scorpio.png"
theme.icon_shroom = theme_path .. "/icons/shroom.png"
theme.icon_spkr_01_high = theme_path .. "/icons/spkr_01_high.png"
theme.icon_spkr_01_low = theme_path .. "/icons/spkr_01_low.png"
theme.icon_spkr_01_med = theme_path .. "/icons/spkr_01_med.png"
theme.icon_spkr_01_mute = theme_path .. "/icons/spkr_01_mute.png"
theme.icon_spkr_02 = theme_path .. "/icons/spkr_02.png"
theme.icon_spkr_03 = theme_path .. "/icons/spkr_03.png"
theme.icon_stop = theme_path .. "/icons/stop.png"
theme.icon_temp = theme_path .. "/icons/temp.png"
theme.icon_test = theme_path .. "/icons/test.png"
theme.icon_usb_02 = theme_path .. "/icons/usb_02.png"
theme.icon_usb = theme_path .. "/icons/usb.png"
theme.icon_wifi_01_high = theme_path .. "/icons/wifi_01_high.png"
theme.icon_wifi_02_high = theme_path .. "/icons/wifi_02_high.png"
theme.icon_wifi_02_low = theme_path .. "/icons/wifi_02_low.png"
theme.icon_wifi_02_med = theme_path .. "/icons/wifi_02_med.png"
-- }}}


theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
