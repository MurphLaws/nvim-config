vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999
vim.opt.termguicolors = true

vim.g.neovide_transparency = 0.6

vim.opt.listchars:append({ tab = "»·", trail = "·", extends = "»", precedes = "«", nbsp = "•" })
vim.o.guifont = "JetBrainsMonoNL Nerd Font:h16" -- text below applies for VimScript
