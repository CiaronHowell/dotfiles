local g = vim.g
g.mapleader = " " -- This is setting leader to <SPACE>
g.maplocalleader = " "

-- Needed for Tree Explorer
g.loaded = 1
g.loaded_netrwPlugin = 1

local o = vim.o
o.termguicolors = true
o.errorbells = false
o.ignorecase = true
o.smartcase = true
o.showmode = false
o.backup = false
o.undodir = vim.fn.stdpath("config") .. "/.undodir"
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt = "menuone,noselect"
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.hlsearch = false
o.mouse = "a" -- Enable mouse mode
o.breakindent = true
o.updatetime = 250
o.swapfile = false
o.autoindent = true
o.smartindent = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.wrap = false
o.conceallevel = 2
o.spell = true
o.spelllang = "en_us"

-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
