return {
	{

		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = { -- Change window parameters here
					width = 0.8, -- Set width to 120 columns
					height = 1, -- Set height to 90% of the screen height
					options = {},
				},
			})
		end,
	},
}
