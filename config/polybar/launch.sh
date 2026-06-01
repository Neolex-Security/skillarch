#!/bin/bash

# Terminate already running bar instances
<<<<<<< HEAD
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
=======
killall -q polybar || true

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

MONITORS=$(polybar --list-monitors)
MONITOR_PRIMARY=$(echo "$MONITORS" | grep "primary" | cut -d":" -f1 || true)
MONITOR_EXTRA=$(echo "$MONITORS" | grep -v "primary" | cut -d":" -f1 || true)

# Start main polybar with tray
MONITOR=${MONITOR_PRIMARY:-${MONITOR_EXTRA%% *}} MOD_RIGHT="systray microphone pulseaudio memory cpu filesystem battery wlan eth date" polybar main &
[[ $(wc -l <<<"$MONITORS") > 1 ]] && {
  for m in $MONITOR_EXTRA; do
    MONITOR=$m MOD_RIGHT="microphone pulseaudio memory cpu filesystem battery wlan eth date" polybar main &
  done
}
>>>>>>> upstream
