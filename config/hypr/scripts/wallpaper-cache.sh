#!/usr/bin/env bash

# Notifications
source "$HOME/.config/hypr/scripts/lib.sh"

cache_folder="$HOME/.cache/hypr"
generated_versions="$cache_folder/wallpaper-generated"
rm $generated_versions/*
echo ":: Wallpaper cache cleared"
notify_user \
        --a "System" \
        --m "Wallpaper cache cleared"
