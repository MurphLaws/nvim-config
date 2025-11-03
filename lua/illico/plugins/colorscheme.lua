return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- Load immediately
		priority = 1000, -- Ensure it loads first
		opts = {
			style = "storm", -- Variants: "storm", "moon", "night", "day"
			transparent = false, -- Set to true if you want a transparent background
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
			},
			sidebars = { "qf", "help", "terminal", "packer" }, -- Keep sidebars consistent
			dim_inactive = false,
			lualine_bold = true,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd([[colorscheme tokyonight-storm]])
		end,
	},
}
