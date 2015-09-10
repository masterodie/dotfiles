-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Redshift integration
local redshift = require("redshift")
--Viious widgets
local vicious = require("vicious")
local tyrannical = require("tyrannical")


-- {{{ Functions
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

--- Spawns cmd if no client can be found matching properties
-- If such a client can be found, pop to first tag where it is visible, and give it focus
-- @param cmd the command to execute
-- @param properties a table of properties to match against clients.  Possible entries: any properties of the client object
function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match_client(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if #ctags == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match_client(table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

function get_conky()
    local clients = client.get()
    local conky = nil
    local i = 1
    while clients[i]
    do
        if clients[i].class == "conky"
        then
            conky = clients[i]
        end
        i = i + 1
    end
    return conky
end
function raise_conky()
    local conky = get_conky()
    if conky
    then
        conky.ontop = true
    end
end
function lower_conky()
    local conky = get_conky()
    if conky
    then
        conky.ontop = false
    end
end
function toggle_conky()
    local conky = get_conky()
    if conky
    then
        if conky.ontop
        then
            conky.ontop = false
        else
            conky.ontop = true
        end
    end
end
-- }}}



-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}


-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
theme_name = 'molokai'
theme_path = awful.util.getdir('config') .. "/themes/" .. theme_name
beautiful.init(theme_path .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
browser = 'firefox'
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Redshift
redshift.redshift = "/usr/bin/redshift"
redshift.init(1)

-- Table of layouts to cover with awful.layout.inc, order matters.
-- All possible layouts:
    --awful.layout.suit.floating
    --awful.layout.suit.tile
    --awful.layout.suit.tile.left
    --awful.layout.suit.tile.bottom
    --awful.layout.suit.tile.top
    --awful.layout.suit.fair
    --awful.layout.suit.fair.horizontal
    --awful.layout.suit.spiral
    --awful.layout.suit.spiral.dwindle
    --awful.layout.suit.max
    --awful.layout.suit.max.fullscreen
    --awful.layout.suit.magnifier
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
-- Each screen has its own tag table.
--


-- First, set some settings
tyrannical.settings.default_layout =  awful.layout.suit.tile.left
tyrannical.settings.mwfact = 0.66

-- Setup some tags
tyrannical.tags = {
    {
        name        = "web",
        init        = true,
        exclusive   = true,
      --icon        = "~net.png",                 -- Use this icon for the tag (uncomment with a real path)
        screen      = screen.count()>1 and 2 or 1,-- Setup on screen 2 if there is more than 1 screen, else on screen 1
        layout      = awful.layout.suit.max,      -- Use the max layout
        class = {
            "Opera"         , "Firefox"        , "Rekonq"    , "Dillo"        , "Arora",
            "Chromium"      , "nightly"        , "minefield"     }
    } ,
    {
        name = "dev",
        init        = true,
        exclusive   = true,
        screen      = 1,
        clone_on    = 2, -- Create a single instance of this tag on screen 1, but also show it on screen 2
                         -- The tag can be used on both screen, but only one at once
        layout      = awful.layout.suit.tile,
        mwfact      = 0.66,
        class ={
            "Kate", "KDevelop", "Codeblocks", "Code::Blocks" , "DDD", "kate4", "vim", "gvim", "urxvt:dev" }
    } ,
    {
        name        = "media",
        init        = true, -- This tag wont be created at startup, but will be when one of the
                             -- client in the "class" section will start. It will be created on
                             -- the client startup screen
        exclusive   = true,
        layout      = awful.layout.suit.max,
        class       = {
            "urxvt:media", "Xephyr"                                        }
    } ,
    {
        name        = "system",                 -- Call the tag "Term"
        init        = true,                   -- Load the tag on startup
        exclusive   = true,                   -- Refuse any other type of clients (by classes)
        screen      = {1,2},                  -- Create this tag on screen 1 and screen 2
        layout      = awful.layout.suit.tile, -- Use the tile layout
        selected    = true,
        class       = { --Accept the following classes, refuse everything else (because of "exclusive=true")
            "xterm" , "urxvt" , "aterm","URxvt","XTerm","konsole","terminator","gnome-terminal", "conky", "urxvt:system"
        }
    } ,
    {
        name        = "misc",
        init        = true, -- This tag wont be created at startup, but will be when one of the
                             -- client in the "class" section will start. It will be created on
                             -- the client startup screen
        exclusive   = true,
        layout      = awful.layout.suit.max,
        class       = {
            "Assistant"     , "Okular"         , "Evince"    , "EPDFviewer"   , "xpdf",
            "Xpdf"          ,                                        }
    } ,
}

-- Ignore the tag "exclusive" property for the following clients (matched by classes)
tyrannical.properties.intrusive = {
    "ksnapshot"     , "pinentry"       , "gtksu"     , "kcalc"        , "xcalc"               ,
    "feh"           , "Gradient editor", "About KDE" , "Paste Special", "Background color"    ,
    "kcolorchooser" , "plasmoidviewer" , "kruler"       , "plasmaengineexplorer",
    "mpv",
}

-- Ignore the tiled layout for the matching clients
tyrannical.properties.floating = {
    "MPlayer"      , "pinentry"        , "ksnapshot"  , "pinentry"     , "gtksu"          ,
    "xine"         , "feh"             , "kmix"       , "kcalc"        , "xcalc"          ,
    "yakuake"      , "Select Color$"   , "kruler"     , "kcolorchooser", "Paste Special"  ,
    "New Form"     , "Insert Picture"  , "kcharselect", "mythfrontend" , "plasmoidviewer"
}

-- Make the matching clients (by classes) on top of the default layout
tyrannical.properties.ontop = {
    "Xephyr"       , "ksnapshot"       , "kruler"
}

-- Force the matching clients (by classes) to be centered on the screen on init
tyrannical.properties.centered = {
    "kcalc"
}

-- Do not honor size hints request for those classes
tyrannical.properties.size_hints_honor = { xterm = false, URxvt = false, aterm = false, sauer_client = false, mythfrontend  = false}

tyrannical.properties.no_autofocus = { "mpv" }
tyrannical.properties.sticky = { "mpv" }

--
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- {{{ Widgets

my_widgets = {
    width = 6,
    height = 10,
    vertical = true,
    color = {
        bg = beautiful.bg_normal,
        fg = molokai.fg_light,
        border = nil,
        good = beautiful.status_fg_good,
        okay = beautiful.status_fg_okay,
        bad = beautiful.status_fg_bad,
        gradient = function (from, to)
            return {type="linear", from = {0, from}, to = {0, to}, stops = { {0,my_widgets.color.bad}, {0.2, my_widgets.color.okay}, {1.0, my_widgets.color.good} } }
        end,
    },
    margin = { top = 4, bottom = 4, left = 2, right = 2},
    box = function (widget)
        margin = wibox.layout.margin()
        margin:set_left(my_widgets.margin.left)
        margin:set_right(my_widgets.margin.right)
        margin:set_top(my_widgets.margin.top)
        margin:set_bottom(my_widgets.margin.bottom)
        margin:set_widget(widget)
        return margin
    end,
    progressbar = function (direction)
        bar = awful.widget.progressbar()
        bar:set_width(my_widgets.width)
        bar:set_height(my_widgets.height)
        bar:set_vertical(my_widgets.vertical)
        bar:set_background_color(my_widgets.color.bg)
        bar:set_border_color(my_widgets.color.border)
        color = my_widgets.color.okay
        if direction == "up" then color = my_widgets.color.gradient(0, 10)
        elseif direction == "down" then color = my_widgets.color.gradient(10,0)
        end
        bar:set_color(color)
        return bar
    end,
    markup = function(string) return "<span color='" .. my_widgets.color.fg .. "'>".. string .. "</span>" end,
    text = function(string)
        if not string then string = "" end
        text = wibox.widget.textbox()
        text:set_markup(my_widgets.markup(string))
        return text
    end,
    separator = function()
        separator = my_widgets.text("|")
        return separator
    end,
    icon_path = function(image)
        return theme_path .. '/icons/' .. image
    end,
    icon = function(image)
        icon = wibox.widget.imagebox()
        icon:set_image(my_widgets.icon_path(image))
        return icon
    end,
}

-- {{{ alsa
local alsa_widget =
{
	channel = "Master",
	step = "5%",
	colors =
	{
        unmute = my_widgets.color.gradient(0, 10),
		mute = my_widgets.color.bad
	},
	mixer = terminal .. " -e alsamixer", -- or whatever your preferred sound mixer is
	notifications =
	{
		icons =
		{
			-- the first item is the 'muted' icon
			"/usr/share/icons/gnome/48x48/status/audio-volume-muted.png",
			-- the rest of the items correspond to intermediate volume levels - you can have as many as you want (but must be >= 1)
			"/usr/share/icons/gnome/48x48/status/audio-volume-low.png",
			"/usr/share/icons/gnome/48x48/status/audio-volume-medium.png",
			"/usr/share/icons/gnome/48x48/status/audio-volume-high.png"
		},
		font = "Inconsolata 11", -- must be a monospace font for the bar to be sized consistently
		icon_size = 48,
		bar_size = 8 -- adjust to fit your font if the bar doesn't fit
	}
}
-- widget
alsa_widget.bar = my_widgets.progressbar('up')
alsa_widget.bar:buttons(awful.util.table.join (
	awful.button ({}, 1, function()
		awful.util.spawn (alsa_widget.mixer)
	end),
	awful.button ({}, 3, function()
                -- You may need to specify a card number if you're not using your main set of speakers.
                -- You'll have to apply this to every call to 'amixer sset'.
                -- awful.util.spawn ("amixer sset -c " .. yourcardnumber .. " " .. alsa_widget.channel .. " toggle")
		awful.util.spawn ("amixer sset " .. alsa_widget.channel .. " toggle")
		vicious.force ({ alsa_widget.bar })
	end),
	awful.button ({}, 4, function()
		awful.util.spawn ("amixer sset " .. alsa_widget.channel .. " " .. alsa_widget.step .. "+")
		vicious.force ({ alsa_widget.bar })
	end),
	awful.button ({}, 5, function()
		awful.util.spawn ("amixer sset " .. alsa_widget.channel .. " " .. alsa_widget.step .. "-")
		vicious.force ({ alsa_widget.bar })
	end)
))
-- tooltip
alsa_widget.text = my_widgets.text("Vol:")
alsa_widget.icon = my_widgets.icon('spkr_01.png')
alsa_widget.tooltip = awful.tooltip ({ objects = { alsa_widget.bar, alsa_widget.text, alsa_widget.icon } })
-- naughty notifications
alsa_widget._current_level = 0
alsa_widget._muted = false
function alsa_widget:notify ()
	local preset =
	{
		height = 75,
		width = 300,
		font = alsa_widget.notifications.font
	}
	local i = 1;
	while alsa_widget.notifications.icons[i + 1] ~= nil
	do
		i = i + 1
	end
	if i >= 2
	then
		preset.icon_size = alsa_widget.notifications.icon_size
		if alsa_widget._muted or alsa_widget._current_level == 0
		then
			preset.icon = alsa_widget.notifications.icons[1]
		elseif alsa_widget._current_level == 100
		then
			preset.icon = alsa_widget.notifications.icons[i]
		else
			local int = math.modf (alsa_widget._current_level / 100 * (i - 1))
			preset.icon = alsa_widget.notifications.icons[int + 2]
		end
	end
	if alsa_widget._muted
	then
		preset.title = alsa_widget.channel .. " - Muted"
	elseif alsa_widget._current_level == 0
	then
		preset.title = alsa_widget.channel .. " - 0% (muted)"
		preset.text = "[" .. string.rep (" ", alsa_widget.notifications.bar_size) .. "]"
	elseif alsa_widget._current_level == 100
	then
		preset.title = alsa_widget.channel .. " - 100% (max)"
		preset.text = "[" .. string.rep ("|", alsa_widget.notifications.bar_size) .. "]"
	else
		local int = math.modf (alsa_widget._current_level / 100 * alsa_widget.notifications.bar_size)
		preset.title = alsa_widget.channel .. " - " .. alsa_widget._current_level .. "%"
		preset.text = "[" .. string.rep ("|", int) .. string.rep (" ", alsa_widget.notifications.bar_size - int) .. "]"
	end
	if alsa_widget._notify ~= nil
	then

		alsa_widget._notify = naughty.notify (
		{
			replaces_id = alsa_widget._notify.id,
			preset = preset
		})
	else
		alsa_widget._notify = naughty.notify ({ preset = preset })
	end
end
-- register the widget through vicious
vicious.register (alsa_widget.bar, vicious.widgets.volume, function (widget, args)
	alsa_widget._current_level = args[1]
	if args[2] == "♩"
	then
		alsa_widget._muted = true
		alsa_widget.tooltip:set_text (" [Muted] ")
		widget:set_color (alsa_widget.colors.mute)
		return 100
	end
	alsa_widget._muted = false
	alsa_widget.tooltip:set_text (" " .. alsa_widget.channel .. ": " .. args[1] .. "% ")
	widget:set_color (alsa_widget.colors.unmute)
	return args[1]
end, 5, alsa_widget.channel) -- relatively high update time, use of keys/mouse will force update
alsa_widget.box = my_widgets.box(alsa_widget.bar)
-- }}}
-- {{{ battery
battery_widget = {}
battery_widget.battery = "BAT0"
battery_widget.text = my_widgets.text('Bat:')
battery_widget.icon = my_widgets.icon('bat_full_01.png')
battery_widget.bar = my_widgets.progressbar('down')
battery_widget.tooltip = awful.tooltip ({ objects = { battery_widget.bar, battery_widget.text, battery_widget.icon } })

battery_widget.box = wibox.layout.margin(battery_widget.bar, 2, 2, 5, 5)
-- Register widget.bar
vicious.register(battery_widget.bar, vicious.widgets.bat, function(widget, args)
    status = ""
    if args[1] == "-" then
        status = "discharging"
    elseif args[1] == "+" then
        status = 'charging'
    elseif args[1] == "↯" then
        status = 'charged'
    end

    battery_widget.tooltip:set_markup(

        " <b>[ " .. status .. "  ]]</b> \n " .. args[2] .. "% charged "
        )
    return args[2]
end, 30, battery_widget.battery)
-- }}}

-- }}}



-- {{{ Wibox
-- Initialize widget
datewidget = my_widgets.text()
-- Register widget
vicious.register(datewidget, vicious.widgets.date, my_widgets.markup("%d %b %Y %H:%M"), 60)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", screen = s, height = 20 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(wibox.widget.systray())
        right_layout:add(my_widgets.separator())
    end
    right_layout:add(battery_widget.icon)
    right_layout:add(battery_widget.box)
    right_layout:add(my_widgets.separator())
    right_layout:add(alsa_widget.icon)
    right_layout:add(alsa_widget.box)
    right_layout:add(my_widgets.separator())
    right_layout:add(datewidget)
    right_layout:add(my_widgets.separator())
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    awful.key({ modkey },            "n",     function ()  run_or_raise('firefox', { class = "Firefox" }) end),
    awful.key({ modkey, },            "y",     function ()  run_or_raise(terminal .. ' -e mux start default', { name = "tmux - system" }) end),
    awful.key({ modkey, },            "x",     function ()  run_or_raise(terminal .. ' -e mux start nhweb', { name = "tmux - nhweb" }) end),
    awful.key({ modkey, },            "c",     function ()  run_or_raise(terminal .. ' -e mux start coding', { name = "tmux - coding" }) end),

    -- dmenu
    -- Run or raise applications with dmenu
    awful.key({ modkey }, "r", function ()
        local f_reader = io.popen( "dmenu_path | dmenu -b -nb '".. beautiful.bg_normal .."' -nf '".. beautiful.fg_normal .."' -sb '#955'")
        local command = assert(f_reader:read('*a'))
        f_reader:close()
        if command == "" then return end
        run_or_raise(command, { name = command } )
    end),
    -- Run or raise applications with dmenu with elevated privileges
    awful.key({ modkey , "Shift"}, "r", function ()
        local f_reader = io.popen( "dmenu_path | dmenu -i -nb '".. beautiful.bg_urgent .."' -nf '".. beautiful.fg_urgent .."' -sb '#955'")
        local command = assert(f_reader:read('*a'))
        f_reader:close()
        if command == "" then return end
        awful.util.spawn("gksudo " .. command)
    end),

    -- Prompt
    awful.key({ modkey, "Control" },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey, 'Control' }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Toggle redshift
    awful.key({ modkey }, "d", redshift.toggle),

    awful.key({ }, "XF86AudioRaiseVolume", function ()
        awful.util.spawn("amixer sset " .. alsa_widget.channel .. " " .. alsa_widget.step .. "+")
        vicious.force({ alsa_widget.bar })
        alsa_widget.notify()
    end),
    awful.key({ }, "XF86AudioLowerVolume", function ()
        awful.util.spawn("amixer sset " .. alsa_widget.channel .. " " .. alsa_widget.step .. "-")
        vicious.force({ alsa_widget.bar })
        alsa_widget.notify()
    end),
    awful.key({ }, "XF86AudioMute", function ()

        awful.util.spawn("amixer sset " .. alsa_widget.channel .. " toggle")
        -- The 2 following lines were needed at least on my configuration, otherwise it would get stuck muted
        -- However, if the channel you're using is "Speaker" or "Headpphone"
        -- instead of "Master", you'll have to comment out their corresponding line below.
        awful.util.spawn("amixer sset " .. "Speaker" .. " unmute")
        awful.util.spawn("amixer sset " .. "Headphone" .. " unmute")
        vicious.force({ alsa_widget.bar })
        alsa_widget.notify()
    end),
    awful.key({}, "Insert", function() raise_conky() end, function() lower_conky() end),
    awful.key({}, "Pause", function() toggle_conky() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
            awful.tag.viewonly(tag)
        end
    end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
        local screen = mouse.screen
        local tag = awful.tag.gettags(screen)[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag then
            awful.client.movetotag(tag)
        end
    end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
        local tag = awful.tag.gettags(client.focus.screen)[i]
        if client.focus and tag then
            awful.client.toggletag(tag)
        end
    end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        honor_size_hints = false,
        buttons = clientbuttons } },
    { rule = { class = "mpv" },
    properties = {
        floating = false,
        nofocus = true,
        focusable = false,
        slave = true,
        no_autofocus = true,
        callback = awful.client.setslave } },
    { rule = { class = "MPlayer" },
        properties = { floating = true } },
    { rule = { class = "pinentry" },
        properties = { floating = true } },
    { rule = { class = "gimp" },
        properties = { floating = true } },
    {
        rule = { name = "tmux - system"  },
        callback = function(c)
            awful.client.property.set(c, "overwrite_class", "urxvt:system")
        end
    },
    {
        rule = { name = "tmux - youtube"  },
        callback = function(c)
            awful.client.property.set(c, "overwrite_class", "urxvt:media")
        end
    },
    {
        rule = { name = "tmux - nhweb"  },
        callback = function(c)
            awful.client.property.set(c, "overwrite_class", "urxvt:dev")
        end
    },
    { rule = { class = "conky" },
        properties = {
                floating = true,
                sticky = true,
                ontop = false,
                focusable = false,
                size_hints = {"program_position", "program_size"}
      } }
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--{{{ Autostart
run_once("xrdb -load ~/.Xresources")
run_once("xscreensaver -no-splash")
run_once("cairo-compmgr")
run_once("conky")
run_once("lightsOn 300")
--
--}}}
--
--vim: ft=lua tw=4
