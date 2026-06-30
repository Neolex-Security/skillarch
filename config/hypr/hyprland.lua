--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
--
-- Lua configuration (Hyprland >= 0.55).
-- Migrated from the ML4W hyprlang (.conf) config via https://wiki.hypr.land/Configuring/Start/
--
-- Hyprland prefers this file over hyprland.conf. To roll back to the original
-- ML4W setup, simply remove/rename this file (and the lua/ directory).
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
require("lua.autostart")
