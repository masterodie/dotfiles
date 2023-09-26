pcall(require, "luarocks.loader")

os.setlocale(os.getenv("LANG"))

local vicious = require("vicious")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.hotkeys_popup.keys")

local modkey = require("modkey").modkey
local bar_height = 20

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    local cpuwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.cpu)
    vicious.register(cpuwidget, vicious.widgets.cpu, " $1% ", 5)

    local memwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.mem)
    vicious.register(memwidget, vicious.widgets.mem, " 󰍛 $1% ", 5)

    local volwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.volume)
    vicious.register(volwidget, vicious.widgets.volume, "  $1% ", 1, { "Master", "-D", "pulse" })
    --
    -- Create a taglist widget
    local taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
    })

    -- Create a tasklist widget
    local tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    })

    -- Create the wibox
    local bar = awful.wibar({ position = "top", screen = s, height = bar_height })

    -- Add widgets to the wibox
    bar:setup({
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 3,
            taglist,
        },
        tasklist, -- Middle widget
        {             -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 3,
            volwidget,
            cpuwidget,
            memwidget,
            wibox.widget.textclock(" %A %d.%m.%Y %H:%M"),
            wibox.widget.systray(),
            awful.widget.layoutbox(s),
        },
    })
end)
