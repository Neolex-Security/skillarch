#!/usr/bin/env bash
set -euo pipefail

waybar_dir="$HOME/.config/waybar"
theme_setting="$HOME/.config/ml4w/settings/waybar-theme.sh"
default_theme="/ml4w-glass-center;/ml4w-glass-center/default"

theme_style="$default_theme"
[[ -r "$theme_setting" ]] && theme_style="$(<"$theme_setting")"
IFS=';' read -r theme style <<< "$theme_style"

if [[ ! -f "$waybar_dir/themes${theme}/config" || ! -f "$waybar_dir/themes${style}/style.css" ]]; then
    IFS=';' read -r theme style <<< "$default_theme"
fi

config_file="config"
style_file="style.css"
[[ -f "$waybar_dir/themes${theme}/config-custom" ]] && config_file="config-custom"
[[ -f "$waybar_dir/themes${style}/style-custom.css" ]] && style_file="style-custom.css"

signature="${HYPRLAND_INSTANCE_SIGNATURE:-}"
socket_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr"
if [[ -z "$signature" || ! -d "$socket_dir/$signature" ]]; then
    signature="$({ hyprctl instances -j || true; } | jq -r --arg socket "${WAYLAND_DISPLAY:-}" \
        '. as $instances | map(select(.wl_socket == $socket))[0].instance // $instances[0].instance // empty')"
fi

if [[ -z "$signature" ]]; then
    echo "[skillarch] no running Hyprland instance found" >&2
    exit 1
fi

export HYPRLAND_INSTANCE_SIGNATURE="$signature"
exec waybar \
    -c "$waybar_dir/themes${theme}/$config_file" \
    -s "$waybar_dir/themes${style}/$style_file"
