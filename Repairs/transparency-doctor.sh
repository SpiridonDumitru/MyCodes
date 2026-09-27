#!/bin/sh
# transparency-doctor.sh
# Diagnoses and fixes common causes of broken terminal transparency
# on a bspwm + picom + kitty/alacritty/yazi setup.
#
# Usage: ./transparency-doctor.sh

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ok()   { printf "${GREEN}[OK]${NC}   %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
fail() { printf "${RED}[FAIL]${NC} %s\n" "$1"; }
fix()  { printf "${YELLOW}[FIX]${NC}  %s\n" "$1"; }

BSPWMRC="$HOME/.config/bspwm/bspwmrc"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
ALACRITTY_TOML="$HOME/.config/alacritty/alacritty.toml"
YAZI_THEME="$HOME/.config/yazi/theme.toml"

echo "== 1. picom =="

if ! command -v picom >/dev/null 2>&1; then
    fail "picom is not installed. Run: sudo apt install picom"
elif pgrep -x picom >/dev/null; then
    ok "picom is running (pid $(pgrep -x picom | tr '\n' ' '))"
else
    warn "picom is not running"
    # Detect the known libconfig.so.11 breakage before trying to launch
    ERR="$(picom --diagnostics 2>&1 >/dev/null)"
    if echo "$ERR" | grep -q "libconfig.so.11"; then
        fail "picom binary needs libconfig.so.11, which is missing"
        fix "Installing compatibility package libconfig11..."
        sudo apt install -y libconfig11
    fi
    fix "Starting picom as a daemon..."
    picom --daemon --log-level=error
    sleep 1
    if pgrep -x picom >/dev/null; then
        ok "picom started successfully"
    else
        fail "picom still won't start — run 'picom' in the foreground to see the raw error"
    fi
fi

echo ""
echo "== 2. bspwmrc autostart =="

if [ -f "$BSPWMRC" ]; then
    if grep -q "pgrep -x picom" "$BSPWMRC"; then
        ok "bspwmrc already guards against double-launching picom"
    elif grep -q "^picom" "$BSPWMRC"; then
        fix "Guarding picom's autostart line in bspwmrc"
        sed -i 's/^picom.*/pgrep -x picom > \/dev\/null || picom --daemon --log-level=error/' "$BSPWMRC"
    else
        fix "Adding picom autostart to bspwmrc"
        printf '\n# PICOM\npgrep -x picom > /dev/null || picom --daemon --log-level=error\n' >> "$BSPWMRC"
    fi
else
    warn "No bspwmrc found at $BSPWMRC — skipping"
fi

echo ""
echo "== 3. kitty =="

if [ -f "$KITTY_CONF" ]; then
    if grep -qE "^\s*use_software_render\s+yes" "$KITTY_CONF"; then
        fail "use_software_render is enabled — this disables background_opacity entirely"
        fix "Commenting it out"
        sed -i 's/^\(\s*\)use_software_render\s\+yes/\1# use_software_render yes/' "$KITTY_CONF"
    else
        ok "use_software_render is not forcing software rendering"
    fi

    if grep -qE "^\s*background_opacity" "$KITTY_CONF"; then
        ok "background_opacity is set"
    else
        fix "Adding background_opacity 0.85 to kitty.conf"
        printf '\nbackground_opacity 0.85\n' >> "$KITTY_CONF"
    fi
else
    warn "No kitty.conf found — skipping"
fi

echo ""
echo "== 4. alacritty =="

if [ -f "$ALACRITTY_TOML" ]; then
    if grep -qE "^\s*opacity\s*=" "$ALACRITTY_TOML"; then
        ok "opacity is set in alacritty.toml"
    else
        warn "No opacity key found under [window] in alacritty.toml"
        echo "        Add manually under [window]: opacity = 0.85"
    fi
else
    warn "No alacritty.toml found — skipping"
fi

echo ""
echo "== 5. yazi =="

if [ -f "$YAZI_THEME" ]; then
    if grep -qE '^overall\s*=\s*\{\s*bg\s*=' "$YAZI_THEME"; then
        fail "yazi's 'overall' block sets a solid bg, overriding terminal transparency"
        fix "Clearing it to overall = {}"
        sed -i 's/^overall\s*=\s*{.*}/overall = {}/' "$YAZI_THEME"
    else
        ok "yazi's overall background is not overriding transparency"
    fi
else
    warn "No yazi theme.toml found — skipping"
fi

echo ""
echo "Done. Restart affected apps (or reload configs) to see changes take effect."
echo "kitty: ctrl+shift+F5   |   alacritty: auto-reloads   |   yazi: quit and relaunch"
