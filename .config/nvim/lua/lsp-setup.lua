require('mason').setup()

local m_lspconfig = require('mason-lspconfig')

m_lspconfig.setup({
  ensure_installed = { "lua-language-server", "javascript", "typescript" }
})
m_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = require("shared").on_attach,
    }
  end,
})

require('mason-tool-installer').setup {
  ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "black", "isort", "prettierd" },
  auto_update = false,
  run_on_start = true,
}
