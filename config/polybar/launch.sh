#!/bin/bash

# Terminate already running bar instances
killall -q polybar 2>/dev/null || true

# Wait until the processes have been shut down (max 5s)
count=0
while pgrep -u "$UID" -x polybar >/dev/null 2>&1; do
  sleep 1
  count=$((count + 1))
  if [ "$count" -ge 5 ]; then
    killall -9 polybar 2>/dev/null || true
    sleep 1
    break
  fi
done

CONFIG_DIR="$(cd "$(dirname "$0")" && pwd)"
polybar -c "$CONFIG_DIR/config.ini" main &
disown
