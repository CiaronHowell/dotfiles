return {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo", "Format" },
	keys = {
		{
			"<leader>fm",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		default_format_opts = { lsp_format = "fallback" },
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "ruff_organize_imports", "ruff_format" },
			go = { "gofmt" },
			yaml = { "prettierd" },
			json = { "prettierd" },
			markdown = { "prettierd" },
			typescript = { "prettierd" },
			javascript = { "prettierd" },
			astro = { "prettierd" },
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
		vim.api.nvim_create_user_command("Format", function()
			require("conform").format({ async = true })
		end, { desc = "Format current buffer" })
	end,
}
