-- General + decoration  (was: conf/windows/default.conf + conf/decorations/default.conf)
-- Border colors are read live from colors.conf so ML4W theming keeps working.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

local colors = require("lua/colors")

hl.config({
    general = {
        gaps_in = 10,
        gaps_out = 20,
        border_size = 1,
        layout = "dwindle",
        resize_on_border = true,

        col = {
            active_border = { colors = { colors.primary, colors.on_primary }, angle = 90 },
            inactive_border = colors.on_primary,
        },
    },

    decoration = {
        rounding = 10,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        fullscreen_opacity = 1.0,

        blur = {
            enabled = true,
            size = 4,
            passes = 4,
            new_optimizations = true,
            ignore_opacity = true,
            xray = true,
        },

        shadow = {
            enabled = true,
            range = 32,
            render_power = 2,
            color = "rgba(00000050)",
        },
    },
})
