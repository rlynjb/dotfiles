# ===========================================
# Zsh Configuration (2026 Modern Setup)
# ===========================================

# ------------------------------------
# Path
# ------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# Homebrew (Apple Silicon)
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ------------------------------------
# History
# ------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt HIST_REDUCE_BLANKS     # Remove extra blanks

# ------------------------------------
# Options
# ------------------------------------
setopt AUTO_CD                # cd by typing directory name
setopt CORRECT                # Command correction
setopt INTERACTIVE_COMMENTS   # Allow comments in interactive shell

# ------------------------------------
# Completion
# ------------------------------------
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completion
zstyle ':completion:*' menu select                        # Arrow-key driven menu

# ------------------------------------
# Key bindings (emacs mode)
# ------------------------------------
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ------------------------------------
# Modern CLI aliases
# ------------------------------------
# eza (ls replacement)
if command -v eza &> /dev/null; then
  alias ls="eza --icons"
  alias ll="eza -la --icons --git"
  alias lt="eza -la --icons --tree --level=2"
fi

# bat (cat replacement)
if command -v bat &> /dev/null; then
  alias cat="bat --style=auto"
fi

# fd (find replacement) — no alias needed, just use `fd`

# ripgrep — no alias needed, just use `rg`

# ------------------------------------
# Tool integrations
# ------------------------------------
# fzf — fuzzy finder
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zoxide (smart cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# atuin (better shell history)
if command -v atuin &> /dev/null; then
  eval "$(atuin init zsh)"
fi

# direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# ------------------------------------
# Zsh plugins (Homebrew-installed)
# ------------------------------------
# Syntax highlighting
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions
if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ------------------------------------
# Starship prompt (must be last)
# ------------------------------------
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi
