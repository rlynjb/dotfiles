#!/bin/bash
# Install the custom Instant Markdown preview theme into instant-markdown-d.
# Usage: bash install-instant-markdown-theme.sh

set -e

THEME_NAME="reincodes"
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
THEME_SRC="$DOTFILES_DIR/instant-markdown-themes/$THEME_NAME"

if ! command -v npm >/dev/null 2>&1; then
  echo "  npm not found; skipping Instant Markdown theme install."
  exit 0
fi

NPM_ROOT="$(npm root -g)"
THEME_DEST="$NPM_ROOT/instant-markdown-d/css/themes/$THEME_NAME"

if [ ! -d "$NPM_ROOT/instant-markdown-d" ]; then
  echo "  instant-markdown-d is not installed; run: npm install -g instant-markdown-d"
  exit 0
fi

mkdir -p "$THEME_DEST"
cp "$THEME_SRC/github-markdown.css" "$THEME_DEST/github-markdown.css"
cp "$THEME_SRC/github-syntax-highlight.css" "$THEME_DEST/github-syntax-highlight.css"

echo "  Installed Instant Markdown theme '$THEME_NAME' -> $THEME_DEST"
