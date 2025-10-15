return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			auto_close = false,
			use_diagnostic_signs = true,
			action_keys = {
				close = "q",
				cancel = "<esc>",
			},
		})

		local function toggle_trouble_float()
			local trouble = require("trouble")
			local api = vim.api

			if _G.trouble_float_win and api.nvim_win_is_valid(_G.trouble_float_win) then
				api.nvim_win_close(_G.trouble_float_win, true)
				_G.trouble_float_win = nil
				return
			end

			local width = math.floor(vim.o.columns * 0.3)
			local height = math.floor(vim.o.lines * 0.9)
			local col = vim.o.columns - width
			local row = (vim.o.lines - height) / 2

			local buf = api.nvim_create_buf(false, true)
			_G.trouble_float_win = api.nvim_open_win(buf, true, {
				relative = "editor",
				width = width,
				height = height,
				col = col,
				row = row,
				style = "minimal",
				border = "rounded",
			})

			vim.bo[buf].filetype = "Trouble"
			vim.wo[_G.trouble_float_win].number = false
			vim.wo[_G.trouble_float_win].relativenumber = false
			vim.wo[_G.trouble_float_win].wrap = true

			trouble.open("workspace_diagnostics", { win = _G.trouble_float_win })
		end

		vim.api.nvim_create_user_command("TroubleToggleFloat", toggle_trouble_float, {})
		vim.keymap.set("n", "<leader>D", "<cmd>TroubleToggleFloat<CR>", {
			silent = true,
			noremap = true,
			desc = "Toggle Trouble Float",
		})
	end,
}
