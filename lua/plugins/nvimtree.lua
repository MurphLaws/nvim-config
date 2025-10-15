return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	priority = 1000,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Disable netrw (recommended)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Auto-open nvim-tree ONLY if opening a directory
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function(data)
				local directory = vim.fn.isdirectory(data.file) == 1
				if directory then
					vim.cmd.cd(data.file)
					require("nvim-tree.api").tree.open()
				end
			end,
		})

		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
				git_ignored = false,
				custom = {
					-- Godot junk files (match end of filename)
					"\\.uid$",
					"\\.import$",
					"\\.tscn$",
					"\\.tres$",
					"\\.res$",
					"\\.png$",
					"\\.jpe?g$",
					"\\.svg$",
					"\\.aseprite$",
					"\\.mtl$",
					"\\.glb$",
					"\\.obj$",
				},
			},
			renderer = {
				highlight_modified = "icon", -- highlight modified files with icon
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = false,
						modified = true, -- show modified icon
					},
					glyphs = {
						modified = "●", -- symbol for unsaved files
					},
				},
			},
			modified = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
			},
			git = {
				enable = false,
			},
		})

		-- Optional: toggle with <leader>e
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
	end,
}
