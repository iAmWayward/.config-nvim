require("config.lazy")

vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.o.signcolumn = "yes"

vim.cmd.set = "termguicolors"

vim.opt.tabstop = 4     -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 4  -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 4 -- Number of spaces for <Tab> key in insert mode
vim.o.shell = "fish"
-- vim.opt.expandtab = true  -- Convert tabs to spaces
