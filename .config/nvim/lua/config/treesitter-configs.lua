-- nvim-treesitter (main branch) setup
local ensure_installed = {
	"astro",
	"c",
	"cpp",
	"go",
	"helm",
	"lua",
	"markdown",
	"markdown_inline",
	"python",
	"rust",
	"typescript",
	"vimdoc",
	"yaml",
}

require("nvim-treesitter").install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
	callback = function(ev)
		-- Only enable for filetypes with an installed parser
		if not pcall(vim.treesitter.start, ev.buf) then
			return
		end
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
