-- Keyboard / input  (was: conf/keyboard.conf)
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
    input = {
        kb_layout = "fr",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        numlock_by_default = true,
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
            scroll_factor = 1.0,
            disable_while_typing = false,
        },
    },
})
