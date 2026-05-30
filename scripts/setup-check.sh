#!/usr/bin/env bash
# setup-check.sh — checks what's installed/configured for the language-learning system.
# Safe to run repeatedly. Read-only; changes nothing. Paste the output to Claude.

set -u
ok()   { printf "  ✅ %s\n" "$1"; }
no()   { printf "  ❌ %s\n" "$1"; }
info() { printf "  ℹ️  %s\n" "$1"; }

echo "=== Language Learning System — setup check ==="
echo

echo "OS:"
info "$(uname -s) $(uname -r)"
echo

echo "Git:"
if command -v git >/dev/null 2>&1; then ok "git $(git --version | awk '{print $3}')"; else no "git not found (xcode-select --install on macOS)"; fi
if command -v gh >/dev/null 2>&1; then ok "GitHub CLI present"; else info "GitHub CLI (gh) not found — optional"; fi
echo

echo "ngrok:"
if command -v ngrok >/dev/null 2>&1; then
  ok "ngrok present ($(ngrok --version 2>/dev/null | head -1))"
  CFG="$HOME/Library/Application Support/ngrok/ngrok.yml"
  [ -f "$CFG" ] && ok "ngrok config found" || info "no ngrok.yml yet (run: ngrok config add-authtoken <TOKEN>)"
else
  no "ngrok not found (ngrok.com/download, or brew install ngrok on macOS)"
fi
echo

echo "Anki Desktop:"
if [ "$(uname -s)" = "Darwin" ] && [ -d "/Applications/Anki.app" ]; then
  ok "Anki.app installed"
else
  info "Anki.app not detected in /Applications (install from apps.ankiweb.net)"
fi
echo

echo "Anki MCP server (only true while Anki Desktop is OPEN):"
if command -v curl >/dev/null 2>&1; then
  if curl -s -o /dev/null -w "%{http_code}" --max-time 3 http://127.0.0.1:3141 2>/dev/null | grep -qE "200|400|404|405"; then
    ok "something is responding on 127.0.0.1:3141 (Anki MCP likely up)"
  else
    info "nothing on 127.0.0.1:3141 — open Anki Desktop (with the Anki MCP add-on) first"
  fi
else
  info "curl not found — skipping port check"
fi
echo

echo "=== Done. Paste this output to Claude and continue setup. ==="
