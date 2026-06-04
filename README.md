# dotfiles

Modern developer environment for macOS — Zsh, Vim, tmux, and a suite of fast Rust-based CLI tools.

## Contents

- [Quick start](#quick-start)
- [Commands](#commands)
  - [Tmux sessions (CLI)](#tmux-sessions-cli)
  - [Tmux prefix bindings](#tmux-prefix-optiona)
  - [Tmux extras worth knowing](#tmux--extras-worth-knowing)
  - [Tmux saved sessions (resurrect + continuum)](#tmux-saved-sessions-resurrect--continuum)
  - [Vim](#vim)
  - [Shell aliases](#shell-aliases-zsh)

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

> `prefix d` is rebound to split-right — use `prefix :detach` (or close the iTerm2 window in `-CC` mode).

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

**Rebound defaults** — `d`, `s`, `w`, `p` no longer do their stock thing:

| Lost default | What it did | Workaround |
|---|---|---|
| `prefix d` | Detach session | `prefix :detach` |
| `prefix s` | Interactive session picker | `prefix :choose-tree -s` |
| `prefix w` | Interactive window picker | `prefix :choose-tree -w` |

**Still-active defaults:**

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

**Sync typing across panes** (broadcast to every pane):

```
prefix :setw synchronize-panes on
prefix :setw synchronize-panes off
```

**Keep manual window names sticky** — tmux otherwise overwrites them with the running command. Add to `.tmux.conf`:

```tmux
set -g allow-rename off
setw -g automatic-rename off
```

### Tmux saved sessions (resurrect + continuum)

`tmux-resurrect` + `tmux-continuum` auto-save every 15 minutes and auto-restore on tmux start — your workspace survives reboots and kills.

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

**Restored:** sessions, windows, panes, dirs, layout, and whitelisted processes (`vim`, `ssh`, `node`, `python`, …). Snapshots live in `~/.local/share/tmux/resurrect/`; edit `@resurrect-processes` in `.tmux.conf` to whitelist more.

### Vim

Built-in Vim commands only — no plugins. Settings live in [`.vimrc`](./.vimrc).

**Files & quitting:**

| Action | Keys |
|--------|------|
| Open file | `:e <path>` |
| Save | `:w` |
| Save & quit | `:wq` / `:x` / `ZZ` |
| Quit | `:q` |
| Quit, discard changes | `:q!` |
| Save & quit everything | `:wqa` |

**File explorer (netrw, built-in):**

| Action | Keys |
|--------|------|
| Open explorer in current window | `:Ex` |
| Open in vertical split | `:Vex` |
| Open in horizontal split | `:Sex` |
| Open in new tab | `:Tex` |
| Inside netrw — open file | `Enter` |
| Inside netrw — create file | `%` |
| Inside netrw — create directory | `d` |
| Inside netrw — rename | `R` |
| Inside netrw — delete | `D` |
| Inside netrw — show help | `:h netrw-quickmap` |

**Tabs:**

| Action | Keys |
|--------|------|
| New tab | `:tabnew` |
| New tab editing a file | `:tabe <path>` |
| Next / previous tab | `gt` / `gT` |
| Jump to tab N | `<N>gt` (e.g. `2gt`) |
| Close current tab | `:tabclose` |
| Close all other tabs | `:tabonly` |

**Buffers:**

| Action | Keys |
|--------|------|
| Edit file as buffer | `:e <path>` |
| Next / previous buffer | `:bn` / `:bp` |
| List open buffers | `:ls` |
| Switch by number | `:b<N>` |
| Close buffer | `:bd` |

**Splits & windows:**

| Action | Keys |
|--------|------|
| Horizontal split | `:split` / `:sp` |
| Vertical split | `:vsplit` / `:vs` |
| Move between splits | `Ctrl+w` then `h` / `j` / `k` / `l` |
| Close current split | `Ctrl+w` then `q` (or `:q`) |
| Make split full-screen | `Ctrl+w` then `o` |
| Resize | `Ctrl+w` then `+` / `-` / `>` / `<` |

**Navigation:**

| Action | Keys |
|--------|------|
| Top / bottom of file | `gg` / `G` |
| Go to line N | `:N` or `Ngg` |
| Word forward / back | `w` / `b` |
| Start / end of line | `0` / `$` |
| Jump back / forward through history | `Ctrl+o` / `Ctrl+i` |

**Search & replace:**

| Action | Keys |
|--------|------|
| Search forward | `/pattern` `Enter` |
| Search backward | `?pattern` `Enter` |
| Next / previous match | `n` / `N` |
| Clear highlights | `:noh` |
| Replace in file | `:%s/old/new/g` |
| Replace with confirmation | `:%s/old/new/gc` |

**Editing:**

| Action | Keys |
|--------|------|
| Insert at cursor / line start | `i` / `I` |
| Insert after cursor / line end | `a` / `A` |
| Open new line below / above | `o` / `O` |
| Delete char / line | `x` / `dd` |
| Yank line / paste | `yy` / `p` (after) / `P` (before) |
| Undo / redo | `u` / `Ctrl+r` |
| Visual select (char / line / block) | `v` / `V` / `Ctrl+v` |

**Autocompletion (insert mode):**

| Action | Keys |
|--------|------|
| Word completion (next / prev) | `Ctrl+n` / `Ctrl+p` |
| File path completion | `Ctrl+x` `Ctrl+f` |
| Language-aware (omni) | `Ctrl+x` `Ctrl+o` |

### Shell aliases (zsh)

| Alias | Runs |
|-------|------|
| `ls` | `eza --icons` |
| `ll` | `eza -la --icons --git` |
| `lt` | `eza -la --icons --tree --level=2` |
| `cat` | `bat --style=auto` |

Plus `Ctrl+T` (fzf files), `Ctrl+R` (atuin/fzf history), `z <dir>` (zoxide jump).

