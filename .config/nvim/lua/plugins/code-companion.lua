return {
	"olimorris/codecompanion.nvim",
	config = function()
		require("codecompanion").setup({
			adapters = {
				openai_compatible = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							-- Resolved from the environment; export this in your shell profile
							api_key = "CODECOMPANION_PROXY_API_KEY",
							url = "https://stardust-proxy-scp012-dxm01.apps.ocpb.osprey.hartree.stfc.ac.uk",
						},
						schema = {
							model = {
								default = "meta-llama/Llama-3.3-70B-Instruct",
							},
						},
					})
				end,
			},
			strategies = {
				chat = {
					adapter = "openai_compatible",
				},
				inline = {
					adapter = "openai_compatible",
				},
			},
		})

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
	keys = {
		{
			"<C-a>",
			"<cmd>CodeCompanionActions<cr>",
			mode = { "n", "v" },
			noremap = true,
			silent = true,
		},
		{
			"<leader>ac",
			"<cmd>CodeCompanionChat Toggle<cr>",
			mode = { "n", "v" },
			silent = true,
			noremap = true,
		},
		{
			"ga",
			"<cmd>CodeCompanionChat Add<cr>",
			mode = "v",
			noremap = true,
			silent = true,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
