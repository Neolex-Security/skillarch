#!/usr/bin/env bash
set -euo pipefail

disabled="$HOME/.config/ml4w/settings/waybar-disabled"

if systemctl --user is-active --quiet waybar.service; then
    touch "$disabled"
    exec systemctl --user stop --no-block waybar.service
fi

rm -f "$disabled"
exec systemctl --user start --no-block waybar.service
