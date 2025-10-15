return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		vim.o.foldlevel = 99
		vim.o.foldenable = true

		local ufo = require("ufo")

		ufo.setup({
			provider_selector = function(_, filetype)
				if filetype == "python" then
					return { "treesitter", "indent" }
				end
				return { "lsp", "indent" }
			end,
		})

		-- After UFO finishes creating folds
		vim.api.nvim_create_autocmd("User", {
			pattern = "UfoFoldsUpdated",
			callback = function(args)
				local bufnr = args.buf
				if vim.bo[bufnr].filetype ~= "python" then
					return
				end

				-- find first import block
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				local start_import

				for i = 1, math.min(line_count, 50) do
					local line = vim.fn.getbufline(bufnr, i)[1]
					if line:match("^import ") or line:match("^from .+ import") then
						start_import = i
						break
					end
				end

				if start_import then
					-- tell UFO to close the fold at that line
					vim.schedule(function()
						require("ufo").closeFold(bufnr, start_import)
					end)
				end
			end,
		})
	end,
}
