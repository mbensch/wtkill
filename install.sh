#!/usr/bin/env bash
set -euo pipefail

ok=true

# Check bash >= 4
if [[ "${BASH_VERSINFO[0]}" -lt 4 ]]; then
  echo "ERROR: bash 4+ required (found ${BASH_VERSION})"
  echo "  macOS:  brew install bash"
  echo "  Linux:  sudo apt install bash"
  ok=false
fi

# Check git
if ! command -v git &>/dev/null; then
  echo "ERROR: git is not installed"
  echo "  macOS:  brew install git"
  echo "  Linux:  sudo apt install git"
  ok=false
fi

# Check fzf
if ! command -v fzf &>/dev/null; then
  echo "ERROR: fzf is not installed"
  echo "  macOS:  brew install fzf"
  echo "  Linux:  sudo apt install fzf"
  ok=false
fi

$ok || { echo ""; echo "Install missing dependencies and re-run."; exit 1; }

PREFIX="${PREFIX:-$HOME/.local/bin}"
mkdir -p "$PREFIX"

if [[ -f "./wtkill" ]]; then
  cp wtkill "$PREFIX/wtkill"
else
  LATEST=$(curl -fsSL https://api.github.com/repos/mbensch/wtkill/releases/latest | grep tag_name | cut -d'"' -f4)
  if [[ -z "$LATEST" ]]; then
    echo "ERROR: could not determine latest release from GitHub"
    exit 1
  fi
  echo "Downloading wtkill ${LATEST}..."
  curl -fsSL "https://raw.githubusercontent.com/mbensch/wtkill/$LATEST/wtkill" -o "$PREFIX/wtkill"
fi

chmod +x "$PREFIX/wtkill"

echo "Installed wtkill to $PREFIX/wtkill"
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$PREFIX"; then
  echo "Note: $PREFIX is not in your PATH. Add it with:"
  echo "  export PATH=\"$PREFIX:\$PATH\""
fi
