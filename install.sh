#!/bin/bash
# Dotfiles installer — creates symlinks from home directory to this repo
# Usage: bash install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# ------------------------------------
# Helper: create symlink with backup
# ------------------------------------
link_file() {
  local src="$1"
  local dest="$2"

  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "  Backing up existing $dest -> ${dest}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -s "$src" "$dest"
  echo "  Linked $dest -> $src"
}

# ------------------------------------
# Home directory dotfiles
# ------------------------------------
echo "==> Linking dotfiles to home directory..."

link_file "$DOTFILES_DIR/.zshrc"      "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.tmux.conf"  "$HOME/.tmux.conf"
link_file "$DOTFILES_DIR/.vimrc"      "$HOME/.vimrc"

# ------------------------------------
# XDG config directories (~/.config/)
# ------------------------------------
echo ""
echo "==> Linking .config directories..."

mkdir -p "$HOME/.config"

# Neovim
if [ -d "$DOTFILES_DIR/.config/nvim" ]; then
  link_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
fi

# Starship
if [ -f "$DOTFILES_DIR/.config/starship.toml" ]; then
  link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
fi

# ------------------------------------
# Scripts (tmux workspace bootstrap)
# ------------------------------------
echo ""
echo "==> Linking scripts..."

mkdir -p "$HOME/.local/bin"
link_file "$DOTFILES_DIR/reincodes" "$HOME/.local/bin/reincodes"
chmod +x "$HOME/.local/bin/reincodes"

# ------------------------------------
# Done
# ------------------------------------
echo ""
echo "Done! Symlinks created."
echo ""
echo "Next steps:"
echo "  1. Run 'bash brew-install.sh' to install tools (if not done)"
echo "  2. Restart your terminal (or run: source ~/.zshrc)"
echo "  3. Open nvim — plugins will auto-install on first launch"
