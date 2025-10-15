return {
	{
		"nvim-orgmode/orgmode",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
		config = function()
			require("orgmode").setup({
				org_agenda_files = "~/org/*",
				org_default_notes_file = "~/org/refile.org",
				org_todo_keywords = { "TODO(t)", "IN_PROGRESS(i)", "|", "DONE(d)", "CANCELLED(c)" },
			})
		end,
	},
}
