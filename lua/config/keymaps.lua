-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "#", ":s/^/#/<CR>:noh<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "-#", ":s/^#//<CR>:noh<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "j", 'v:count ? "j" : "gj"', { expr = true })
vim.api.nvim_set_keymap("n", "k", 'v:count ? "k" : "gk"', { expr = true })
vim.api.nvim_set_keymap("n", "<up>", 'v:count ? "k" : "gk"', { expr = true })
vim.api.nvim_set_keymap("n", "<down>", 'v:count ? "j" : "gj"', { expr = true })
vim.api.nvim_set_keymap("n", "<leader>Z", ":ZenMode<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>t", ":Gitsigns toggle_signs<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Open current directory" })

-- Floaterm toggle
vim.api.nvim_set_keymap(
	"n",
	"<leader>A",
	":ToggleTerm<CR>",
	{ noremap = true, silent = true, desc = "Toggle Floaterm" }
)

-- Open compiler

-- Redo last selected option
vim.api.nvim_set_keymap(
	"n",
	"<S-F6>",
	"<cmd>CompilerStop<cr>" -- (Optional, to dispose all tasks before redo)
		.. "<cmd>CompilerRedo<cr>",
	{ noremap = true, silent = true }
)

-- Toggle compiler results
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>r", "<cmd>CompilerRedo<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>a", function()
	if copilot_enabled then
		vim.cmd("Copilot disable")
		print("Copilot disabled")
	else
		vim.cmd("Copilot enable")
		print("Copilot enabled")
	end
	copilot_enabled = not copilot_enabled
end, { desc = "Toggle Copilot", noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.py",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local line_count = vim.api.nvim_buf_line_count(bufnr)

		local start_import, end_import = nil, nil

		for i = 1, math.min(line_count, 50) do -- only scan first 50 lines
			local line = vim.fn.getline(i)
			if line:match("^import ") or line:match("^from .+ import") then
				if not start_import then
					start_import = i
				end
				end_import = i
			elseif start_import then
				break -- stop once imports end
			end
		end

		if start_import and end_import and end_import > start_import then
			vim.cmd(start_import .. "," .. end_import .. "fold")
		end
	end,
})

-- === ToggleTerm ESC mapping ===
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	-- Press <Esc> to leave terminal mode and close ToggleTerm
	vim.keymap.set("t", "<Esc>", [[<C-\><C-n>:ToggleTerm<CR>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
})
