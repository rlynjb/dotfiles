#!/bin/bash
# Vim plugin bootstrap — installs plugins as Vim 8+ native packages
# (~/.vim/pack/plugins/start/), no plugin manager required.
# Idempotent: clones a plugin if missing, otherwise fast-forwards it.
# Usage: bash install-vim-plugins.sh

set -e

PACK_DIR="$HOME/.vim/pack/plugins/start"

# plugin list: "name  git-url"  (add entries here to install more)
PLUGINS=(
  "vim-instant-markdown https://github.com/instant-markdown/vim-instant-markdown.git"
)

echo "==> Installing Vim plugins into $PACK_DIR"
mkdir -p "$PACK_DIR"

for entry in "${PLUGINS[@]}"; do
  name="${entry%% *}"
  url="${entry##* }"
  dest="$PACK_DIR/$name"

  if [ -d "$dest/.git" ]; then
    echo "  Updating $name..."
    git -C "$dest" pull --ff-only --quiet
  else
    echo "  Cloning $name..."
    git clone --depth 1 --quiet "$url" "$dest"
  fi
done

echo ""
echo "Done! Restart Vim to load the plugins."
