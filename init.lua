require("config.lazy")

vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.o.signcolumn = "yes"

vim.cmd.set = "termguicolors"
