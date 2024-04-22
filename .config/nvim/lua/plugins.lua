-- Automatically install Packer from the get go
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  -- Themes
  use("joshdick/onedark.vim")
  use("tjdevries/colorbuddy.vim")
  use("folke/tokyonight.nvim")
  use("morhetz/gruvbox")
  use("rebelot/kanagawa.nvim")
  use({ "catppuccin/nvim", as = "catppuccin" })

  use({
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        override = function(root_dir, library)
          if root_dir:find("/etc/nixos", 1, true) == 1 then
            library.enabled = true
            library.plugins = true
          end
        end,
      })
    end,
  })

  use({
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>")
      vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>")
      vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>")
      vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
    },
    config = function()
      require("telescope").load_extension("harpoon")
      require("telescope").load_extension("git_worktree")
    end,
  })
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

  use("ThePrimeagen/harpoon")
  use("ThePrimeagen/git-worktree.nvim")

  -- Avoids overhead of creating filetypes manually e.g., *.astro
  use("nathom/filetype.nvim")

  -- For LSPs, Linters, and Formatters
  use({
    "neovim/nvim-lspconfig",
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "onsails/lspkind.nvim",
      "j-hui/fidget.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("lsp-setup")
    end,
  })

  -- For auto completion, snippets, and suggestions
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      -- 'quangnguyen30192/cmp-nvim-ultisnips',
      "octaltree/cmp-look",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("cmp-setup")
    end,
  })

  -- For code highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("treesitter-configs")
    end,
  })
  use({
    -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  })
  use({
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
  })

  use({
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  })

  use("tpope/vim-surround")
  use("terrortylor/nvim-comment")
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- NOTE: Defaults are satisfactory
      })
    end,
  })

  -- Useful for git blame and other cool git stuffs
  use("tpope/vim-fugitive")
  use({
    "shumphrey/fugitive-gitlab.vim",
    after = "vim-fugitive",
  })

  use({
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  })

  use({
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("toggleterm").setup()
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        indent = {
          char = "┊",
        },
        whitespace = {
          remove_blankline_trail = false,
        },
      })
    end,
  })
  use("tpope/vim-sleuth")

  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
    end,
  })

  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "nvim-tree/nvim-web-devicons",
      opt = true,
    },
    config = function()
      require("lualine").setup({ sections = { lualine_c = { require("auto-session.lib").current_session_name } } })
    end,
  })

  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = true,
      })
    end,
  })

  use({
    "rmagatti/session-lens",
    requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
    config = function()
      require("session-lens").setup()
    end,
  })

  -- Check if packer has been recently installed, sync changes
  if packer_bootstrap then
    require("packer").sync()
  end
end)
