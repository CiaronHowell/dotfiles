-- Automatically install Packer from the get go
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use 'joshdick/onedark.vim'

  -- For code highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep'
    },
    config = function()
      require('telescope').load_extension('harpoon')
    end
  }
  use 'ThePrimeagen/harpoon'

  -- Avoids overhead of creating filetypes manually e.g., *.astro
  use 'nathom/filetype.nvim'

  -- For LSPs, Linters, and Formatters
  use {
    "williamboman/mason.nvim",
    requires = {
      "neovim/nvim-lspconfig",
      'onsails/lspkind.nvim',
      "williamboman/mason-lspconfig.nvim",
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      require('lsp-setup')
    end
  }

  -- For auto completion, snippets, and suggestions
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
      'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-nvim-lua',
      'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
      'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
    },
    config = function()
      require('cmp-setup')
    end
  }
  use {
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'SirVer/ultisnips'

  -- For a spicy statusline
  --use({
  --'glepnir/galaxyline.nvim',
  --branch = 'main',
  -- your statusline
  --config = function()
  --require('my_statusline')
  --end,
  -- some optional icons
  --requires = { 'kyazdani42/nvim-web-devicons', opt = true },
  --})

  -- Useful for git blame and other cool git stuffs
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'akinsho/toggleterm.nvim',
    tag = '*',
    config = function()
      require('toggleterm').setup()
    end
  }

  use { 'tjdevries/colorbuddy.vim' }

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use "lukas-reineke/indent-blankline.nvim"

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = {
      require('nvim-tree').setup()
    }
  }

  -- Check if packer has been recently installed, sync changes
  if packer_bootstrap then
    require('packer').sync()
  end

end)
