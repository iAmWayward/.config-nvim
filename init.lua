require("config.lazy")
vim.o.cmdheight = 0

require("notify").setup({
	background_colour = "#000000",
})

-- Clear prefixes for plugins
require('transparent').clear_prefix('lualine')
require('transparent').clear_prefix('NeoTree')
--
require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()
