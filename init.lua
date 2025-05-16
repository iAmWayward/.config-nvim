vim.deprecate = function() end -- Shut up about deprecations
require("config.lazy")
--
vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.signcolumn = "yes"
vim.o.number = true
vim.opt.statuscolumn = [[%=%l %s]]
vim.cmd.set = "termguicolors"
vim.o.shell = "fish"

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2 -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2 -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
--
vim.opt.splitbelow = true -- New splits open below
vim.opt.splitright = false
-- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
vim.diagnostic.config({ virtual_text = { suffix = " ■" } }) -- Aline text to end of line?
-- If the current system shell or the `shell` option is set to /usr/bin/fish then revert to sh
