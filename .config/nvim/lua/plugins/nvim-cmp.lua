return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"onsails/lspkind.nvim",
		"f3fora/cmp-spell",
		"rafamadriz/friendly-snippets",
		-- "hrsh7th/cmp-nvim-lua",
		-- "octaltree/cmp-look",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-calc",
		-- "saadparwaiz1/cmp_luasnip",
		-- "L3MON4D3/LuaSnip",
	},
	config = function()
		require("config.cmp-setup")
	end,
}

