return {
	{
		"github/copilot.vim",
		config = function()
			-- Disable Copilot immediately after loading
			vim.cmd.Copilot("disable")
		end,
	},
}
