#!/bin/bash

LOCKFILE="/tmp/dunst_paused.lock"

if ! pgrep -x "dunst" >/dev/null; then
  notify-send "⚠️ Dunst is not running"
  exit 1
fi

if [ -f "$LOCKFILE" ]; then
  # Réactiver Dunst
  dunstctl set-paused false
  rm "$LOCKFILE"
  notify-send "🔔 Notifications Enabled"
else
  # Afficher la notif AVANT de le désactiver
  notify-send "🔕 Notifications Paused in 5s..."
  sleep 5
  dunstctl set-paused true
  touch "$LOCKFILE"
fi
