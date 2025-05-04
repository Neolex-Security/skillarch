#!/bin/bash

status=$(playerctl status -p spotify 2>/dev/null)

if [ "$status" = "Playing" ]; then
  echo ""
elif [ "$status" = "Paused" ]; then
  echo ""
else
  echo ""
fi
