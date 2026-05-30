#!/bin/bash
# Install modern CLI tools via Homebrew
# Run: bash brew-install.sh

set -e

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing modern developer tools..."

# Terminal & Shell
brew install starship        # Cross-shell prompt (replaces oh-my-zsh themes)
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting

# Modern CLI replacements
brew install eza             # ls replacement (colors, icons, git status)
brew install bat             # cat replacement (syntax highlighting)
brew install ripgrep         # grep replacement (10-100x faster)
brew install fd              # find replacement (simpler, faster)
brew install fzf             # Fuzzy finder for everything
brew install zoxide          # Smart cd that learns your directories
brew install lazygit         # Git TUI (replaces tig)
brew install atuin           # Better shell history with fuzzy search

# Tmux (latest version)
brew install tmux

# Optional but nice
brew install btop            # Beautiful system monitor
brew install yazi            # Terminal file manager

# Set up fzf key bindings
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

echo ""
echo "All tools installed! Next steps:"
echo "  1. Run: bash install.sh"
echo "  2. Restart your terminal"
echo "  3. Run: atuin login (optional, for history sync)"
