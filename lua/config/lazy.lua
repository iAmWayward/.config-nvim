-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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
vim.opt.tabstop = 2      -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2   -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2  -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
--
vim.opt.splitbelow = true -- New splits open below
vim.opt.splitright = false
-- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
vim.diagnostic.config({ virtual_text = { suffix = " ■" } })
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "tokyonight" } },
  -- install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
