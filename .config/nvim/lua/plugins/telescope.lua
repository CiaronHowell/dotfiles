return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"ThePrimeagen/harpoon",
		"ThePrimeagen/git-worktree.nvim",
	},
	config = function()
		require("telescope").load_extension("harpoon")
		require("telescope").load_extension("git_worktree")
	end,
}
