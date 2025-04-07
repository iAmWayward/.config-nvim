require("config.lazy")
vim.o.cmdheight = 0
-- Setup transparent since it's required for visual effects
require('transparent').setup({
  extra_groups = {
    "NormalFloat",     -- Required for floating windows
    -- "NvimTreeNormal",  -- If you're using nvim-tree
    "NeoTreeNormal",   -- If you're using neo-tree
    "TelescopeNormal", -- For telescope
    "BufferLineFill",  -- For bufferline background
  },
})

-- Clear prefixes for plugins
require('transparent').clear_prefix('BufferLine')
require('transparent').clear_prefix('lualine_c')
require('transparent').clear_prefix('NeoTree')
require('transparent').clear_prefix('bg')
require('transparent').clear_prefix('DropBar')
require('transparent').clear_prefix('dropbar')

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99



require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()
