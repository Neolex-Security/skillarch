#!/usr/bin/env bash
# Merge the skillarch Kanata indicator into the illogical-impulse quickshell config.
# Idempotent: safe to re-run after every dots-hyprland install.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
QS="$HOME/.config/quickshell/ii"

if [[ ! -d "$QS" ]]; then
    echo "[skillarch] $QS not found — install dots-hyprland first." >&2
    exit 0
fi

install -Dm644 "$SRC/KanataLayer.qml"     "$QS/services/KanataLayer.qml"
install -Dm644 "$SRC/KanataIndicator.qml" "$QS/modules/ii/bar/KanataIndicator.qml"

BAR="$QS/modules/ii/bar/BarContent.qml"
if [[ ! -f "$BAR" ]]; then
    echo "[skillarch] $BAR missing — illogical-impulse layout changed?" >&2
    exit 1
fi

if ! grep -q 'KanataIndicator {' "$BAR"; then
    python3 - "$BAR" <<'PY'
import sys, re, pathlib
p = pathlib.Path(sys.argv[1])
src = p.read_text()
m = re.search(r"HyprlandXkbIndicator\s*\{[^}]*\}", src, re.DOTALL)
if not m:
    sys.exit("[skillarch] could not locate HyprlandXkbIndicator block")
inject = """
                    KanataIndicator {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.rightMargin: indicatorsRowLayout.realSpacing
                        tint: rightSidebarButton.colText
                    }"""
new = src[:m.end()] + inject + src[m.end():]
p.write_text(new)
print("[skillarch] patched BarContent.qml")
PY
else
    echo "[skillarch] BarContent.qml already patched"
fi

echo "[skillarch] Kanata indicator applied. Reload Quickshell: pkill -f 'qs -c ii'; qs -c ii &"
