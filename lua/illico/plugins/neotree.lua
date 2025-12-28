return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{
				"<leader>e",
				function()
					-- Toggle Neo-tree filesystem on the left
					require("neo-tree.command").execute({
						toggle = true,
						source = "filesystem",
						position = "left",
						reveal = true,
					})
				end,
				desc = "Toggle Neo-tree",
			},
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true, -- Neo-tree built-in behavior (best effort)
				popup_border_style = "rounded",
				filesystem = {
					follow_current_file = { enabled = true },
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = true,
				},
				window = {
					width = 34,
					mappings = {
						["<esc>"] = "close_window",
					},
				},
			})

			-- Extra safety: if Neo-tree is the ONLY window left, quit/close it.
			-- (Some layouts/splits can bypass close_if_last_window.)
			vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
				callback = function()
					if vim.fn.winnr("$") ~= 1 then
						return
					end
					local ft = vim.bo.filetype
					if ft == "neo-tree" then
						-- If it's literally the last window, closing it would end the session anyway.
						-- Use :quit to avoid getting "stuck" in the tree.
						vim.cmd("quit")
					end
				end,
			})
		end,
	},
}
