return {
	{
		-- Theme inspired by Atom
		"navarasu/onedark.nvim",
		priority = 1000,
		opts = {
			style = "deep",
		},
		config = function(_, opts)
			require("onedark").setup(opts)
			vim.cmd.colorscheme("onedark")
		end,
	},
}
