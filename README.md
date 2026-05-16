# dotfiles

Modern developer environment for macOS — Zsh, Neovim, tmux, and a suite of fast Rust-based CLI tools.

## Contents

- [Quick start](#quick-start)
- [What's installed](#whats-installed)
  - [Shell & CLI tools](#shell--cli-tools)
  - [Neovim plugins](#neovim-plugins-managed-by-lazynvim)
- [Commands](#commands)
  - [Tmux sessions (CLI)](#tmux-sessions-cli)
  - [Tmux prefix bindings](#tmux-prefix-optiona)
  - [Tmux extras worth knowing](#tmux--extras-worth-knowing)
  - [Tmux saved sessions (resurrect + continuum)](#tmux-saved-sessions-resurrect--continuum)
  - [Neovim](#neovim-leader-space)
  - [Shell aliases](#shell-aliases-zsh)
- [Troubleshooting](#troubleshooting)

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

## What's installed

### Shell & CLI tools

| Tool | Purpose |
|------|---------|
| starship | Cross-shell prompt with git, language, duration info |
| zsh-autosuggestions | Fish-like suggestions as you type |
| zsh-syntax-highlighting | Colors valid/invalid commands in real time |
| fzf | Fuzzy finder bound to `Ctrl+T` (files) and `Ctrl+R` (history) |
| zoxide | Smart `cd` — `z dirname` jumps to frecent dirs |
| atuin | SQLite shell history with fuzzy search and sync |
| eza | `ls` replacement (colors, icons, git status) |
| bat | `cat` replacement (syntax highlighting) |
| ripgrep | `grep` replacement, much faster (`rg`) |
| fd | `find` replacement, simpler syntax |
| lazygit | Git TUI for staging, log, rebase, stash |
| btop | System monitor |
| yazi | Terminal file manager with previews |
| neovim | Modern Vim |
| tmux | Terminal multiplexer |

### Neovim plugins (managed by lazy.nvim)

| Plugin | Purpose |
|--------|---------|
| catppuccin/nvim | Color scheme (mocha) |
| nvim-lualine/lualine.nvim | Status line |
| nvim-tree/nvim-web-devicons | File-type icons |
| nvim-telescope/telescope.nvim | Fuzzy file/grep/buffer finder |
| nvim-telescope/telescope-fzf-native.nvim | Native fzf sorter for telescope |
| nvim-lua/plenary.nvim | Lua utility lib (telescope dep) |
| nvim-tree/nvim-tree.lua | File explorer sidebar |
| nvim-treesitter/nvim-treesitter | Syntax highlighting + indent for many langs |
| neovim/nvim-lspconfig | Language server configs |
| mason-org/mason.nvim | Auto-installs LSP servers, linters, formatters |
| mason-org/mason-lspconfig.nvim | Bridges mason with lspconfig |
| hrsh7th/nvim-cmp | Autocompletion engine |
| hrsh7th/cmp-nvim-lsp | LSP source for nvim-cmp |
| hrsh7th/cmp-buffer | Buffer-words source for nvim-cmp |
| hrsh7th/cmp-path | Filesystem-path source for nvim-cmp |
| L3MON4D3/LuaSnip | Snippet engine |
| saadparwaiz1/cmp_luasnip | Snippet source for nvim-cmp |
| lewis6991/gitsigns.nvim | Git diff markers in the gutter |
| windwp/nvim-autopairs | Auto-close brackets, quotes, etc. |
| lukas-reineke/indent-blankline.nvim | Indent guide lines |
| numToStr/Comment.nvim | Toggle comments with `gcc` / `gc` |
| folke/which-key.nvim | Shows available keybindings as you type |

## Commands

### Tmux sessions (CLI)

| Action | Command |
|--------|---------|
| Start a new unnamed session | `tmux` |
| Start a new named session | `tmux new -s <name>` |
| Start detached (in background) | `tmux new -s <name> -d` |
| List running sessions | `tmux ls` |
| Attach to last session | `tmux a` |
| Attach to a specific session | `tmux a -t <name>` |
| Detach from inside a session | `prefix` `:detach` |
| Kill a specific session | `tmux kill-session -t <name>` |
| Kill the tmux server (all sessions) | `tmux kill-server` |
| Rename a window (from a shell inside tmux) | `tmux rename-window <name>` |
| Rename a session | `tmux rename-session -t <old> <new>` |

**iTerm2 native mode** — opens tmux panes as iTerm2 splits with real ⌘ shortcuts:

```bash
tmux -CC new -s <name>      # new session in native mode
tmux -CC a  -t <name>       # attach existing session in native mode
```

> Note: this config rebinds `prefix d` to "split right", so the default `prefix d` detach no longer works. Use `prefix :detach` (or just close the iTerm2 window in `-CC` mode — the session keeps running).

### Tmux (prefix: `Option+A`)

| Action | Keys |
|--------|------|
| Send prefix | `prefix` `Option+A` |
| Split right (keep cwd) | `prefix` `d` |
| Split below (keep cwd) | `prefix` `s` |
| New window (keep cwd) | `prefix` `t` |
| Next window | `prefix` `]` |
| Previous window | `prefix` `[` |
| Kill pane | `prefix` `e` |
| Kill window | `prefix` `w` |
| Resize pane left/down/up/right | `prefix` `h` / `j` / `k` / `l` |
| Switch pane (no prefix) | `Ctrl` `h` / `j` / `k` / `l` |
| Enter copy mode | `prefix` `Escape` |
| Begin selection (copy mode) | `v` |
| Copy selection → system clipboard | `y` |
| Paste buffer | `prefix` `p` |
| Toggle pane zoom | `prefix` `z` |

### Tmux — extras worth knowing

**Defaults this config overrides** — `d`, `s`, `w`, `p` are rebound, so reach for these workarounds:

| Lost default | What it did | Workaround |
|---|---|---|
| `prefix d` | Detach session | `prefix :detach` |
| `prefix s` | Interactive session picker | `prefix :choose-tree -s` |
| `prefix w` | Interactive window picker | `prefix :choose-tree -w` |

**Still-active tmux defaults worth remembering:**

| Keys | Action |
|------|--------|
| `prefix ,` | Rename current window |
| `prefix $` | Rename session |
| `prefix q` | Show pane numbers (press a number to jump) |
| `prefix Space` | Cycle preset pane layouts |
| `prefix {` / `prefix }` | Swap pane with previous / next |
| `prefix !` | Break current pane into its own window |
| `prefix .` | Move current window to a different index |
| `prefix :` | Open the tmux command prompt (escape hatch) |

**Useful one-offs:**

```bash
tmux new -A -s <name>                          # create-or-attach in one command
tmux source ~/.tmux.conf                       # reload config without restart
tmux send-keys -t <session>:<win>.<pane> "cmd" Enter   # script a pane from outside
tmux capture-pane -t <session>:<win>.<pane> -p          # dump pane contents to stdout
```

**Sync typing across panes** (broadcast a command to every pane in the window):

```
prefix :setw synchronize-panes on
prefix :setw synchronize-panes off
```

**Stop tmux from auto-renaming windows** — by default, tmux overwrites your window name with whatever command is running. To keep your manual names sticky, add to `.tmux.conf`:

```tmux
set -g allow-rename off
setw -g automatic-rename off
```

### Tmux saved sessions (resurrect + continuum)

Sessions, windows, panes, working dirs, and pane layouts are persisted via `tmux-resurrect` + `tmux-continuum`. Continuum auto-saves every 15 minutes and auto-restores on tmux start, so after a reboot or kill you get your workspace back.

**One-time setup** (run once after cloning this repo):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
```

Then inside tmux press `prefix` `Shift+I` to install the plugins.

**Daily use:**

| Action | Command |
|--------|---------|
| Start a fresh session | `tmux new -s <name>` |
| Open the last saved session (auto-restore) | `tmux` — continuum restores the snapshot |
| Attach to a running session | `tmux a -t <name>` |
| Save now (don't wait for the 15-min tick) | `prefix` `Ctrl+s` |
| Restore last snapshot manually | `prefix` `Ctrl+r` |

**What's restored:** sessions, windows, panes, working directories, layout, and whitelisted processes (`vim`, `nvim`, `ssh`, `node`, `python`, …). Edit `@resurrect-processes` in `.tmux.conf` to whitelist more. Snapshots live in `~/.local/share/tmux/resurrect/`.

### Neovim (leader: `Space`)

**Splits & windows:**

| Action | Keys |
|--------|------|
| Move between splits | `Ctrl` `h` / `j` / `k` / `l` |
| Resize vertical split | `Shift` `h` / `l` |
| Resize horizontal split | `Shift` `j` / `k` |
| Clear search highlight | `Esc` |
| Re-select after indent | `<` / `>` (in visual mode) |

**Telescope (fuzzy find):**

| Action | Keys |
|--------|------|
| Find files | `Space` `ff` |
| Live grep | `Space` `fg` |
| Find buffers | `Space` `fb` |
| Recent files | `Space` `fr` |
| Help tags | `Space` `fh` |

**File tree:**

| Action | Keys |
|--------|------|
| Toggle file explorer | `Space` `e` |

**LSP (in supported files):**

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
| Trigger completion | `Ctrl+Space` |
| Confirm completion | `Enter` |
| Cycle completions | `Tab` / `Ctrl+n` / `Ctrl+p` |

### Shell aliases (zsh)

| Alias | Runs |
|-------|------|
| `ls` | `eza --icons` |
| `ll` | `eza -la --icons --git` |
| `lt` | `eza -la --icons --tree --level=2` |
| `cat` | `bat --style=auto` |

Plus `Ctrl+T` (fzf files), `Ctrl+R` (atuin/fzf history), `z <dir>` (zoxide jump).

## Troubleshooting

### tmux prefix (Option+A) does nothing

macOS sends Option+A as `å` by default, not as Meta. tmux never sees the prefix.

Fix in iTerm2:

1. `⌘,` to open Settings
2. **Profiles** → your profile → **Keys** → **General**
3. Set **Left Option key** to `Esc+` (and Right Option too, if you use it)

Verify: in a shell, press `Ctrl+V` then `Option+A`. Before the fix it prints `å`; after, it prints `^[a` (Esc + a = Meta-A).
