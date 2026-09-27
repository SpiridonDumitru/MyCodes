#!/usr/bin/env bash
#
# fix-secret-push.sh
#
# Helper for when `git push` is rejected by GitHub push protection
# (secret scanning). It scans your commit history for common secret
# patterns, shows you what/where, and offers to purge them with
# git-filter-repo so you can force-push cleanly.
#
# Usage:
#   ./fix-secret-push.sh scan            # just scan history, report findings
#   ./fix-secret-push.sh purge <file>    # remove a whole file from all history
#   ./fix-secret-push.sh redact <pattern-file>
#                                         # replace matching strings across history
#                                         # pattern-file format: SECRET==>replacement (one per line)
#   ./fix-secret-push.sh push            # re-add origin + force push
#
# Requires: git, python3 (for git-filter-repo), pip

set -euo pipefail

REMOTE_URL="${REMOTE_URL:-}"   # optionally export REMOTE_URL before running
BRANCH="${BRANCH:-main}"

ensure_filter_repo() {
  if ! command -v git-filter-repo >/dev/null 2>&1; then
    echo "[*] git-filter-repo not found, installing..."
    pip install --user git-filter-repo || pip3 install --user git-filter-repo
  fi
}

scan_history() {
  echo "[*] Scanning full git history for likely secrets..."
  # Common patterns: API keys, tokens, private keys, AWS keys, generic secret= assignments
  git log -p --all | grep -nE \
    -e 'AKIA[0-9A-Z]{16}' \
    -e '-----BEGIN (RSA|EC|OPENSSH|PGP) PRIVATE KEY-----' \
    -e 'ghp_[0-9A-Za-z]{36}' \
    -e 'sk-[0-9A-Za-z]{20,}' \
    -e '(?i)(api[_-]?key|secret|token|password)["\x27]?\s*[:=]\s*["\x27][A-Za-z0-9_\-]{8,}' \
    || echo "[*] No obvious patterns found by regex — check the GitHub error URL for the exact commit/file."
  echo
  echo "[*] If GitHub gave you a specific unblock URL in the push error, it will name the"
  echo "    exact file and commit. Prefer that over the regex guess above."
}

purge_file() {
  local target="$1"
  ensure_filter_repo
  echo "[*] Removing '$target' from ALL history..."
  git filter-repo --path "$target" --invert-paths --force
  echo "[*] Done. Remote 'origin' was removed by filter-repo (safety default)."
}

redact_patterns() {
  local pattern_file="$1"
  ensure_filter_repo
  echo "[*] Redacting secrets listed in '$pattern_file' from ALL history..."
  git filter-repo --replace-text "$pattern_file" --force
  echo "[*] Done. Remote 'origin' was removed by filter-repo (safety default)."
}

repush() {
  if [ -z "$REMOTE_URL" ]; then
    echo "[!] No REMOTE_URL set. Run: REMOTE_URL=git@github.com:user/repo.git $0 push"
    exit 1
  fi
  if ! git remote get-url origin >/dev/null 2>&1; then
    echo "[*] Re-adding origin -> $REMOTE_URL"
    git remote add origin "$REMOTE_URL"
  fi
  echo "[*] Force-pushing cleaned history to origin/$BRANCH..."
  git push origin "$BRANCH" --force
}

case "${1:-}" in
  scan)   scan_history ;;
  purge)  [ -n "${2:-}" ] || { echo "Usage: $0 purge <file>"; exit 1; }; purge_file "$2" ;;
  redact) [ -n "${2:-}" ] || { echo "Usage: $0 redact <pattern-file>"; exit 1; }; redact_patterns "$2" ;;
  push)   repush ;;
  *)
    cat <<EOF
Usage: $0 <command>

Commands:
  scan              Scan full git history for likely hardcoded secrets
  purge <file>      Remove a file entirely from all git history
  redact <patterns> Replace secret strings across history using a
                     pattern file (lines like: SECRET_VALUE==>REDACTED)
  push              Re-add origin remote (set REMOTE_URL env var) and
                     force-push the cleaned branch

Typical flow after a rejected push:
  1. $0 scan
  2. $0 purge path/to/file/with/secret        # or: $0 redact patterns.txt
  3. REMOTE_URL=git@github.com:you/repo.git $0 push
  4. Rotate/revoke the leaked secret at its provider (don't skip this!)
EOF
    ;;
esac
