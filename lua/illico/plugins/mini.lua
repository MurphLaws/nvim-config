return {

	-- ─────────────────────────────
	-- Mini Starter (Dashboard)
	-- ─────────────────────────────
	-- Mini Surround
	-- ─────────────────────────────
	{
		"echasnovski/mini.surround",
		version = "*",
		config = function()
			require("mini.surround").setup({
				mappings = {
					add = "sa",
					delete = "sd",
					find = "sf",
					find_left = "sF",
					highlight = "sh",
					replace = "sr",
					update_n_lines = "sn",
				},
			})
		end,
	},

	-- ─────────────────────────────
	-- Mini Trailspace
	-- ─────────────────────────────
	{
		"echasnovski/mini.trailspace",
		version = "*",
		config = function()
			local trailspace = require("mini.trailspace")

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					trailspace.trim()
				end,
			})

			vim.api.nvim_create_user_command("Trim", function()
				trailspace.trim()
			end, { desc = "Trim trailing whitespace" })
		end,
	},

	-- ─────────────────────────────
	-- Mini SplitJoin
	-- ─────────────────────────────
	{
		"echasnovski/mini.splitjoin",
		version = "*",
		config = function()
			local sj = require("mini.splitjoin")
			sj.setup({ mappings = { toggle = "" } })

			vim.keymap.set({ "n", "x" }, "sj", sj.join, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "sk", sj.split, { desc = "Split arguments" })
		end,
	},

	-- ─────────────────────────────
	-- Mini Files (Explorer)
	-- ─────────────────────────────
	{
		"echasnovski/mini.files",
		version = "*",
		config = function()
			require("mini.files").setup()

			vim.keymap.set("n", "<leader>em", function()
				-- Abre Mini Files en el directorio del archivo actual si es posible,
				-- de lo contrario en el directorio de trabajo actual.
				local buf_name = vim.api.nvim_buf_get_name(0)
				local path = vim.fn.filereadable(buf_name) == 1 and buf_name or nil
				require("mini.files").open(path)
			end, { desc = "Open Mini Files" })
		end,
	},
}
