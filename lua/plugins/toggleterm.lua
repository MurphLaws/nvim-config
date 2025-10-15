return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				start_in_insert = true, -- always open in insert mode
				float_opts = {
					border = "curved", -- optional: "single", "double", "shadow", etc.
				},
			})
		end,
	},
	-- or
}
