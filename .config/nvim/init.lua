-- ===========================================
-- Neovim Configuration (kickstart-style)
-- Uses lazy.nvim for plugin management
-- ===========================================

-- ------------------------------------
-- Leader key (set before plugins)
-- ------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ------------------------------------
-- Options (carried over from your vimrc)
-- ------------------------------------
vim.opt.number = true           -- Line numbers
vim.opt.relativenumber = true   -- Relative line numbers
vim.opt.tabstop = 2             -- Tab width
vim.opt.shiftwidth = 2          -- Indent width
vim.opt.expandtab = true        -- Spaces instead of tabs
vim.opt.smartindent = true      -- Smart indentation
vim.opt.smarttab = true

vim.opt.backup = false          -- No backup files
vim.opt.swapfile = false        -- No swap files
vim.opt.undofile = true         -- Persistent undo

vim.opt.splitbelow = true       -- Natural split opening
vim.opt.splitright = true

vim.opt.ignorecase = true       -- Case-insensitive search
vim.opt.smartcase = true        -- Unless uppercase is used
vim.opt.hlsearch = true         -- Highlight search
vim.opt.incsearch = true        -- Incremental search

vim.opt.termguicolors = true    -- True color support
vim.opt.signcolumn = "yes"      -- Always show sign column
vim.opt.scrolloff = 8           -- Keep 8 lines above/below cursor
vim.opt.updatetime = 250        -- Faster completion
vim.opt.timeoutlen = 300        -- Faster key sequence completion

vim.opt.wildmenu = true         -- Command-line completion (from your vimrc)
vim.opt.cursorline = true       -- Highlight current line
vim.opt.wrap = false            -- No line wrap

-- ------------------------------------
-- Keymaps (carried over from your vimrc)
-- ------------------------------------
local map = vim.keymap.set

-- Split navigation: Ctrl+hjkl (same as your vimrc)
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower split" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper split" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right split" })

-- Split resizing (Shift+hjkl, like your vimrc)
map("n", "<S-h>", ":vertical resize -5<CR>", { silent = true })
map("n", "<S-l>", ":vertical resize +5<CR>", { silent = true })
map("n", "<S-j>", ":resize -5<CR>", { silent = true })
map("n", "<S-k>", ":resize +5<CR>", { silent = true })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better visual indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ------------------------------------
-- Bootstrap lazy.nvim
-- ------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ------------------------------------
-- Plugins
-- ------------------------------------
require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha" })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin" },
      })
    end,
  },

  -- Fuzzy finder (replaces grep -rn workflow)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
    end,
  },

  -- File explorer (replaces netrw)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = { width = 30 },
      })
      map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- Treesitter (modern syntax highlighting, replaces all your BufNewFile autocmds)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc",
          "javascript", "typescript", "tsx",
          "html", "css", "json",
          "python", "go", "rust",
          "bash", "markdown", "yaml", "toml",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP (Language Server Protocol)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls" },
      })

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- TypeScript/JavaScript
      lspconfig.ts_ls.setup({ capabilities = capabilities })

      -- LSP keymaps (active when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Indent guides (replaces your indentLine plugin)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  -- Comment toggling
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  -- Which-key (shows available keybindings)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = true,
  },
}, {
  -- lazy.nvim options
  checker = { enabled = true, notify = false },
})
