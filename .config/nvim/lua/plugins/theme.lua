return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "night",
	},
	config = function()
		vim.cmd([[colorscheme tokyonight-night]])

		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#757a90", bold = false })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9da0b0", bold = true })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#757a90", bold = false })
	end,
}
