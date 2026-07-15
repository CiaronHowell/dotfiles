-- LSP Settings

vim.diagnostic.config({
	severity_sort = true,
	virtual_text = { spacing = 2 },
	float = { border = "rounded", source = "if_many" },
	update_in_insert = false,
})

-- Buffer-local keymaps, set whenever an LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
	callback = function(ev)
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

		nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
		nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Diagnostics
		nmap("]r", vim.diagnostic.open_float, "Expand Diagnostic")

		-- See `:help K` for why this keymap
		nmap("K", vim.lsp.buf.hover, "Hover Documentation")
		nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

		-- Lesser used LSP functionality
		nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		nmap("<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
	end,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- Per-server settings; must be registered before mason-lspconfig.setup(),
-- whose automatic_enable calls vim.lsp.enable() for installed servers
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = { kubernetes = "*.yaml" },
		},
	},
})
vim.lsp.config("helm_ls", {
	settings = {
		["helm-ls"] = {
			yamlls = { path = "yaml-language-server" },
		},
	},
})
vim.lsp.config("phpactor", {
	filetypes = { "php", "blade" },
})

require("mason-lspconfig").setup({
	ensure_installed = { "yamlls", "helm_ls", "lua_ls" },
})

-- Turn on lsp status information
require("fidget").setup({})
