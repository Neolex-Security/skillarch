-- General + decoration  (was: conf/windows/default.conf + conf/decorations/default.conf)
-- Border colors are read live from colors.conf so theme/wallpaper recoloring keeps working.
-- Gaps / rounding / blur / shadow tuned for Noctalia:
-- https://docs.noctalia.dev/noctalia/compositor-settings/hyprland/
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("lua/colors")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 1,
        layout = "dwindle",
        resize_on_border = true,

        col = {
            active_border = { colors = { colors.primary, colors.on_primary }, angle = 90 },
            inactive_border = colors.on_primary,
        },
    },

    decoration = {
        rounding = 20,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
            new_optimizations = true,
            ignore_opacity = true,
            xray = true,
        },

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a,
        },
    },
})
