local map = function(mode, key, result)
	vim.keymap.set(mode, key, result, { silent = true })
end

map("", "<space>", "<nop>") -- Unbind space
map("", "<C-u>", "<C-u>zz")
map("", "<C-d>", "<C-d>zz")

-- We don't use arrow keys here
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")
map("i", "jj", "<ESC>")
