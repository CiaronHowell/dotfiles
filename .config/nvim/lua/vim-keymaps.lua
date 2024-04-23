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
key_mapper("n", "<c-h>", ":wincmd h<cr>")
key_mapper("n", "<c-j>", ":wincmd j<cr>")
key_mapper("n", "<c-k>", ":wincmd k<cr>")
key_mapper("n", "<c-l>", ":wincmd l<cr>")

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

local export = {}

function export.on_attach(_, bufnr)
  -- LSP Bindings --
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "<c-]>", "<Cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
  vim.keymap.set("n", "gh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  vim.keymap.set("n", "ga", "<Cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
  vim.keymap.set("n", "gm", "<Cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
  vim.keymap.set("n", "gl", "<Cmd>lua vim.lsp.buf.incoming_calls()<CR>", bufopts)
  vim.keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
  vim.keymap.set("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", bufopts)
  vim.keymap.set("n", "gn", "<Cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
  -- vim.keymap.set('n', 'gs', "<Cmd>lua vim.lsp.buf.document_symbol()<CR>", bufopts)
  vim.keymap.set("n", "gs", "<Cmd>SymbolsOutline<CR>", bufopts)
  vim.keymap.set("n", "gw", "<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>", bufopts)
  vim.keymap.set("n", "[x", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
  vim.keymap.set("n", "]x", "<Cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
  vim.keymap.set("n", "]r", "<Cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  vim.keymap.set("n", "]s", "<Cmd>lua vim.diagnostic.show()<CR>", bufopts)

  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
      "*",
    },
    command = [[lua vim.lsp.buf.formatting_sync()]],
  })
end

-- The following implements dimming of inactive buffers
-- An autocommand group is setup in ../lua/autocmds.lua

local function windowIsRelative(windowId)
  return vim.api.nvim_win_get_config(windowId).relative ~= ""
end

local function windowIsCf(windowId)
  local buftype = vim.bo.buftype

  if windowId ~= nil then
    local bufferId = vim.api.nvim_win_get_buf(windowId)
    buftype = vim.api.nvim_buf_get_option(bufferId, "buftype")
  end

  return buftype == "quickfix"
end

function export.toggleDimWindows()
  local windowsIds = vim.api.nvim_list_wins()
  local currentWindowId = vim.api.nvim_get_current_win()

  if windowIsRelative(currentWindowId) then
    return
  end

  pcall(vim.fn.matchdelete, currentWindowId)

  if windowIsCf(currentWindowId) then
    return
  end

  for _, id in ipairs(windowsIds) do
    if id ~= currentWindowId and not windowIsRelative(id) then
      pcall(vim.fn.matchadd, "BufDimText", ".", 200, id, { window = id })
    end
  end
end

return export
