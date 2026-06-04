# dotfiles

Modern developer environment for macOS — Zsh, Vim, tmux, and a suite of fast Rust-based CLI tools.

## Contents

- [Quick start](#quick-start)
- [Commands](#commands)
  - [Tmux](#tmux)
  - [Tmux saved sessions (resurrect + continuum)](#tmux-saved-sessions-resurrect--continuum)
  - [Vim](#vim)

## Quick start

### 1. Clone and install

```bash
# Clone
git clone https://github.com/rlynjb/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install all tools via Homebrew
bash brew-install.sh

# Symlink configs to home (includes the reincodes script on $PATH)
bash install.sh

# Install TPM — required for tmux-resurrect + tmux-continuum (session persistence)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Configure iTerm2

Open `⌘, → Profiles → your profile → Keys`, then apply both of these one-time changes:

#### a. Enable `Option+A` as the tmux prefix

- **Tab:** General
- **Field:** Left Option key (and Right, if you use it)
- **Set to:** `Esc+`
- **Why:** so `Option+A` reaches tmux as the prefix instead of being eaten by macOS as `å`
- **Verify:** in a shell, press `Ctrl+V` then `Option+A` — should print `^[a` (not `å`)

#### b. Enable macOS-style word/line motion in the shell

- **Tab:** Key Mappings
- **Action:** click **Presets…** → select **Natural Text Editing**
- **What it adds:** macOS-style word/line motion in the shell — `Option+←/→` (jump word), `Cmd+←/→` (jump to line start/end), `Option+Backspace` (delete word), etc.

> The tmux prefix itself (`set -g prefix M-a`) is already in [`.tmux.conf`](./.tmux.conf) and gets symlinked by `install.sh` — no extra step.

### 3. Restart your terminal, then start the workspace

```bash
reincodes
```

Bootstraps the 7-window tmux session. Once inside, press `Option+A` `Shift+I` to install resurrect + continuum — from then on, sessions auto-save every 15 min and restore on next launch.

### 4. Open Vim

```bash
vim
```

Settings live in [`.vimrc`](./.vimrc). See [Vim commands](#vim) for the keybindings you'll actually use day-to-day.

## Commands

### Tmux

Prefix is `Option+A`. `reincodes` handles start-or-attach for the day-to-day workspace.

| Category | Action | Keys / Command |
|---|---|---|
| Session | Detach from current session | `prefix :detach` |
| Session | List running sessions | `tmux ls` |
| Session | Kill the reincodes session | `tmux kill-session -t reincodes` |
| Session | Kill all tmux (nuke + restart) | `tmux kill-server` |
| Panes | Split right (keep cwd) | `prefix d` |
| Panes | Split below (keep cwd) | `prefix s` |
| Panes | Switch pane (no prefix) | `Ctrl h` / `j` / `k` / `l` |
| Panes | Resize pane left/down/up/right | `prefix h` / `j` / `k` / `l` |
| Panes | Kill pane | `prefix e` |
| Panes | Toggle pane zoom | `prefix z` |
| Panes | Show pane numbers (jump by number) | `prefix q` |
| Windows | New window (keep cwd) | `prefix t` |
| Windows | Next / previous window | `prefix ]` / `[` |
| Windows | Kill window | `prefix w` |
| Windows | Rename current window | `prefix ,` |
| Copy | Enter copy mode | `prefix Escape` |
| Copy | Begin selection (in copy mode) | `v` |
| Copy | Copy selection → system clipboard | `y` |
| Copy | Paste buffer | `prefix p` |

### Tmux saved sessions (resurrect + continuum)

`tmux-resurrect` + `tmux-continuum` auto-save every 15 minutes and auto-restore on tmux start — your workspace survives reboots and kills.

**One-time setup** (run once after cloning this repo):

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
```

Then inside tmux press `prefix` `Shift+I` to install the plugins.

**Restored:** sessions, windows, panes, dirs, layout, and whitelisted processes (`vim`, `ssh`, `node`, `python`, …). Snapshots live in `~/.local/share/tmux/resurrect/`; edit `@resurrect-processes` in `.tmux.conf` to whitelist more.

### Vim

Built-in Vim commands only — no plugins. Settings live in [`.vimrc`](./.vimrc).

| Category | Action | Keys |
|---|---|---|
| Files | Open file | `:e <path>` |
| Files | Save | `:w` |
| Files | Save & quit | `:wq` / `:x` / `ZZ` |
| Files | Quit | `:q` |
| Files | Quit, discard changes | `:q!` |
| Files | Save & quit everything | `:wqa` |
| Explorer | Open netrw in current window | `:Ex` |
| Explorer | Open in vertical / horizontal split | `:Vex` / `:Sex` |
| Explorer | Open in new tab | `:Tex` |
| Explorer | Inside netrw — open file | `Enter` |
| Explorer | Inside netrw — create file / dir | `%` / `d` |
| Explorer | Inside netrw — rename / delete | `R` / `D` |
| Explorer | Inside netrw — show help | `:h netrw-quickmap` |
| Tabs | New tab | `:tabnew` |
| Tabs | New tab editing a file | `:tabe <path>` |
| Tabs | Next / previous tab | `gt` / `gT` |
| Tabs | Jump to tab N | `<N>gt` (e.g. `2gt`) |
| Tabs | Close current / others | `:tabclose` / `:tabonly` |
| Buffers | Edit file as buffer | `:e <path>` |
| Buffers | Next / previous buffer | `:bn` / `:bp` |
| Buffers | List open buffers | `:ls` |
| Buffers | Switch by number | `:b<N>` |
| Buffers | Close buffer | `:bd` |
| Splits | Horizontal / vertical split | `:split` / `:vsplit` |
| Splits | Move between splits | `Ctrl+w` then `h` / `j` / `k` / `l` |
| Splits | Close current | `Ctrl+w` then `q` (or `:q`) |
| Splits | Make full-screen | `Ctrl+w` then `o` |
| Splits | Resize | `Ctrl+w` then `+` / `-` / `>` / `<` |
| Navigation | Top / bottom of file | `gg` / `G` |
| Navigation | Go to line N | `:N` or `Ngg` |
| Navigation | Word forward / back | `w` / `b` |
| Navigation | Start / end of line | `0` / `$` |
| Navigation | Jump back / forward through history | `Ctrl+o` / `Ctrl+i` |
| Search | Search forward / backward | `/pattern` / `?pattern` |
| Search | Next / previous match | `n` / `N` |
| Search | Clear highlights | `:noh` |
| Search | Replace in file | `:%s/old/new/g` |
| Search | Replace with confirmation | `:%s/old/new/gc` |
| Editing | Insert at cursor / line start | `i` / `I` |
| Editing | Insert after cursor / line end | `a` / `A` |
| Editing | New line below / above | `o` / `O` |
| Editing | Delete char / line | `x` / `dd` |
| Editing | Yank line / paste after / before | `yy` / `p` / `P` |
| Editing | Undo / redo | `u` / `Ctrl+r` |
| Editing | Visual select (char / line / block) | `v` / `V` / `Ctrl+v` |
| Autocomplete | Word (next / prev) | `Ctrl+n` / `Ctrl+p` |
| Autocomplete | File path | `Ctrl+x` `Ctrl+f` |
| Autocomplete | Language-aware (omni) | `Ctrl+x` `Ctrl+o` |

