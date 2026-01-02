-- illico/core/options.lua

-- ===== Basics =====
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.updatetime = 200
vim.opt.timeoutlen = 300
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- ===== System clipboard =====
vim.opt.clipboard = "unnamedplus"

-- Where Neovim stores views (you can keep default; this just ensures it exists)
vim.opt.viewdir = vim.fn.stdpath("state") .. "/view"
vim.fn.mkdir(vim.opt.viewdir:get(), "p")

-- Save/load folds (and cursor, etc.) in views
vim.opt.viewoptions = { "cursor", "folds" }

vim.o.wildmenu = false
vim.o.wildoptions = "" -- IMPORTANT: removes the built-in popupmenu behavior

-- Transparency: Clear background for main window and floating windows
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })



