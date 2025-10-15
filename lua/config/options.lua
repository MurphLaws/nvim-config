vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.o.guifont = "JetBrainsMonoNL Nerd Font:h14" -- text below applies for VimScript
vim.opt.list = false

vim.cmd([[
  highlight! link NeoTreeNormal Normal
  highlight! link NeoTreeNormalNC Normal
  highlight! link NeoTreeDirectoryIcon Directory
  highlight! link NeoTreeDirectoryName Directory
  highlight! link NeoTreeSymbolicLink Target
  highlight! link NeoTreeGitModified Special
  highlight! link NeoTreeGitAdded DiffAdd
  highlight! link NeoTreeGitDeleted DiffDelete
  highlight! link NeoTreeGitConflict DiffText
]])

vim.o.foldlevel = 99
vim.o.foldenable = true
