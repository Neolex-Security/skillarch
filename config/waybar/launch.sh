#!/usr/bin/env bash
set -euo pipefail

if [[ -f "$HOME/.config/ml4w/settings/waybar-disabled" ]]; then
    systemctl --user stop --no-block waybar.service
    exit 0
fi

exec systemctl --user restart --no-block waybar.service
