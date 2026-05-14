#!/bin/bash
LAYER_FILE="/tmp/kanata_layer"
echo "$1" > "$LAYER_FILE"
# Trigger polybar refresh
polybar-msg action "#kanata.hook.0" 2>/dev/null

