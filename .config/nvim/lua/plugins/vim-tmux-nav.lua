return {
	"christoomey/vim-tmux-navigator",
	lazy = false, -- We want the plugin to run from the get go
	config = function()
		vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>")
		vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>")
		vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>")
		vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>")
	end,
}
