return {
	-- Visuals --
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({ transparent_background = true })
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { indent = { char = "┊" }, whitespace = { remove_blankline_trail = false } },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({ sections = { lualine_c = { require("auto-session.lib").current_session_name } } })
		end,
	},
	"tpope/vim-sleuth",

	-- Workspace Movement --
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"BurntSushi/ripgrep",
		},
		config = function()
			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("git_worktree")
		end,
	},
	"ThePrimeagen/harpoon",
	"ThePrimeagen/git-worktree.nvim",
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup()
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false, -- We want the plugin to run from the get go
		config = function()
			vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>")
			vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>")
			vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>")
			vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>")
		end,
	},

	-- LSPs, linters, and formatters --
	"folke/neodev.nvim",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false, opts = { auto_install = true } },
			"williamboman/mason-lspconfig.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			require("lsp-setup")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-setup") -- require your null-ls config here (example below)
		end,
	},
	{ "towolf/vim-helm", ft = "helm" },

	-- Auto completion, snippets, and suggestions --
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"octaltree/cmp-look",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-emoji",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("cmp-setup")
		end,
	},

	-- Code highlighting (basically just treesitter!) --
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("treesitter-configs")
		end,
	},
	{
		-- Additional text objects via treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = "nvim-treesitter",
	},

	-- Code Annotation --
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},

	-- Git Integration --
	{
		"shumphrey/fugitive-gitlab.vim", -- Enables vim-fugitive to use private gitlab repos
		dependencies = "tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Session Management --
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
				auto_session_use_git_branch = true,
			})
		end,
	},
	{
		"rmagatti/session-lens",
		dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
		config = function()
			require("session-lens").setup()
		end,
	},

	-- Quick Code Edits --
	"tpope/vim-surround",
}
