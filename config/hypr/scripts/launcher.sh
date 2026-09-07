#!/usr/bin/env bash
set -euo pipefail

launcher="rofi"
launcher_setting="$HOME/.config/ml4w/settings/launcher"
[[ -r "$launcher_setting" ]] && launcher="$(<"$launcher_setting")"

if [[ "$launcher" == "walker" && -x "$HOME/.config/walker/launch.sh" ]]; then
    exec "$HOME/.config/walker/launch.sh" --height 500
fi

# Rofi's own -replace mode safely replaces an existing launcher. Avoid pkill:
# a stuck /proc entry can make procps scan forever and block the Hyprland bind.
exec rofi -show drun -replace -i
