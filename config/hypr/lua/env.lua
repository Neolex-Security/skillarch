-- Environment variables  (was: conf/environments/default.conf + env block in conf/ml4w.conf)
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

-- XDG Desktop Portal
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")

-- GDK
hl.env("GDK_SCALE", "1")

-- Toolkit backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Cursor size for xcursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Ozone (Electron / Chromium)
hl.env("OZONE_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- SDL
hl.env("SDL_VIDEODRIVER", "wayland")

-- XWayland
hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Nvidia
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
