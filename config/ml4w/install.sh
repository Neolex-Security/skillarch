#!/usr/bin/env bash
set -euo pipefail
# Install / switch to the ML4W Hyprland *Waybar* dotfiles (mylinuxforwork/dotfiles).
#
# Pinned to the last pure-Waybar release. ML4W 2.11+ switched its whole shell to
# Quickshell (illogical-impulse); 2.10.1 is the final Waybar + swaync + rofi generation.
# The old `ml4w-hyprland` AUR package was removed from the AUR, so we deploy straight
# from the release tag.
#
# Idempotent and reversible: if a newer Quickshell ML4W tree is already deployed, the
# original is kept once as <tree>.skabak-quickshell before its config dirs are swapped.

ML4W_TAG="2.10.1"
ML4W_ID="com.ml4w.dotfiles"
CACHE="$HOME/.cache/ml4w-hyprland"
TREE="$HOME/.mydotfiles/$ML4W_ID"

# ML4W-specific config dirs that make up the Waybar desktop. Deliberately NOT kitty / nvim /
# vim / fish / zshrc / gtk — those are owned by skillarch or the user and must stay untouched.
DIRS=(hypr waybar rofi swaync waypaper wlogout ml4w nwg-dock-hyprland walker matugen sidepad)

log() { echo "[ml4w] $*"; }

# 1) Fetch the pinned Waybar release.
if [[ -d "$CACHE/.git" ]]; then
    git -C "$CACHE" fetch --depth=1 -q origin "refs/tags/$ML4W_TAG" 2>/dev/null || true
    git -C "$CACHE" checkout -q -f FETCH_HEAD 2>/dev/null || git -C "$CACHE" checkout -q -f "$ML4W_TAG" 2>/dev/null || true
else
    rm -rf "$CACHE"
    git clone -q --depth=1 --branch "$ML4W_TAG" https://github.com/mylinuxforwork/dotfiles "$CACHE"
fi
SRC="$CACHE/dotfiles"
[[ -d "$SRC/.config/waybar" ]] || { log "ERROR: $SRC/.config/waybar missing — bad checkout."; exit 1; }

# 2) Only runtime dep that may be missing (the rest ship with any ML4W/Hyprland install).
command -v waypaper >/dev/null 2>&1 || yay --noconfirm --needed -S waypaper || log "WARN: waypaper install failed"

# 3) Deploy the Waybar config dirs into the ML4W stow tree.
mkdir -p "$TREE/.config"
if [[ -d "$TREE/.config/quickshell" && ! -d "$TREE.skabak-quickshell" ]]; then
    log "backing up current Quickshell tree -> $TREE.skabak-quickshell"
    cp -a "$TREE" "$TREE.skabak-quickshell"
fi
for d in "${DIRS[@]}"; do
    [[ -d "$SRC/.config/$d" ]] || continue
    rm -rf "$TREE/.config/$d"
    cp -a "$SRC/.config/$d" "$TREE/.config/$d"
done

# hypr is HARDCODED in skillarch — the repo snapshot is source of truth, not upstream.
# Carries the local tweaks (Samsung Odyssey G9 monitor layout, fr keybindings, layout/binds).
# Override the just-copied upstream hypr with the pinned repo copy.
REPO_HYPR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/config/hypr"
if [[ -d "$REPO_HYPR" ]]; then
    rm -rf "$TREE/.config/hypr"
    cp -a "$REPO_HYPR" "$TREE/.config/hypr"
    log "hypr deployed from skillarch repo snapshot (hardcoded, not upstream)"
else
    log "WARN: $REPO_HYPR missing — kept upstream ML4W hypr"
fi

# Retire the illogical-impulse Quickshell shell.
rm -rf "$TREE/.config/quickshell"

# 4) Symlink the tree dirs into ~/.config (ML4W-native relative links).
mkdir -p "$HOME/.config"
for d in "${DIRS[@]}"; do
    [[ -d "$TREE/.config/$d" ]] || continue
    tgt="$HOME/.config/$d"
    [[ -e "$tgt" && ! -L "$tgt" ]] && mv "$tgt" "$tgt.skabak"   # back up a real config once
    ln -sfn "../.mydotfiles/$ML4W_ID/.config/$d" "$tgt"
done
# Drop the now-dangling Quickshell link.
[[ -L "$HOME/.config/quickshell" ]] && rm -f "$HOME/.config/quickshell"

log "ML4W Waybar dotfiles deployed (tag $ML4W_TAG)."
log "Relog into Hyprland to switch from the Quickshell bar to Waybar."
