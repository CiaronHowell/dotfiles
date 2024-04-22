o = vim.o
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

bo = vim.bo
bo.swapfile = false
bo.autoindent = true
bo.smartindent = true

wo = vim.wo
wo.number = true
wo.relativenumber = true
wo.signcolumn = "yes"
wo.wrap = false

g = vim.g
g.mapleader = " " -- This is setting leader to <SPACE>
g.maplocalleader = " "

-- Needed for Gitlab Fugitive Browser
g.fugitive_gitlab_domains = "https://gitlab.stfc.ac.uk"

-- Needed for Tree Explorer
g.loaded = 1
g.loaded_netrwPlugin = 1

-- Wrapping nvim_set_keymap function to make it neater to impl keybinds
-- mode = visual, insert, or cmd
-- key = the key(s) to bind the result to
-- result = what we want to happen after hitting the key(s)
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap( -- TODO: Look into replacing this with vim.keymap.set()
    mode,
    key,
    result,
    { noremap = true, silent = true }
  )
end

-- PLUGINS --
require("plugins")
pcall(require("telescope").load_extension, "fzf")

-- THEME --
-- require('tokyonight').setup({
--   transparent=true
-- })
-- pcall(vim.cmd, 'colorscheme tokyonight')
vim.cmd("colorscheme catppuccin")

-- KEYBINDS --
key_mapper("", "<space>", "<nop>") -- Unbind space
key_mapper("", "<C-u>", "<C-u>zz")
key_mapper("", "<C-d>", "<C-d>zz")

-- We don't use arrow keys here
key_mapper("", "<up>", "<nop>")
key_mapper("", "<down>", "<nop>")
key_mapper("", "<left>", "<nop>")
key_mapper("", "<right>", "<nop>")
key_mapper("i", "jj", "<ESC>")

-- Easy navigation between NVIM panes
key_mapper('n', '<c-h>', ':wincmd h<cr>')
key_mapper('n', '<c-j>', ':wincmd j<cr>')
key_mapper('n', '<c-k>', ':wincmd k<cr>')
key_mapper('n', '<c-l>', ':wincmd l<cr>')

-- Keybinds for telescope
key_mapper("", "<leader>ff", ':lua require("telescope.builtin").find_files()<cr>')
key_mapper("", "<leader>fg", ':lua require("telescope.builtin").live_grep()<cr>')
key_mapper("", "<leader>fb", ':lua require("telescope.builtin").buffers()<cr>')
key_mapper("", "<leader>fh", ':lua require("telescope.builtin").help_tags()<cr>')
key_mapper("", "<leader>fd", ':lua require("telescope.builtin").diagnostics()<cr>')
key_mapper("", "<leader>fk", ':lua require("telescope.builtin").keymaps()<cr>')
key_mapper("", "<leader>ft", ":TodoTelescope<cr>")
key_mapper("", "<leader>fs", ":Telescope session-lens search_session<cr>")

-- Keybinds for Harpoon
key_mapper("", "<leader>m", ':lua require("harpoon.mark").add_file()<cr>') -- Mark files
-- Quick nav
for i = 0, 9, 1 do
  key_mapper("", string.format("<leader>%d", i), string.format(':lua require("harpoon.ui").nav_file(%d)<cr>', i))
end
key_mapper("", "<leader><left>", ':lua require("harpoon.ui").nav_prev()<cr>')
key_mapper("", "<leader><right>", ':lua require("harpoon.ui").nav_next()<cr>')
key_mapper("", "<leader>h", ':lua require("harpoon.ui").toggle_quick_menu()<cr>')
key_mapper("", "<leader>fm", ":Telescope harpoon marks<cr>")
key_mapper("", "<leader>t", ':lua require("harpoon.term").gotoTerminal(1)<cr>')

-- Keybinds for Git Worktree
key_mapper("", "<leader>ww", ':lua require("telescope").extensions.git_worktree.git_worktrees()<cr>')
key_mapper("", "<leader>wc", ':lua require("telescope").extensions.git_worktree.create_git_worktree()<cr>')

-- Keybinds for Nvim-Tree
key_mapper("", "<leader>e", ":NvimTreeFocus<cr>")
key_mapper("", "<leader>E", ":NvimTreeToggle<cr>")

-- Autocommands
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

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
