-- Key bindings  (was: conf/keybindings/fr.conf -- "Default", AZERTY)
-- See https://wiki.hypr.land/Configuring/Basics/Binds/ and .../Dispatchers/

local mod = "SUPER"
local HYPRSCRIPTS = "~/.config/hypr/scripts"
local SCRIPTS = "~/.config/ml4w/scripts"

-- Applications
hl.bind(
	mod .. " + RETURN",
	hl.dsp.exec_cmd("~/.config/ml4w/settings/terminal.sh"),
	{ description = "Open the terminal" }
)
hl.bind(mod .. " + B", hl.dsp.exec_cmd("~/.config/ml4w/settings/browser.sh"), { description = "Open the browser" })
hl.bind(
	mod .. " + E",
	hl.dsp.exec_cmd("~/.config/ml4w/settings/filemanager.sh"),
	{ description = "Open the filemanager" }
)
hl.bind(
	mod .. " + SHIFT + E",
	hl.dsp.exec_cmd("~/.config/ml4w/settings/emojipicker.sh"),
	{ description = "Open the emoji picker" }
)
hl.bind(
	mod .. " + SHIFT + C",
	hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"),
	{ description = "Open the calculator" }
)

-- Display zoom
hl.bind(
	mod .. " + CTRL + mouse_down",
	hl.dsp.exec_cmd(
		[[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")]]
	),
	{ description = "Increase display zoom" }
)
hl.bind(
	mod .. " + CTRL + mouse_up",
	hl.dsp.exec_cmd(
		[[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")]]
	),
	{ description = "Decrease display zoom" }
)
hl.bind(
	mod .. " + CTRL + Z",
	hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1"),
	{ description = "Reset display zoom" }
)

-- Windows
hl.bind(mod .. " + Q", hl.dsp.window.close(), { description = "Kill active window" })
hl.bind(
	mod .. " + CTRL + Q",
	hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"),
	{ description = "Quit active window and all instances" }
)
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), { description = "Fullscreen" })
hl.bind(mod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }), { description = "Maximize window" })
hl.bind(mod .. " + T", hl.dsp.window.float(), { description = "Toggle floating" })
-- NOTE: old `workspaceopt allfloat` has no documented Lua dispatcher; fallback via hyprctl, review if needed.
hl.bind(
	mod .. " + CTRL + T",
	hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allfloat"),
	{ description = "Toggle all windows floating" }
)
hl.bind(mod .. " + left", hl.dsp.focus({ direction = "l" }), { description = "Move focus left" })
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "r" }), { description = "Move focus right" })
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "u" }), { description = "Move focus up" })
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "d" }), { description = "Move focus down" })
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window with mouse" })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window with mouse" })
hl.bind(
	mod .. " + CTRL + right",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ description = "Increase window width" }
)
hl.bind(
	mod .. " + CTRL + left",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ description = "Reduce window width" }
)
hl.bind(
	mod .. " + CTRL + down",
	hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
	{ description = "Increase window height" }
)
hl.bind(
	mod .. " + CTRL + up",
	hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
	{ description = "Reduce window height" }
)
hl.bind(
	mod .. " + semicolon",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ description = "Reduce window width" }
)
hl.bind(
	mod .. " + colon",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ description = "Increase window width" }
)
hl.bind(mod .. " + G", hl.dsp.group.toggle(), { description = "Toggle window group" })
hl.bind(mod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }), { description = "Swap tiled window left" })
hl.bind(mod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }), { description = "Swap tiled window right" })
hl.bind(mod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }), { description = "Swap tiled window up" })
hl.bind(mod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }), { description = "Swap tiled window down" })
-- Move active window in a direction (tiled: relayout, floating: reposition).
hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }), { description = "Move window left" })
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }), { description = "Move window right" })
hl.bind(mod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }), { description = "Move window up" })
hl.bind(mod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }), { description = "Move window down" })
hl.bind("ALT + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end, { repeating = true, description = "Cycle between windows" })

-- Actions
hl.bind(mod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"), { description = "Reload Hyprland configuration" })
hl.bind(
	mod .. " + CTRL + A",
	hl.dsp.exec_cmd(HYPRSCRIPTS .. "/toggle-animations.sh"),
	{ description = "Toggle animations" }
)
hl.bind(mod .. " + Print", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"), { description = "Take a screenshot" })
hl.bind(mod .. " + CTRL + S", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/screenshot.sh"), { description = "Take a screenshot" })
hl.bind(mod .. " + P", hl.dsp.exec_cmd("/usr/bin/gradia --screenshot"), { description = "Screenshot with Gradia" })
hl.bind(
	mod .. " + SHIFT + Q",
	hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-wlogout.sh"),
	{ description = "Start wlogout" }
)
hl.bind(mod .. " + CTRL + W", hl.dsp.exec_cmd("waypaper --random"), { description = "Change the wallpaper" })
hl.bind(mod .. " + SHIFT + W", hl.dsp.exec_cmd("waypaper"), { description = "Open wallpaper selector" })
hl.bind(
	mod .. " + SHIFT + RETURN",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/launcher.sh"),
	{ description = "Open application launcher" }
)
hl.bind(mod .. " + SHIFT + K", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/keybindings.sh"), { description = "Show keybindings" })
hl.bind(mod .. " + CTRL + B", hl.dsp.exec_cmd("~/.config/waybar/launch.sh"), { description = "Reload waybar" })
hl.bind(mod .. " + SHIFT + B", hl.dsp.exec_cmd("~/.config/waybar/toggle.sh"), { description = "Toggle waybar" })
hl.bind(
	mod .. " + CTRL + R",
	hl.dsp.exec_cmd(HYPRSCRIPTS .. "/loadconfig.sh"),
	{ description = "Reload hyprland config" }
)
hl.bind(mod .. " + V", hl.dsp.exec_cmd(SCRIPTS .. "/ml4w-cliphist"), { description = "Open clipboard manager" })
hl.bind(mod .. " + asterisk", hl.dsp.exec_cmd(SCRIPTS .. "/ml4w-cliphist"), { description = "Open clipboard manager" })
hl.bind(
	mod .. " + SHIFT + T",
	hl.dsp.exec_cmd("~/.config/waybar/themeswitcher.sh"),
	{ description = "Open waybar theme switcher" }
)
hl.bind(mod .. " + ALT + G", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/gamemode.sh"), { description = "Toggle game mode" })
hl.bind(mod .. " + SHIFT + L", hl.dsp.exec_cmd("~/.config/hypr/scripts/power.sh lock"), { description = "Lock screen" })
hl.bind(mod .. " + CTRL + H", hl.dsp.exec_cmd(HYPRSCRIPTS .. "/hyprshade.sh"), { description = "Launch Hyprshade" })

hl.bind(mod .. " + W", hl.dsp.exec_cmd("~/.local/bin/set-default-browser"))
-- Sidepad (moved off SHIFT+arrows, which now move windows)
hl.bind(mod .. " + A", hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-sidepad"), { description = "Open Sidepad" })
hl.bind(
	mod .. " + SHIFT + A",
	hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-sidepad --hide"),
	{ description = "Close Sidepad" }
)
hl.bind(
	mod .. " + CTRL + P",
	hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-sidepad --init"),
	{ description = "Init Sidepad" }
)
hl.bind(
	mod .. " + ALT + A",
	hl.dsp.exec_cmd("~/.config/ml4w/scripts/ml4w-sidepad --select"),
	{ description = "Select Sidepad" }
)

-- Scratchpad (special workspace "magic")
hl.bind(mod .. " + Z", hl.dsp.workspace.toggle_special("magic"), { description = "Toggle scratchpad" })
hl.bind(
	mod .. " + SHIFT + Z",
	hl.dsp.window.move({ workspace = "special:magic" }),
	{ description = "Move window to scratchpad" }
)

hl.bind(mod .. " + S ", hl.dsp.exec_cmd("~/.local/bin/switch-audio-output"))

-- Workspaces (AZERTY top-row keysyms). For SHIFT binds Hyprland matches the
-- unshifted base keysym, which on fr is the symbol (not the digit) -- so all
-- three binds use the symbols.
local wsKeys = {
	"ampersand",
	"eacute",
	"quotedbl",
	"apostrophe",
	"parenleft",
	"minus",
	"egrave",
	"underscore",
	"ccedilla",
	"agrave",
}
for i, key in ipairs(wsKeys) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "Open workspace " .. i })
	hl.bind(
		mod .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i, follow = true }),
		{ description = "Move window to workspace " .. i }
	)
	-- Second decade (11-20): same physical keys + CTRL.
	hl.bind(
		mod .. " + CTRL + " .. key,
		hl.dsp.focus({ workspace = i + 10 }),
		{ description = "Open workspace " .. (i + 10) }
	)
	hl.bind(
		mod .. " + SHIFT + CTRL + " .. key,
		hl.dsp.window.move({ workspace = i + 10, follow = true }),
		{ description = "Move window to workspace " .. (i + 10) }
	)
end

hl.bind(mod .. " + Tab", hl.dsp.focus({ workspace = "previous" }), { description = "Back-and-forth workspace" })
hl.bind(mod .. " + CTRL + Tab", hl.dsp.focus({ workspace = "m-1" }), { description = "Previous workspace" })
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace" })
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "Previous workspace" })
hl.bind(mod .. " + CTRL + E", hl.dsp.focus({ workspace = "empty" }), { description = "Next empty workspace" })

-- Fn / multimedia keys
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), { description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), { description = "Reduce brightness" })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ description = "Increase volume" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ description = "Reduce volume" }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Toggle mute" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play / pause" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"), { description = "Pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { description = "Next track" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track" })
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
	{ description = "Toggle microphone" }
)
hl.bind("XF86Calculator", hl.dsp.exec_cmd("~/.config/ml4w/settings/calculator.sh"), { description = "Open calculator" })
hl.bind(
	"code:238",
	hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s +10"),
	{ description = "Keyboard backlight up" }
)
hl.bind(
	"code:237",
	hl.dsp.exec_cmd("brightnessctl -d smc::kbd_backlight s 10-"),
	{ description = "Keyboard backlight down" }
)
