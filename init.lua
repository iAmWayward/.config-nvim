-- init.lua
require("config.lazy")

-- Setup transparent since it's required for visual effects
require('transparent').setup({
  extra_groups = {
    "NormalFloat",     -- Required for floating windows
    "NvimTreeNormal",  -- If you're using nvim-tree
    "NeoTreeNormal",   -- If you're using neo-tree
    "TelescopeNormal", -- For telescope
    "BufferLineFill",  -- For bufferline background
  },
})

-- Clear prefixes for plugins
require('transparent').clear_prefix('BufferLine')
-- require('transparent').clear_prefix('lualine')
require('transparent').clear_prefix('NeoTree')

require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()

