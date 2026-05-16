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
- [Tmux workspace (`reincodes`)](#tmux-workspace-reincodes)
- [Troubleshooting](#troubleshooting)

## Quick start

### 1. Clone and install

```bash
# Clone
git clone https://github.com/your-username/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install all tools via Homebrew
bash brew-install.sh

# Symlink configs to home (includes the reincodes script on $PATH)
bash install.sh

# Install TPM — required for tmux-resurrect + tmux-continuum (session persistence)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 2. Configure iTerm2

In `⌘, → Profiles → your profile → Keys`:

- **General tab:** set **Left Option key** (and Right, if used) to `Esc+`. Required so `Option+A` reaches tmux as the prefix instead of being eaten by macOS as `å`.
- **Key Mappings tab → Presets…:** apply **Natural Text Editing**. Adds macOS-style word/line navigation: `Option+←/→` jumps a word, `Cmd+←/→` jumps to line start/end, `Option+Backspace` deletes a word, etc.
- **Multi-line input in Claude Code / other CLIs:** open Claude Code and type `/terminal-setup`. It auto-adds the iTerm2 key mapping so `Shift+Enter` inserts a newline instead of submitting.

Verify the Option key fix: in a shell press `Ctrl+V` then `Option+A`. Before the fix it prints `å`; after, `^[a`.

### 3. Sync iTerm2 prefs to this repo (one-time)

So your iTerm2 settings travel with your dotfiles to the next machine:

1. `⌘, → General → Preferences` tab
2. Check **Load preferences from a custom folder or URL**
3. Browse to `~/Public/dotfiles/iterm2`
4. When prompted, click **Copy current settings**
5. Check **Save changes to folder when iTerm2 quits** so future tweaks sync automatically
6. Make the plist git-diff friendly by converting it to XML:

```bash
plutil -convert xml1 ~/Public/dotfiles/iterm2/com.googlecode.iterm2.plist
```

On a future fresh machine the plist is already in the repo — just do steps 1-3 above and restart iTerm2; all the keys/themes auto-load.

### 4. Restart your terminal, then start the workspace

```bash
reincodes
```

That bootstraps the personal 7-window tmux session (see [layout](#tmux-workspace-reincodes)). Inside tmux, press `Option+A` `Shift+I` once to install the resurrect + continuum plugins. From then on, your session auto-saves every 15 min and auto-restores on next launch — re-run `reincodes` only on a fresh machine or after wiping `~/.local/share/tmux/`.

### 5. Open Neovim — plugins auto-install on first launch

```bash
nvim
```

## What's installed

<table>
<tr>
<td valign="top" width="50%">

### Shell & CLI tools

- **starship** — prompt with git/language/duration info
- **fzf** — fuzzy finder (`Ctrl+T` files, `Ctrl+R` history)
- **zoxide** — `z <dirname>` jumps to frecent dirs
- **atuin** — searchable shell history
- **lazygit**, **yazi**, **neovim**, **tmux**
- `eza`, `bat`, `ripgrep`, `fd` — modern replacements for `ls`, `cat`, `grep`, `find`

Full list in [`brew-install.sh`](./brew-install.sh).

</td>
<td valign="top" width="50%">

### Neovim plugins (managed by lazy.nvim)

- **catppuccin/nvim** — Mocha color scheme
- **telescope.nvim** — fuzzy file/grep/buffer finder (`Space ff`, `fg`, `fb`)
- **nvim-tree.lua** — file explorer sidebar (`Space e`)
- **nvim-treesitter** — syntax highlighting + indent
- **nvim-lspconfig** + **mason.nvim** — LSP setup
- **nvim-cmp** — autocompletion
- **gitsigns.nvim** — git diff in the gutter
- **which-key.nvim** — keybinding hints as you type

Full list in [`.config/nvim/init.lua`](./.config/nvim/init.lua).

</td>
</tr>
</table>

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

## Tmux workspace (`reincodes`)

The [`reincodes`](./reincodes) script bootstraps the personal tmux workspace. It's the **one-time seed** — useful on a fresh machine, or after wiping resurrect state. Once the workspace is running, [resurrect + continuum](#tmux-saved-sessions-resurrect--continuum) take over and auto-restore it on every tmux start.

### Getting started

On a freshly-cloned machine (after `bash install.sh`):

```bash
reincodes
```

That's it. The script creates the session if it's missing, or attaches to it if it already exists. From this point on:

- Continuum auto-saves the session every 15 min.
- After a reboot, just run `tmux` (or `tmux a -t reincodes`) — your windows come back without re-running `reincodes`.
- Re-run `reincodes` only if the resurrect snapshot is gone (wiped `~/.local/share/tmux/`, brand-new machine, etc.).

### Commands

| Action | Command |
|--------|---------|
| Start (or attach to) the workspace | `reincodes` |
| Attach if you know it's already running | `tmux a -t reincodes` |
| Edit the window/project list | `$EDITOR ~/Public/dotfiles/reincodes` (then commit) |
| Force a snapshot save right now | `prefix` `Ctrl+s` (or `~/.tmux/plugins/tmux-resurrect/scripts/save.sh`) |
| Wipe state and start over from the script | `tmux kill-server && rm -rf ~/.local/share/tmux/resurrect && reincodes` |

### Layout

| Window | Path | Panes |
|--------|------|-------|
| `home` | `~` | 1 |
| `unshippd` | `~/Public/unshippd` | 2 (64% / 36% horizontal split) |
| `dotfiles` | `~/Public/dotfiles` | 2 |
| `aipe` | `~/Public/aipe` | 2 |
| `contrl` | `~/Public/contrl` | 2 |
| `loopd` | `~/Public/loopd` | 2 |
| `reincodes` | `~/Public/reincodes` | 2 |

### Adding or removing a window

The script is **static by design** — it's the curated baseline, not a mirror of your live state. To change it:

1. Edit the `projects` array in [`reincodes`](./reincodes) — one line per `"name|path"`.
2. Commit the change so it follows you to new machines.

Day-to-day ad-hoc windows (a temporary scratch session, a one-off repo) don't need to be in the script — resurrect captures them automatically. Only edit `reincodes` when you've decided a window is part of your *permanent* setup.

### How `reincodes` and resurrect work together

The two systems handle different jobs. Walk through this example to see how they hand off:

1. **Day 0** — fresh Mac, you clone the dotfiles and run `reincodes`. You get the 7 baseline windows (`home`, `unshippd`, `dotfiles`, `aipe`, `contrl`, `loopd`, `reincodes`).
2. **Day 1** — you add an 8th window for a new project: `~/Public/newproject`. Continuum picks it up within 15 min and writes it to `~/.local/share/tmux/resurrect/`.
3. **Day 2** — Mac reboots. You run `tmux`. Continuum auto-restores all **8** windows, including `newproject`. ✅ You never re-ran `reincodes`.
4. **Day 30** — you wipe the laptop and clone the dotfiles on a brand-new Mac. No resurrect snapshot exists yet. You run `reincodes`.  You get the original **7** windows. ❌ `newproject` is gone — it was only in the snapshot, not in the script.

**Takeaway:** if a project becomes part of your permanent setup, add it to the `reincodes` script and commit. Everything else lives happily in resurrect snapshots without bloating the repo.

## Troubleshooting

### tmux prefix (Option+A) does nothing

See [Quick start → step 2](#2-configure-iterm2) — iTerm2 needs **Left Option key** set to `Esc+`.
