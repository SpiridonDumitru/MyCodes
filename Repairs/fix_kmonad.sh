#!/usr/bin/env bash
# Repair/restart KMonad using the user's existing configuration.
set -Eeuo pipefail

KMONAD="${HOME}/.local/bin/kmonad"
CONFIG="${HOME}/.config/kmonad/kmonad_config.kbd"
LOG_DIR="${HOME}/.local/state/kmonad"
LOG_FILE="${LOG_DIR}/repair.log"
SERVICE_CANDIDATES=("kmonad.service" "kmonad-user.service")

mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=== KMonad repair: $(date '+%F %T') ==="

if [[ ! -x "$KMONAD" ]]; then
  echo "ERROR: KMonad executable not found or not executable: $KMONAD"
  echo "Check the path with: command -v kmonad"
  exit 1
fi

if [[ ! -f "$CONFIG" ]]; then
  echo "ERROR: KMonad config not found: $CONFIG"
  exit 1
fi

# Prefer an installed user service, if one exists.
SERVICE=""
for candidate in "${SERVICE_CANDIDATES[@]}"; do
  if systemctl --user cat "$candidate" >/dev/null 2>&1; then
    SERVICE="$candidate"
    break
  fi
done

if [[ -n "$SERVICE" ]]; then
  echo "Found user service: $SERVICE"
  systemctl --user stop "$SERVICE" || true
  # Clear stale processes from manual launches too.
  pkill -x kmonad 2>/dev/null || true
  sleep 1
  systemctl --user reset-failed "$SERVICE" || true
  if systemctl --user start "$SERVICE"; then
    sleep 2
    if systemctl --user is-active --quiet "$SERVICE"; then
      echo "OK: $SERVICE is active."
      systemctl --user --no-pager --full status "$SERVICE" || true
      exit 0
    fi
  fi
  echo "Service failed to become active. Recent logs:"
  journalctl --user -u "$SERVICE" -n 40 --no-pager || true
  echo "See full repair log: $LOG_FILE"
  exit 1
fi

echo "No known KMonad user service found; launching KMonad directly."
# Stop old processes cleanly first, then force-stop only if still present.
pkill -TERM -x kmonad 2>/dev/null || true
for _ in {1..5}; do
  pgrep -x kmonad >/dev/null || break
  sleep 1
done
if pgrep -x kmonad >/dev/null; then
  pkill -KILL -x kmonad 2>/dev/null || true
  sleep 1
fi

# If KMonad needs elevated privileges on this system, use sudo for the launch.
# Keep the process detached from this terminal and capture output in the log.
if command -v setsid >/dev/null 2>&1; then
  setsid "$KMONAD" "$CONFIG" >>"$LOG_FILE" 2>&1 </dev/null &
else
  nohup "$KMONAD" "$CONFIG" >>"$LOG_FILE" 2>&1 </dev/null &
fi

sleep 2
if pgrep -af "$KMONAD $CONFIG" >/dev/null || pgrep -x kmonad >/dev/null; then
  echo "KMonad appears to be running."
  pgrep -af kmonad || true
  echo "Log: $LOG_FILE"
  exit 0
fi

echo "ERROR: KMonad did not stay running. Recent log output:"
tail -n 60 "$LOG_FILE" || true
echo "If the log mentions permission/input-device access, the launch may need the same privileges or session environment as your normal KMonad startup."
exit 1
