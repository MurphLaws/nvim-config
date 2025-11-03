return {
	"b0o/incline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"lewis6991/gitsigns.nvim",
		"SmiteshP/nvim-navic",
	},
	event = "BufReadPre",
	config = function()
		local devicons = require("nvim-web-devicons")
		local navic = require("nvim-navic")

		require("incline").setup({
			window = {
				padding = { left = 1, right = 1 },
				margin = { horizontal = 1, vertical = 1 },
				placement = { horizontal = "right", vertical = "top" },
				zindex = 45,
				winhighlight = {
					active = {
						Normal = "InclineNormal",
						EndOfBuffer = "None",
					},
					inactive = {
						Normal = "InclineNormalNC",
						EndOfBuffer = "None",
					},
				},
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified

				-- Git diff info
				local function get_git_diff()
					local icons = { removed = "  ", changed = "  ", added = "  " }
					local signs = vim.b[props.buf].gitsigns_status_dict
					if not signs then
						return {}
					end
					local labels = {}
					for name, icon in pairs(icons) do
						local count = tonumber(signs[name])
						if count and count > 0 then
							table.insert(labels, { icon .. count .. " ", group = "Diff" .. name })
						end
					end
					if #labels > 0 then
						table.insert(labels, { "│ " })
					end
					return labels
				end

				-- Diagnostic info
				local function get_diagnostic_label()
					local icons = { error = "  ", warn = "  ", info = "  ", hint = "  " }
					local label = {}
					for severity, icon in pairs(icons) do
						local n = #vim.diagnostic.get(props.buf, {
							severity = vim.diagnostic.severity[string.upper(severity)],
						})
						if n > 0 then
							table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
						end
					end
					if #label > 0 then
						table.insert(label, { "│ " })
					end
					return label
				end

				-- Navic breadcrumbs
				local function get_navic_breadcrumbs()
					if navic.is_available(props.buf) then
						local location = navic.get_location({ highlight = true })
						if location ~= "" then
							return {
								{ location .. " ", group = "NavicText" },
								{ " ", guifg = ft_color or "#6c7086" },
							}
						end
					end
					return {}
				end

				local result = {}

				-- Add diagnostic labels
				vim.list_extend(result, get_diagnostic_label())

				-- Add git diff
				vim.list_extend(result, get_git_diff())

				-- Add breadcrumbs with separator
				local breadcrumbs = get_navic_breadcrumbs()
				if #breadcrumbs > 0 then
					vim.list_extend(result, breadcrumbs)
				end

				-- Add file icon and name
				table.insert(result, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
				table.insert(result, {
					filename,
					gui = modified and "bold,italic" or "bold",
					guifg = modified and "#f9e2af" or "#cdd6f4",
				})

				-- Modified indicator
				if modified then
					table.insert(result, { " ● ", guifg = "#f38ba8" })
				else
					table.insert(result, { " " })
				end

				-- Add window number
				table.insert(result, { "│ ", guifg = "#6c7086" })
				table.insert(result, { " " .. vim.api.nvim_win_get_number(props.win) .. " ", guifg = "#89b4fa" })

				return result
			end,
		})
	end,
}
