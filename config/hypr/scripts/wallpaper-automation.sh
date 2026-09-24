#!/usr/bin/env bash
#     _         _         __        ______
#    / \  _   _| |_ ___   \ \      / /  _ \
#   / _ \| | | | __/ _ \   \ \ /\ / /| |_) |
#  / ___ \ |_| | || (_) |   \ V  V / |  __/
# /_/   \_\__,_|\__\___/     \_/\_/  |_|
#

cache_folder="$HOME/.cache/hypr"

# Notifications
source "$HOME/.config/hypr/scripts/lib.sh"
APP_NAME="Waypaper"
NOTIFICATION_ICON="preferences-desktop-wallpaper-symbolic"

sec=$(cat ~/.config/hypr/settings/wallpaper-automation.sh)
_setWallpaperRandomly() {
    waypaper --random
    echo ":: Next wallpaper in 60 seconds..."
    sleep $sec
    _setWallpaperRandomly
}

if [ ! -f $cache_folder/wallpaper-automation ]; then
    touch $cache_folder/wallpaper-automation
    echo ":: Start wallpaper automation script"
    notify_user \
        --a "${APP_NAME}" \
        --i "${NOTIFICATION_ICON}" \
        --m "Wallpaper automation process started.\nWallpaper will be changed every $sec seconds."
    _setWallpaperRandomly
else
    rm $cache_folder/wallpaper-automation
    notify_user \
        --a "${APP_NAME}" \
        --i "${NOTIFICATION_ICON}" \
        --m "Wallpaper automation process stopped."
    echo ":: Wallpaper automation script process $wp stopped"
    wp=$(pgrep -f wallpaper-automation.sh)
    kill -KILL $wp
fi
