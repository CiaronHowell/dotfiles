-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

-- Keybinds for Harpoon
local keys = {
	{
		"<leader>m",
		function()
			require("harpoon"):list():add()
		end,
	}, -- Mark file
	{
		"<leader><left>",
		function()
			require("harpoon"):list():prev()
		end,
	},
	{
		"<leader><right>",
		function()
			require("harpoon"):list():next()
		end,
	},
	{
		"<leader>h",
		function()
			toggle_telescope(require("harpoon"):list())
		end,
		{ desc = "Open harpoon telescope window" },
	},
	{
		"<leader>H",
		function()
			local harpoon = require("harpoon")
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end,
		{ desc = "Open harpoon quick menu" },
	},
}

-- Quick nav
local quickNav = {}
for i = 0, 5, 1 do
	quickNav[i] = {
		string.format("<leader>%d", i),
		function()
			require("harpoon"):list():select(i)
		end,
	}
end

table.move(quickNav, 1, #quickNav, #keys + 1, keys)

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		-- REQUIRED
		require("harpoon"):setup()
	end,
	keys = keys,
}
