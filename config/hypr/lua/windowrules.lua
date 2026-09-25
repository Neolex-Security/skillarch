-- Window & layer rules
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- SwayNC layers (blur + ignore near-transparent pixels; replaces old ignorezero/ignorealpha)
hl.layer_rule({ match = { namespace = "swaync-control-center" },     blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })

-- Pavucontrol
hl.window_rule({
    name = "pavucontrol",
    match = { class = ".*org.pulseaudio.pavucontrol.*" },
    float = true, center = true, pin = true, size = { 700, 600 },
})

-- Waypaper
hl.window_rule({
    name = "waypaper",
    match = { class = ".*waypaper.*" },
    float = true, center = true, pin = true, size = { 900, 700 },
})

-- Newelle
hl.window_rule({
    name = "newelle",
    match = { class = "io.github.qwersyk.Newelle" },
    float = true, center = true, pin = true, size = { 1000, 700 },
})

-- Blueman Manager
hl.window_rule({
    name = "blueman-manager",
    match = { class = "blueman-manager" },
    float = true, center = true, size = { 800, 600 },
})

-- Mission Center
hl.window_rule({
    name = "missioncenter",
    match = { class = "io.missioncenter.MissionCenter" },
    float = true, center = true, pin = true, size = { 900, 600 },
})

-- Gnome Calculator
hl.window_rule({
    name = "gnome-calculator",
    match = { class = "org.gnome.Calculator" },
    float = true, center = true, size = { 700, 600 },
})

-- Hyprland Share Picker
hl.window_rule({
    name = "hyprland-share-picker",
    match = { class = "hyprland-share-picker" },
    float = true, pin = true, center = true, size = { 600, 400 },
})

-- nm-connection-editor
hl.window_rule({
    name = "nm-connection-editor",
    match = { class = "nm-connection-editor" },
    float = true, center = true, size = { 800, 700 },
})

-- Picture-in-Picture
hl.window_rule({
    name = "Picture-in-Picture",
    match = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
    float = true, pin = true, center = true,
})

-- General floating
hl.window_rule({
    name = "dotfiles-floating",
    match = { class = "dotfiles-floating" },
    float = true, center = true, size = { 1000, 700 },
})

-- Dotfiles Sidepad
hl.window_rule({
    name = "dotfiles-sidepad",
    match = { class = "dotfiles-sidepad" },
    float = true, pin = true, center = true, size = { 1000, 700 },
})
