return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false, -- Load immediately
		priority = 1000, -- Ensure it loads first
		opts = {
			flavour = "latte", -- latte = light theme
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			term_colors = true,
			dim_inactive = {
				enabled = false,
			},
			styles = {
				comments = { "italic" },
				keywords = { "italic" },
				functions = {},
				variables = {},
			},
			integrations = {
				treesitter = true,
				lualine = true,
				cmp = true,
				gitsigns = true,
				telescope = true,
				which_key = true,
				native_lsp = {
					enabled = true,
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
				},
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
	},
}
