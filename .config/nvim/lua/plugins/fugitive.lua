return {
	"shumphrey/fugitive-gitlab.vim", -- Enables vim-fugitive to use private gitlab repos
	dependencies = "tpope/vim-fugitive",
	config = function()
		-- Needed for Gitlab Fugitive Browser
		vim.g.fugitive_gitlab_domains = "https://gitlab.stfc.ac.uk"
	end,
}
