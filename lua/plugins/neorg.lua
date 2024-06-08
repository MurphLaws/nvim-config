return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim", "nvim-treesitter" },
		version = "*",
		-- put any other flags you wanted to pass to lazy here!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {
						config = { icons = { todo = { uncertain = { icon = "" } } }, icon_preset = "diamond" },
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/neorg/",
							},
							default_workspace = "notes",
						},
					},

					["core.keybinds"] = {
						config = {
							hook = function(keybinds)
								keybinds.remap_event("norg", "n", "<Leader>o", "core.qol.todo_items.todo.task_cycle")
							end,
						},
					},
				},
			})
		end,
	},
}
