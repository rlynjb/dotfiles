# dotfiles

Modern developer environment for macOS — Zsh, Neovim, tmux, and a suite of fast Rust-based CLI tools.

## Quick start

```bash
# 1. Clone the repo
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Install all tools via Homebrew
bash brew-install.sh

# 3. Symlink configs to home directory
bash install.sh

# 4. Restart your terminal

# 5. Open Neovim — plugins auto-install on first launch
nvim
```

## What's included

### File structure

```
dotfiles/
├── .zshrc                    # Shell config (Starship, aliases, tool integrations)
├── .tmux.conf                # Tmux config (vim keybinds, true color, mouse)
├── .vimrc                    # Legacy Vim config (kept as fallback)
├── .config/
│   ├── starship.toml         # Starship prompt theme
│   └── nvim/
│       └── init.lua          # Neovim config (lazy.nvim, LSP, Telescope, etc.)
├── deven                     # Tmux session script (3-window dev layout)
├── brew-install.sh           # Homebrew installer for all tools
├── install.sh                # Symlink installer (backs up existing files)
└── README.md
```

### Shell — Zsh + Starship

Replaces Oh-My-Zsh with a lightweight, fast setup:

- **Starship** — Rust-based prompt, shows git branch/status, language versions, command duration
- **zsh-autosuggestions** — fish-like suggestions as you type
- **zsh-syntax-highlighting** — colors valid/invalid commands in real time
- **fzf** — fuzzy finder bound to `Ctrl+T` (files) and `Ctrl+R` (history)
- **zoxide** — smart `cd` replacement, use `z` to jump to frecent directories
- **atuin** — SQLite-backed shell history with fuzzy search and context
- **direnv** — auto-loads `.envrc` files per project

### Editor — Neovim + lazy.nvim

A kickstart-style Neovim config in a single `init.lua`. Plugins are managed by lazy.nvim and auto-install on first launch.

**Plugins included:**

| Plugin | Purpose |
|--------|---------|
| catppuccin | Color scheme (mocha) |
| lualine | Status line |
| telescope + fzf-native | Fuzzy file/grep/buffer finder |
| nvim-tree | File explorer sidebar |
| treesitter | Syntax highlighting + indentation for 15+ languages |
| nvim-lspconfig + mason | Language server support (auto-installs lua_ls, ts_ls) |
| nvim-cmp + luasnip | Autocompletion with snippets |
| gitsigns | Git diff markers in the gutter |
| nvim-autopairs | Auto-close brackets, quotes, etc. |
| indent-blankline | Indent guide lines |
| Comment.nvim | Toggle comments with `gcc` / `gc` |
| which-key | Shows available keybindings as you type |

**Carried over from the old .vimrc:**
- 2-space tabs, `expandtab`, `smartindent`
- No backup/swap files, persistent undo
- `Ctrl+h/j/k/l` for split navigation
- `Shift+h/j/k/l` for split resizing
- Natural split opening (below + right)
- Line numbers (now with relative numbers too)

### Multiplexer — tmux

Modernized config with all original keybinds preserved:

- **Fixed:** deprecated `bind -t vi-copy` syntax (broken since tmux 2.4)
- **Added:** true color support, mouse, `pbcopy` integration, pane numbering from 1
- **Added:** new panes/windows inherit current directory
- **Added:** `Ctrl+h/j/k/l` for pane switching without prefix (works alongside Neovim)
- **Added:** clean minimal status bar

### CLI tools

All installed via `brew-install.sh`:

| Classic | Modern | What it does |
|---------|--------|--------------|
| `ls` | **eza** | `ls` with colors, icons, git status. Aliased: `ls`, `ll`, `lt` |
| `cat` | **bat** | Syntax-highlighted file viewer. Aliased: `cat` |
| `grep -r` | **ripgrep** | 10-100x faster recursive search. Use: `rg "pattern"` |
| `find` | **fd** | Simpler, faster file finder. Use: `fd "pattern"` |
| `cd` | **zoxide** | Learns your directories. Use: `z dirname` |
| `Ctrl+R` | **fzf** | Fuzzy finder for files, history, everything |
| `Ctrl+R` | **atuin** | SQLite shell history with context and sync |
| `tig` | **lazygit** | Full git TUI — staging, log, rebase, stash |
| `top` | **btop** | Beautiful system monitor |
| `ranger` | **yazi** | Fast terminal file manager with previews |

## Keyboard shortcuts

### Tmux (prefix: `Alt/Option + a`)

| Action | Keys |
|--------|------|
| Split right | `prefix` `d` |
| Split below | `prefix` `s` |
| New window | `prefix` `t` |
| Next window | `prefix` `]` |
| Previous window | `prefix` `[` |
| Kill pane | `prefix` `e` |
| Kill window | `prefix` `w` |
| Resize pane | `prefix` `h` / `j` / `k` / `l` |
| Switch pane (no prefix) | `Ctrl` `h` / `j` / `k` / `l` |
| Enter copy mode | `prefix` `Escape` |
| Begin selection (copy mode) | `v` |
| Copy selection (copy mode) | `y` (copies to system clipboard) |
| Paste | `prefix` `p` |
| Maximize pane toggle | `prefix` `z` |

### Neovim (leader: `Space`)

**Navigation:**

| Action | Keys |
|--------|------|
| Find files | `Space` `ff` |
| Live grep (search in files) | `Space` `fg` |
| Find open buffers | `Space` `fb` |
| Recent files | `Space` `fr` |
| Help tags | `Space` `fh` |
| Toggle file explorer | `Space` `e` |
| Split navigation | `Ctrl` `h` / `j` / `k` / `l` |
| Split resize | `Shift` `h` / `j` / `k` / `l` |
| Clear search highlight | `Esc` |

**LSP (active in supported files):**

| Action | Keys |
|--------|------|
| Go to definition | `gd` |
| Find references | `gr` |
| Hover documentation | `K` |
| Rename symbol | `Space` `rn` |
| Code actions | `Space` `ca` |

**Editing:**

| Action | Keys |
|--------|------|
| Toggle comment | `gcc` (line) / `gc` (selection) |
| Autocomplete | `Tab` / `Ctrl+n` / `Ctrl+p` |
| Confirm completion | `Enter` |
| Trigger completion | `Ctrl+Space` |

### Dev session

```bash
# Launch the tmux dev layout — 3 windows, each with splits
deven
```

Window 0: two shells + vim (editor layout)
Window 1: two-pane shell
Window 2: two-pane shell

## Migrating from the old setup

This repo was modernized from an older setup (Oh-My-Zsh + Vim + Pathogen). Here's what changed:

| Before | After |
|--------|-------|
| Oh-My-Zsh + pygmalion theme | Starship prompt + zsh plugins via Homebrew |
| Vim + Pathogen (dead) | Neovim + lazy.nvim |
| indentLine plugin | indent-blankline.nvim (Treesitter-aware) |
| Manual filetype autocmds | Treesitter handles all syntax/indent |
| `grep -rnC2` for search | `rg` (ripgrep) + Telescope in Neovim |
| tig for git | lazygit |
| `bind -t vi-copy` (broken) | `bind -T copy-mode-vi` (fixed) |
| `screen-256color` | `tmux-256color` + true color overrides |

Your old `.vimrc` is still symlinked so `vim` keeps working. To fully switch, just use `nvim` instead.
