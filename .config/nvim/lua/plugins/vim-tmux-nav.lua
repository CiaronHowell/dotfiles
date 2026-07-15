return {
	"christoomey/vim-tmux-navigator",
	lazy = false, -- We want the plugin to run from the get go
	keys = {
		{ "C-h", ":TmuxNavigateLeft<CR>" },
		{ "C-j", ":TmuxNavigateDown<CR>" },
		{ "C-k", ":TmuxNavigateUp<CR>" },
		{ "C-l", ":TmuxNavigateRight<CR>" },
	},
}
