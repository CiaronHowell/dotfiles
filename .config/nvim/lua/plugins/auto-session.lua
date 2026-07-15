return {
	"rmagatti/auto-session",
	lazy = false,
	init = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
	opts = {
		log_level = "error",
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		use_git_branch = true,
	},
}
