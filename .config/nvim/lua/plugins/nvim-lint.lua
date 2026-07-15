return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			lua = { "selene" }, -- configured by selene.toml at the config root
			python = { "ruff" },
			markdown = { "markdownlint" },
		}

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("user-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
