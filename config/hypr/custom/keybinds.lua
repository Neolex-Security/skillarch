require("hyprland.lib")
require("hyprland.variables")
if is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
	require("custom.variables")
end

local qsScripts = "$HOME/.config/quickshell/$qsConfig/scripts"
local hyprScripts = "$HOME/.config/hypr/hyprland/scripts"
local qsIpcCall = "qs -c $qsConfig ipc call"
local qsIsAlive = qsIpcCall .. " TEST_ALIVE"
hl.bind(
	"CTRL+SUPER+ALT+Slash",
	hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
	{ description = "Edit user keybinds" }
)

-- Workspaces 1-10: SUPER + number to focus (absolute, overrides default grouped behavior)
for i = 1, 10 do
	hl.bind("SUPER + " .. (i % 10), function()
		hl.dispatch(hl.dsp.focus({ workspace = i }))
	end, { description = "Workspace: Focus " .. i })
end
for i = 1, 10 do
	local nk = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + code:" .. nk[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = i }))
	end)
end
for i = 1, 10 do
	local npk = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + code:" .. npk[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = i }))
	end)
end

-- Workspaces 1-10: SUPER+SHIFT + number to move window and follow (absolute)
for i = 1, 10 do
	hl.bind("SUPER + SHIFT + " .. (i % 10), function()
		hl.dispatch(hl.dsp.window.move({ workspace = i }))
	end, { description = "Window: Send to workspace " .. i .. " and follow" })
end
for i = 1, 10 do
	local nk = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + SHIFT + code:" .. nk[i], function()
		hl.dispatch(hl.dsp.window.move({ workspace = i }))
	end)
end
for i = 1, 10 do
	local npk = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + SHIFT + code:" .. npk[i], function()
		hl.dispatch(hl.dsp.window.move({ workspace = i }))
	end)
end

-- Workspaces 11-20: SUPER+CTRL + number to focus
for i = 1, 10 do
	hl.bind("SUPER + CTRL + " .. (i % 10), function()
		hl.dispatch(hl.dsp.focus({ workspace = 10 + i }))
	end, { description = "Workspace: Focus " .. (10 + i) })
end
for i = 1, 10 do
	local nk = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + CTRL + code:" .. nk[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = 10 + i }))
	end)
end
for i = 1, 10 do
	local npk = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + CTRL + code:" .. npk[i], function()
		hl.dispatch(hl.dsp.focus({ workspace = 10 + i }))
	end)
end

-- Workspaces 11-20: SUPER+SHIFT+CTRL + number to move window and follow
for i = 1, 10 do
	hl.bind("SUPER + SHIFT + CTRL + " .. (i % 10), function()
		hl.dispatch(hl.dsp.window.move({ workspace = 10 + i }))
	end, { description = "Window: Send to workspace " .. (10 + i) .. " and follow" })
end
for i = 1, 10 do
	local nk = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
	hl.bind("SUPER + SHIFT + CTRL + code:" .. nk[i], function()
		hl.dispatch(hl.dsp.window.move({ workspace = 10 + i }))
	end)
end
for i = 1, 10 do
	local npk = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 }
	hl.bind("SUPER + SHIFT + CTRL + code:" .. npk[i], function()
		hl.dispatch(hl.dsp.window.move({ workspace = 10 + i }))
	end)
end

hl.bind("SUPER + code:51", hl.dsp.global("quickshell:overviewClipboardToggle"))
hl.unbind("SUPER + code:28")
hl.unbind("SUPER + code:26")

-- SUPER + Tab: back-and-forth between current and last focused workspace
hl.unbind("SUPER + Tab")
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "previous" }),
	{ description = "Workspace: Back-and-forth (previous)" })
hl.bind("SUPER + code:26", hl.dsp.global("quickshell:overviewEmojiToggle"))

hl.bind("SUPER + code:28", hl.dsp.exec_cmd(fileManager), { description = "App: File manager" })
hl.bind("SUPER + code:33", hl.dsp.exec_cmd("gradia --screenshot"))
hl.unbind("SUPER + S")
hl.bind(
	"SUPER + S",
	hl.dsp.exec_cmd("~/.local/bin/switch-audio-output"),
	{ description = "Audio: Switch output device" }
)
hl.unbind("SUPER + Minus")
hl.unbind("SUPER + Equal")

-- Scratchpad (special workspace)
hl.unbind("SUPER + Z")
hl.unbind("SUPER + SHIFT + Z")
hl.bind(
	"SUPER + Z",
	hl.dsp.workspace.toggle_special("special"),
	{ description = "Workspace: Toggle scratchpad" }
)
hl.bind(
	"SUPER + SHIFT + Z",
	hl.dsp.window.move({ workspace = "special:special", follow = false }),
	{ description = "Window: Send to scratchpad" }
)

--##! Screen
--# Zoom
local function zoomfunction(value)
	local zoomvalue = hl.get_config("cursor:zoom_factor")
	if (zoomvalue + value) > 3.0 then
		hl.config({ cursor = { zoom_factor = 3.0 } })
	elseif (zoomvalue + value) < 1.0 then
		hl.config({ cursor = { zoom_factor = 1.0 } })
	else
		hl.config({ cursor = { zoom_factor = zoomvalue + value } })
	end
end
hl.unbind("SUPER + mouse_down")
hl.unbind("SUPER + mouse_up")
hl.bind("SUPER + mouse_up", function()
	zoomfunction(-0.3)
end, { repeating = true, description = "Screen: Zoom out" })
hl.bind("SUPER + mouse_down", function()
	zoomfunction(0.3)
end, { repeating = true, description = "Screen: Zoom in" })
