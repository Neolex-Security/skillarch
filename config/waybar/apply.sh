#!/usr/bin/env bash
set -euo pipefail
# Inject the skillarch Kanata layer indicator into the ML4W Waybar config.
# Idempotent: safe to re-run after every ml4w-hyprland-setup.

SRC="$(cd "$(dirname "$0")" && pwd)"
WB="$HOME/.config/waybar"
MODULES="$WB/modules.json"

if [[ ! -f "$MODULES" ]]; then
    echo "[skillarch] $MODULES not found — install ML4W dotfiles first." >&2
    exit 0
fi

install -Dm755 "$SRC/kanata.sh" "$WB/kanata.sh"

# 1) Module definition — insert into modules.json before its final closing brace.
if ! grep -q '"custom/kanata"' "$MODULES"; then
    python3 - "$MODULES" <<'PY'
import sys, pathlib
p = pathlib.Path(sys.argv[1])
src = p.read_text()
i = src.rstrip().rfind('}')
if i == -1:
    sys.exit("[skillarch] could not locate closing brace in modules.json")
head = src[:i].rstrip()
# the preceding member must be comma-terminated before we append a new one
if head[-1:] not in ('{', '[', ','):
    head += ','
head += '\n'
block = '''  "custom/kanata": {
    "exec": "~/.config/waybar/kanata.sh",
    "return-type": "json",
    "interval": 1,
    "tooltip": true
  },
'''
p.write_text(head + block + src[i:])
print("[skillarch] added custom/kanata to modules.json")
PY
else
    echo "[skillarch] custom/kanata already in modules.json"
fi

# 2) Resolve the active theme and add the module to its modules-left list.
#    waybar-theme.sh holds "/THEMEFOLDER;/VARIATION" (see waybar/launch.sh).
THEME_FILE="$HOME/.config/ml4w/settings/waybar-theme.sh"
theme="ml4w-glass-center"
[[ -f "$THEME_FILE" ]] && theme="$(cut -d';' -f1 "$THEME_FILE" | tr -d '/[:space:]')"
CONF="$WB/themes/$theme/config"
if [[ -f "$CONF" ]]; then
    if ! grep -q '"custom/kanata"' "$CONF"; then
        sed -i 's#\("modules-left": \[\)#\1\n        "custom/kanata",#' "$CONF"
        echo "[skillarch] added custom/kanata to $theme layout"
    else
        echo "[skillarch] custom/kanata already in $theme layout"
    fi
else
    echo "[skillarch] theme config $CONF not found — add \"custom/kanata\" to modules-left manually." >&2
fi

# 3) Styling. The CSS may live at themes/<theme>/style.css or, for themes with a
#    variation (field 2 of waybar-theme.sh, e.g. ".../default"), themes/<theme>/<variation>/style.css.
STYLE="$WB/themes/$theme/style.css"
if [[ ! -f "$STYLE" && -f "$THEME_FILE" ]]; then
    variation="$(cut -d';' -f2 "$THEME_FILE" | sed 's#^/##;s/[[:space:]]//g')"
    [[ -n "$variation" && -f "$WB/themes/$variation/style.css" ]] && STYLE="$WB/themes/$variation/style.css"
fi
if [[ -f "$STYLE" ]] && ! grep -q 'custom-kanata' "$STYLE"; then
    cat >> "$STYLE" <<'CSS'

/* skillarch Kanata layer indicator */
#custom-kanata { padding: 0 10px; }
#custom-kanata.pentest { color: #ff9900; }
#custom-kanata.alert   { color: #ff0000; }
#custom-kanata.base,
#custom-kanata.other   { color: #888888; }
CSS
fi

echo "[skillarch] Kanata indicator applied. Reload Waybar: ~/.config/waybar/launch.sh"
