return {

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				window = {
					position = "left",
					width = 20,
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},

	{
		"nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({

				override_by_extension = {
					["norg"] = {
						icon = "",
						color = "#179c9c",
						name = "Norg",
					},
				},
			})
		end,
	},
}
