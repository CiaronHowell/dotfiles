return {
    "mason-org/mason-lspconfig.nvim",
		-- automatic_enable is true by default
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
