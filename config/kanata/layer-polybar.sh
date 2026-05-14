#!/bin/bash
LAYER=$(cat /tmp/kanata_layer 2>/dev/null || echo "base")

case "$LAYER" in
  base)    echo "%{F#888888}⌨ base%{F-}" ;;
  pentest) echo "%{F#ff9900}⌨ PENTEST%{F-}" ;;
  sqli)    echo "%{F#ff0000}⌨ SQLi%{F-}" ;;
  trav)    echo "%{F#ff0000}⌨ TRAV%{F-}" ;;
  ssrf)    echo "%{F#ff0000}⌨ SSRF%{F-}" ;;
  xss)     echo "%{F#ff0000}⌨ XSS%{F-}" ;;
  *)       echo "%{F#ffffff}⌨ $LAYER%{F-}" ;;
esac
