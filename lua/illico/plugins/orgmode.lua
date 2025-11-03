return {
	"nvim-orgmode/orgmode",
	lazy = false, -- Load orgmode immediately
	priority = 1000, -- Load before other plugins
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_hide_emphasis_markers = true,
			org_agenda_files = "~/orgfiles/**/*",
			org_default_notes_file = "~/orgfiles/refile.org",
		})

		-- Force filetype for refile.org
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = "*/refile.org",
			callback = function()
				vim.bo.filetype = "org"
			end,
		})

		-- Custom function to insert file link with Telescope
		local function insert_file_link()
			require("telescope.builtin").find_files({
				prompt_title = "Select file for org link",
				cwd = vim.fn.expand("%:p:h"), -- current file's directory
				attach_mappings = function(prompt_bufnr, map)
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						if selection then
							local filepath = selection.path or selection[1]
							local relative = vim.fn.fnamemodify(filepath, ":.")
							local filename = vim.fn.fnamemodify(filepath, ":t:r") -- filename without extension as default
							-- Ask for description
							vim.ui.input({
								prompt = "Link description: ",
								default = filename,
							}, function(description)
								if description and description ~= "" then
									local link = string.format("[[file:%s][%s]]", relative, description)
									-- Insert the link at cursor position
									local row, col = unpack(vim.api.nvim_win_get_cursor(0))
									vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { link })
									vim.api.nvim_win_set_cursor(0, { row, col + #link })
								end
							end)
						end
					end)
					return true
				end,
			})
		end

		-- Set up the keymap for file link insertion
		vim.keymap.set("n", "<leader>olf", insert_file_link, { desc = "Insert org file link" })

		-- Custom highlight for DONE keyword
		vim.api.nvim_set_hl(0, "@org.keyword.done", { fg = "#00ff00", bold = true })
	end,
}
