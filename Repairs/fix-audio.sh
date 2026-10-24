#!/usr/bin/env bash

set -u

echo "=== Linux Audio Repair ==="
echo

echo "[1/5] Restarting PipeWire audio services..."

systemctl --user restart pipewire pipewire-pulse wireplumber

sleep 3

echo "[2/5] Waiting for PipeWire..."

for i in {1..10}; do
    if wpctl status >/dev/null 2>&1; then
        break
    fi
    sleep 1
done

echo "[3/5] Finding default audio sink..."

SINK=$(wpctl status | awk '
    /Sinks:/ { in_sinks=1; next }
    /Sources:/ { in_sinks=0 }
    in_sinks && /\*/ {
        match($0, /[0-9]+\./)
        if (RSTART) {
            id=substr($0,RSTART,RLENGTH-1)
            print id
            exit
        }
    }
')

if [ -z "$SINK" ]; then
    echo "ERROR: No audio output found."
    echo
    echo "Available audio devices:"
    wpctl status
    exit 1
fi

echo "Found sink: $SINK"

echo "[4/5] Unmuting and setting volume..."

wpctl set-mute "$SINK" 0
wpctl set-volume "$SINK" 80%

echo "[5/5] Setting default audio output..."

wpctl set-default "$SINK"

sleep 1

echo
echo "=== Audio status ==="
wpctl status | sed -n '/Audio/,/Video/p'

echo
echo "Audio repair completed."
echo
echo "Testing PipeWire..."

if command -v pw-play >/dev/null 2>&1; then
    TEST_FILE="/usr/share/sounds/alsa/Front_Center.wav"

    if [ -f "$TEST_FILE" ]; then
        echo "Playing test sound..."
        pw-play "$TEST_FILE"
    else
        echo "PipeWire is working, but the test WAV file was not found."
    fi
else
    echo "pw-play is not installed."
fi
