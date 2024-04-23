local g = vim.g
g.mapleader = " " -- This is setting leader to <SPACE>
g.maplocalleader = " "

-- Needed for Gitlab Fugitive Browser
g.fugitive_gitlab_domains = "https://gitlab.stfc.ac.uk"

-- Needed for Tree Explorer
g.loaded = 1
g.loaded_netrwPlugin = 1

local o = vim.o
o.termguicolors = true
o.syntax = "on"
o.errorbells = false
o.ignorecase = true
o.smartcase = true
o.showmode = false
o.backup = false
o.undodir = vim.fn.stdpath("config") .. "/undodir"
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

local bo = vim.bo
bo.swapfile = false
bo.autoindent = true
bo.smartindent = true

local wo = vim.wo
wo.number = true
wo.relativenumber = true
wo.signcolumn = "yes"
wo.wrap = false

-- Autocommands
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "NvimTree*",
  callback = function()
    local api = require("nvim-tree.api")
    local view = require("nvim-tree.view")

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

-- Highlight on Yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
