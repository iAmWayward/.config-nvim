require("config.lazy")
--
-- vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.signcolumn = "yes"
vim.o.number = true

vim.cmd.set = "termguicolors"
vim.o.shell = "/usr/bin/fish"

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2      -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2   -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2  -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
