#!/usr/bin/env bash
# wlogout launcher sized to the focused monitor.

params="-b 3"
[[ -r "$HOME/.config/hypr/settings/wlogout-parameters.sh" ]] && params="$(cat "$HOME/.config/hypr/settings/wlogout-parameters.sh")"

res_w=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
res_h=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
h_scale=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .scale' | sed 's/\.//')
w_margin=$((res_h * 27 / h_scale))

wlogout $params -T $w_margin -B $w_margin
