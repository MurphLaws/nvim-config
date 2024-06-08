-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "<C-k>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", ":bprevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", ":w<CR>:!python3 %<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "#", ":s/^/#/<CR>:noh<CR>", { silent = true })
vim.api.nvim_set_keymap("v", "-#", ":s/^#//<CR>:noh<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "j", 'v:count ? "j" : "gj"', { expr = true })
vim.api.nvim_set_keymap("n", "k", 'v:count ? "k" : "gk"', { expr = true })
vim.api.nvim_set_keymap("n", "<up>", 'v:count ? "k" : "gk"', { expr = true })
vim.api.nvim_set_keymap("n", "<down>", 'v:count ? "j" : "gj"', { expr = true })
vim.api.nvim_set_keymap("n", "<C-b>", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Z", ":ZenMode<CR>", { noremap = true, silent = true })
