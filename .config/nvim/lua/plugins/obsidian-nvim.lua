return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		legacy_commands = false, -- use the `:Obsidian <subcommand>` command style
		workspaces = {
			{
				name = "work",
				path = "~/vaults/work",
			},
		},
	},
}
