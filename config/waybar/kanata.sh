#!/usr/bin/env bash
# Waybar custom module: Kanata keyboard-layer indicator.
# Reads the current layer from /tmp/kanata_layer (written by kanata layer-listener.sh)
# and emits Waybar JSON. Polled via "interval" in the module definition.
LAYER=$(cat /tmp/kanata_layer 2>/dev/null || echo base)
case "$LAYER" in
  base)    text="⌨ base"    ; class="base"    ;;
  pentest) text="⌨ PENTEST" ; class="pentest" ;;
  sqli)    text="⌨ SQLi"    ; class="alert"   ;;
  trav)    text="⌨ TRAV"    ; class="alert"   ;;
  ssrf)    text="⌨ SSRF"    ; class="alert"   ;;
  xss)     text="⌨ XSS"     ; class="alert"   ;;
  *)       text="⌨ $LAYER"  ; class="other"   ;;
esac
printf '{"text":"%s","class":"%s","tooltip":"Kanata layer: %s"}\n' "$text" "$class" "$LAYER"
