return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000, -- load before other plugins
	config = function()
		require("tokyonight").setup({
			style = "moon", -- options: storm, night, moon, day
			transparent = false,
		})

		-- Apply Tokyonight
		vim.cmd.colorscheme("tokyonight-moon")
	end,
}
