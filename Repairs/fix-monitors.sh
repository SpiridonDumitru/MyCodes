#!/usr/bin/env bash
#
# setup-monitors.sh
#
# Fixes two recurring problems on this bspwm setup:
#   1. DP-1 sometimes isn't fully "connected" yet at the exact moment
#      bspwmrc runs on boot, so the xrandr call silently does nothing
#      to it.
#   2. Even when both are on, they've ended up positioned backwards
#      (logical left/right swapped vs. the physical desk layout),
#      so the mouse has to cross the wrong edge to reach a monitor.
#
# Call this from ~/.config/bspwm/bspwmrc, e.g.:
#   ~/.config/bspwm/setup-monitors.sh &
#
# Log output goes to /tmp/setup-monitors.log for debugging.

# ---- Config: edit these if your setup changes ----
LEFT_MONITOR="DP-1"     # physically on the LEFT of the desk
RIGHT_MONITOR="DP-2"    # physically on the RIGHT of the desk
LEFT_DESKTOPS=(11 12 13)
RIGHT_DESKTOPS=(I II III IV V VI VII VIII IX X)
MAX_WAIT_SECONDS=15      # how long to wait for both outputs to appear
POLL_INTERVAL=1          # seconds between checks
LOG_FILE="/tmp/setup-monitors.log"
# ----------------------------------------------------

log() {
    echo "[$(date '+%H:%M:%S')] $*" >> "$LOG_FILE"
}

is_connected() {
    xrandr --query | grep -q "^${1} connected"
}

log "=== setup-monitors.sh starting ==="

# Wait for both monitors to report as connected before touching anything.
# This is the fix for the race condition where bspwmrc runs before the
# DP-1 handshake finishes on cold boot.
elapsed=0
while (( elapsed < MAX_WAIT_SECONDS )); do
    if is_connected "$LEFT_MONITOR" && is_connected "$RIGHT_MONITOR"; then
        log "Both $LEFT_MONITOR and $RIGHT_MONITOR detected after ${elapsed}s."
        break
    fi
    sleep "$POLL_INTERVAL"
    (( elapsed += POLL_INTERVAL ))
done

left_ok=false
right_ok=false
is_connected "$LEFT_MONITOR" && left_ok=true
is_connected "$RIGHT_MONITOR" && right_ok=true

if $left_ok && $right_ok; then
    log "Applying dual-monitor layout: $LEFT_MONITOR left of $RIGHT_MONITOR."
    xrandr \
        --output "$LEFT_MONITOR" --auto \
        --output "$RIGHT_MONITOR" --auto --right-of "$LEFT_MONITOR" --primary

elif $right_ok; then
    log "Only $RIGHT_MONITOR detected after ${MAX_WAIT_SECONDS}s. Using it alone."
    xrandr --output "$RIGHT_MONITOR" --auto --primary
    xrandr --output "$LEFT_MONITOR" --off 2>/dev/null

elif $left_ok; then
    log "Only $LEFT_MONITOR detected after ${MAX_WAIT_SECONDS}s. Using it alone."
    xrandr --output "$LEFT_MONITOR" --auto --primary
    xrandr --output "$RIGHT_MONITOR" --off 2>/dev/null

else
    log "Neither monitor detected after ${MAX_WAIT_SECONDS}s. Doing nothing further."
    exit 1
fi

# Give bspwm a moment to notice the new randr layout before we touch desktops.
sleep 1

# Make sure each monitor actually has desktops assigned. Without this,
# a freshly-appeared monitor can look "dead" (mouse won't focus into it)
# even though xrandr and bspwm both see it.
if $left_ok; then
    log "Assigning desktops ${LEFT_DESKTOPS[*]} to $LEFT_MONITOR."
    bspc monitor "$LEFT_MONITOR" -d "${LEFT_DESKTOPS[@]}" 2>>"$LOG_FILE"
fi

if $right_ok; then
    log "Assigning desktops ${RIGHT_DESKTOPS[*]} to $RIGHT_MONITOR."
    bspc monitor "$RIGHT_MONITOR" -d "${RIGHT_DESKTOPS[@]}" 2>>"$LOG_FILE"
fi

log "=== setup-monitors.sh done ==="
