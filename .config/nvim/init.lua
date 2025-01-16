-- nvim configuration --
require("config.vim-options")
require("config.vim-keymaps") -- Needs to be loaded before lazy

require("config.lazy")

-- TODO: Tidy this stuff up
vim.cmd([[colorscheme tokyonight-night]])
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#757a90", bold = false })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#9da0b0", bold = true })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#757a90", bold = false })
