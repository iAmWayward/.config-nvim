return {
  "nvim-lua/plenary.nvim",        -- Required dependency for many plugins. Super useful Lua functions
  {
    "mrjones2014/legendary.nvim", -- A command palette for keymaps, commands and autocmds
    priority = 10000,
    lazy = false,
    dependencies = { "kkharji/sqlite.lua" },
    extensions = {
      lazy_nvim = true,
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

      -- Load your external keymaps file and register the keymaps
      require("config.keymaps").set_base()

      require("config.keymaps").mason_setup()
      require("config.keymaps").telescope_setup()
      -- Optionally, if you also want Legendary to handle or list these keymaps
      -- you could collect them into a table and then pass them to legendary.keymaps.
      --
      -- For example, if your keymaps module returned a table of legendary-style key definitions:
      --
      -- local keymaps = require("keymaps").keybinds
      -- legendary.keymaps(keymaps)
    end,
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
  },
}
