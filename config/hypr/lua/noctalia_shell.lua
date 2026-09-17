-- Noctalia shell integration for Hyprland.
-- Docs: https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/
--
-- Toggle USE_NOCTALIA in this file (and reload) to switch between Noctalia and
-- the ML4W Waybar / nwg-dock / swaync stack. Autostart reads the same flag.

local M = {}

-- Set to false to fall back to Waybar + nwg-dock + swaync.
M.USE_NOCTALIA = true

local mod = "SUPER"
local ipc = "noctalia msg "

function M.setup()
	if not M.USE_NOCTALIA then
		return
	end

	-- Settings window
	hl.window_rule({
		name = "noctalia-settings",
		match = { class = "dev.noctalia.Noctalia" },
		float = true,
		size = { 1080, 920 },
	})

	-- Blur Noctalia surfaces; disable Hyprland layer anims (Noctalia has its own).
	hl.layer_rule({
		name = "noctalia",
		match = {
			namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
		},
		no_anim = true,
		ignore_alpha = 0.5,
		blur = true,
		blur_popups = true,
	})

	-- Persistent workspaces on the Odyssey G9 (DP-1) so empty ones stay in the bar.
	local names = {
		[1] = "web",
		[2] = "code",
		[3] = "chat",
		[4] = "game",
		[5] = "media",
		[6] = "six",
		[7] = "seven",
		[8] = "eight",
		[9] = "nine",
		[10] = "mail",
		[11] = "notes",
		[12] = "twelve",
	}
	for id, name in pairs(names) do
		hl.workspace_rule({
			workspace = tostring(id),
			monitor = "DP-1",
			persistent = true,
			default_name = name,
		})
	end

	-- Core panels
	hl.bind(
		mod .. " + Space",
		hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"),
		{ description = "Noctalia launcher" }
	)
	hl.bind(
		mod .. " + S",
		hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"),
		{ description = "Noctalia control center" }
	)
	hl.bind(
		mod .. " + comma",
		hl.dsp.exec_cmd(ipc .. "settings-toggle"),
		{ description = "Noctalia settings" }
	)
	hl.bind(
		"ALT + Tab",
		hl.dsp.exec_cmd(ipc .. "window-switcher"),
		{ description = "Noctalia window switcher" }
	)

	-- Media / brightness via Noctalia (OSD)
	hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { description = "Volume up (Noctalia)" })
	hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { description = "Volume down (Noctalia)" })
	hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), { description = "Mute (Noctalia)" })
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd(ipc .. "brightness-up"),
		{ description = "Brightness up (Noctalia)" }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd(ipc .. "brightness-down"),
		{ description = "Brightness down (Noctalia)" }
	)
end

return M
