return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"ThePrimeagen/git-worktree.nvim",
	},
	config = function()
		require("telescope").load_extension("git_worktree")
	end,
	keys = {
		-- Keybinds for telescope
		{
			"<leader>ff",
			function()
				require("telescope.builtin").find_files()
			end,
			desc = "File Search",
		},
		{
			"<leader>fg",
			function()
				require("telescope.builtin").live_grep()
			end,
			desc = "Grep Search",
		},
		{
			"<leader>fb",
			function()
				require("telescope.builtin").buffers()
			end,
			desc = "Buffer Search",
		},
		{
			"<leader>fh",
			function()
				require("telescope.builtin").help_tags()
			end,
		},
		{
			"<leader>fd",
			function()
				require("telescope.builtin").diagnostics()
			end,
		},
		{
			"<leader>fk",
			function()
				require("telescope.builtin").keymaps()
			end,
		},
		{ "<leader>ft", ":TodoTelescope<cr>" },
		{ "<leader>fs", ":Telescope session-lens search_session<cr>" },

		-- Keybinds for Git Worktree
		{
			"<leader>ww",
			function()
				require("telescope").extensions.git_worktree.git_worktrees()
			end,
		},
		{
			"<leader>wc",
			function()
				require("telescope").extensions.git_worktree.create_git_worktree()
			end,
		},
	},
}
