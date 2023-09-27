os.setlocale(os.getenv("LANG"))

pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local vicious = require("vicious")

-- {{{ Error handling
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors,
  })
end
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
    if in_error then
      return
    end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err),
    })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions

local _, local_config = pcall(require, "local-settings")

local terminal = local_config.terminal or "kitty"
local file_manager = local_config.file_manager or "pcmanfm"
local browser = local_config.browser or "firefox"
local launcher = local_config.launcher or "rofi -show drun"
local theme = local_config.theme or "catppuccin"
local modkey = local_config.modkey or "Mod4"
local layouts = {
  awful.layout.suit.spiral.dwindle,
  awful.layout.suit.tile,
  awful.layout.suit.floating,
}
local clock_format = local_config.clock_format or "%A %d.%m.%Y %H:%M"
local wallpaper = local_config.wallpaper or os.getenv("HOME") .. "/Bilder/wallpaper/pexels-kelly-2688664-scale.jpg"
local wifi_interface = local_config.wifi_interface or nil
local bat_device = local_config.bat_device or nil

beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/" .. theme .. "/theme.lua")
beautiful.wallpaper = wallpaper

awful.layout.layouts = layouts
-- }}}

-- {{{ Bar
-- Create a launcher widget and a main menu
local mytextclock = wibox.widget.textclock(" " .. clock_format)

-- Create a wibox for each screen and add it
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
    local _wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(_wallpaper) == "function" then
      _wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(_wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

  local cpuwidget = wibox.widget.textbox()
  vicious.cache(vicious.widgets.cpu)
  vicious.register(cpuwidget, vicious.widgets.cpu, " $1% ", 5)

  local memwidget = wibox.widget.textbox()
  vicious.cache(vicious.widgets.mem)
  vicious.register(memwidget, vicious.widgets.mem, " 󰍛 $1% ", 5)

  local volwidget = wibox.widget.textbox()
  vicious.cache(vicious.widgets.volume)
  vicious.register(volwidget, vicious.widgets.volume, "  $1% ", 1, { "Master", "-D", "pulse" })

  local wifiwidget = nil
  if wifi_interface ~= nil then
    wifiwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.wifiume)
    vicious.register(wifiwidget, vicious.widgets.volume, " 󰖩 ${link}% ", 1, wifi_interface)
  end

  local batwidget = nil
  if bat_device ~= nil then
    batwidget = wibox.widget.textbox()
    vicious.cache(vicious.widgets.wifiume)
    vicious.register(batwidget, vicious.widgets.volume, " 󰁹 $2% ", 1, bat_device)
  end

  local mylayoutbox = awful.widget.layoutbox(s)
  mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  -- Create a taglist widget
  local mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.noempty,
    buttons = taglist_buttons,
  })

  -- Create a tasklist widget
  local mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  })

  -- Create the wibox
  local mywibox = awful.wibar({ position = "top", screen = s, height = 20 })

  -- Add widgets to the wibox
  mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = 6,
      mytaglist,
    },
    mytasklist, -- Middle widget
    {           -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      spacing = 6,
      batwidget,
      wifiwidget,
      volwidget,
      cpuwidget,
      memwidget,
      mytextclock,
      wibox.widget.systray(),
      mylayoutbox,
    },
  })
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),
  awful.key({ modkey, "Control" }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, "Control" }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),

  -- Standard program
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "x", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key({ modkey }, "r", function()
    awful.spawn(launcher)
  end, { description = "run launcher", group = "launcher" }),
  awful.key({ modkey }, "w", function()
    awful.spawn(browser)
  end, { description = "run firefox", group = "launcher" }),
  awful.key({ modkey }, "e", function()
    awful.spawn(file_manager)
  end, { description = "run file manager", group = "launcher" }),

  -- Volume Keys
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.util.spawn("amixer -q -D pulse sset Master 5%-", false)
  end),
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.util.spawn("amixer -q -D pulse sset Master 5%+", false)
  end),
  awful.key({}, "XF86AudioMute", function()
    awful.util.spawn("amixer -D pulse set Master 1+ toggle", false)
  end),
  -- Media Keys
  awful.key({}, "XF86AudioPlay", function()
    awful.util.spawn("playerctl play-pause", false)
  end),
  awful.key({}, "XF86AudioNext", function()
    awful.util.spawn("playerctl next", false)
  end),
  awful.key({}, "XF86AudioPrev", function()
    awful.util.spawn("playerctl previous", false)
  end)
)

local clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, "Shift" }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ modkey, "Control" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" }),
  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

local clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
--
local function is_terminal(c)
  return (c.class and c.class:match("itty")) and true or false
end

local function copy_size(c, parent_client)
  if not c or not parent_client then
    return
  end
  if not c.valid or not parent_client.valid then
    return
  end
  c.x = parent_client.x
  c.y = parent_client.y
  c.width = parent_client.width
  c.height = parent_client.height
end

local function check_resize_client(c)
  if c.child_resize then
    copy_size(c.child_resize, c)
  end
end

client.connect_signal("property::size", check_resize_client)
client.connect_signal("property::position", check_resize_client)
client.connect_signal("manage", function(c)
  if is_terminal(c) then
    return
  end
  local parent_client = awful.client.focus.history.get(c.screen, 1)
  if parent_client and is_terminal(parent_client) then
    parent_client.child_resize = c
    c.floating = true
    copy_size(c, parent_client)
  end
end)
--
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "DTA",   -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow",   -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",        -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Add titlebars to normal clients and dialogs
  { rule_any = { type = { "normal", "dialog" } }, properties = { titlebars_enabled = false } },

  -- Set Firefox to always map on the tag named "2" on screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  if not awesome.startup then
    awful.client.setslave(c)
  end

  if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c):setup({
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    {   -- Middle
      { -- Title
        align = "center",
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  })
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
-- }}}
