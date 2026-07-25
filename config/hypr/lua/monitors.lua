-- Monitors  (was: conf/monitors/nwg-displays.conf -> monitors.conf)
-- Samsung Odyssey G9 (LC49G95T): single physical screen on HDMI + DP.
-- Disable the HDMI duplicate, keep DisplayPort (120Hz).
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1 })
-- hl.monitor({ output = "HDMI-A-1", disabled = true })
