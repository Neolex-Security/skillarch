#!/bin/bash
LAYER_FILE="/tmp/kanata_layer"
echo "base" > "$LAYER_FILE"

while true; do
  nc localhost 7878 2>/dev/null | while IFS= read -r line; do
    layer=$(echo "$line" | grep -oP '(?<="new":")[^"]+')
    if [[ -n "$layer" ]]; then
      echo "$layer" > "$LAYER_FILE"
      polybar-msg action "#kanata.hook.0" 2>/dev/null
    fi
  done
  sleep 2
done
