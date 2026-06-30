-- Autostart  (was: conf/autostart.conf + the dbus exec-once in hyprland.conf)
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd runs via `sh -c`, so `~` expands and no `& disown` is needed.

hl.on("hyprland.start", function()
    -- Environment for xdg-desktop-portal-hyprland
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Start listeners
    hl.exec_cmd("~/.config/ml4w/listeners.sh --startall")

    -- Polkit
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Wallpaper
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper-restore.sh")

    -- Notification daemon
    hl.exec_cmd("swaync")

    -- GTK settings
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")

    -- hypridle (also starts hyprlock)
    hl.exec_cmd("hypridle")

    -- Clipboard history
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- ML4W autostart
    hl.exec_cmd("~/.config/ml4w/scripts/ml4w-autostart")

    -- Autostart cleanup
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")

    -- Apply settings from the ML4W Hyprland Settings app (was an `exec`, i.e. on every reload)
    hl.exec_cmd("~/.config/com.ml4w.hyprlandsettings/hyprctl.sh")
end)

-- Cursor (was: conf/cursor.conf `exec-once = hyprctl setcursor`)
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor")
end)
