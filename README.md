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

## What's installed

**Shell (zsh):** starship, zsh-autosuggestions, zsh-syntax-highlighting, fzf, zoxide, atuin

**CLI tools:** eza, bat, ripgrep, fd, lazygit, btop, yazi

**Editor:** neovim

**Multiplexer:** tmux

### Neovim plugins (managed by lazy.nvim, auto-installed)

- **UI:** catppuccin, lualine, nvim-web-devicons, indent-blankline
- **Navigation:** telescope (+ fzf-native, plenary), nvim-tree
- **Syntax & LSP:** nvim-treesitter, nvim-lspconfig, mason + mason-lspconfig
- **Completion:** nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, LuaSnip, cmp_luasnip
- **Editing:** nvim-autopairs, Comment.nvim, gitsigns, which-key

## Tmux workspace (`deven`)

The `deven` script launches a 3-window tmux session:

- **Window 0** — editor layout: left pane runs `vim`, two shell panes on the right
- **Window 1** — two shells side by side (70/30 split)
- **Window 2** — two shells side by side (70/30 split)

Run `deven` to create or attach. Prefix is `Option+A` (see Troubleshooting if it doesn't fire).

## Troubleshooting

### tmux prefix (Option+A) does nothing

macOS sends Option+A as `å` by default, not as Meta. tmux never sees the prefix.

Fix in iTerm2:

1. `⌘,` to open Settings
2. **Profiles** → your profile → **Keys** → **General**
3. Set **Left Option key** to `Esc+` (and Right Option too, if you use it)

Verify: in a shell, press `Ctrl+V` then `Option+A`. Before the fix it prints `å`; after, it prints `^[a` (Esc + a = Meta-A).
