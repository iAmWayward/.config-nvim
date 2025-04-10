return {
  "nvim-lua/plenary.nvim",        -- Required dependency for many plugins. Super useful Lua functions
  {
    "mrjones2014/legendary.nvim", -- A command palette for keymaps, commands and autocmds
    priority = 10000,
    lazy = false,
    dependencies = { "kkharji/sqlite.lua" },
    extensions = {
      which_key = {
        auto_register = true,
        opts = {},
        do_binding = false, -- Let legendary handle binding
        use_groups = true,
      }
    },
    keys = {
      {
        "<C-p>",
        function()
          require("legendary").find()
        end,
        desc = "Open Legendary",
      },
    },
    config = function()
      local legendary = require("legendary")
      -- Register your keybindings with Legendary
      legendary.keymaps({
      })
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  },
}
