require("config.lazy")
vim.o.cmdheight = 0

require("notify").setup({
	background_colour = "#000000",
})

-- Clear prefixes for plugins
-- require('transparent').clear_prefix('lualine')
require('transparent').clear_prefix('NeoTree')
require('transparent').clear_prefix('DropBar')
require('transparent').clear_prefix('Dropbar')
require('transparent').clear_prefix('Bufferline')
require('transparent').clear_prefix('BufferLine')

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.api.nvim_create_augroup("NotifyBackgroundFix", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = "NotifyBackgroundFix",
  pattern = "*",
  callback = function()
    -- Adjust "#000000" (or use "NONE" if you want transparency)
    vim.cmd("highlight NotifyBackground guibg=#000000")
  end,
})

-- Also set it right away if a colorscheme is already loaded
vim.cmd("highlight NotifyBackground guibg=#000000")


require("config.keymaps").set_base()

