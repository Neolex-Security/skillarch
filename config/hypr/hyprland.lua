--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- Lua configuration (Hyprland >= 0.55).
-- Migrated from the original hyprlang (.conf) config via https://wiki.hypr.land/Configuring/Start/
--
-- Hyprland prefers this file over hyprland.conf. To roll back to the old
-- hyprlang setup, simply remove/rename this file (and the lua/ directory).
-- Each require() runs in its own scope, so an error in one module won't abort the rest.
--
-- NOTE: hypridle / hyprlock / hyprpaper keep their own (.conf) format and are unchanged.

require("lua.env")
require("lua.monitors")
require("lua.input")
require("lua.looknfeel")
require("lua.animations")
require("lua.layouts")
require("lua.misc")
require("lua.windowrules")
require("lua.keybindings")
-- Noctalia layer/window rules, persistent workspaces, IPC binds
-- (after keybindings so its Super+S / Alt+Tab / media binds win when enabled)
require("lua.noctalia_shell").setup()
require("lua.autostart")

-- Noctalia Color templates (written to ~/.config/hypr/noctalia.lua by the
-- noctalia theme engine). pcall so a fresh install before first theme apply
-- still boots Hyprland.
pcall(function()
	require("noctalia").apply_theme()
end)

-- >>> HYPRLAND VISUAL EDITOR (HVE) <<<
pcall(function()
	dofile(os.getenv("HOME") .. "/.cache/noctalia/HVE/overlay.lua")
end)
-- <<< HYPRLAND VISUAL EDITOR (HVE) <<<
