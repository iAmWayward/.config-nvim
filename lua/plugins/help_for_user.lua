return {
  { "timwmillard/uuid.nvim" },
  {
    "alex-popov-tech/store.nvim",
    dependencies = {
      "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
    },
    cmd = "Store",
    keys = {
      { "<leader>s", "<cmd>Store<cr>", desc = "Open Plugin Store" },
    },
    opts = {
      -- optional configuration here
    },
  },
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      win = {
        border = "rounded",
      },
    },
  },
  {
    "mrjones2014/legendary.nvim",
    keys = {
      { "<C-l>", "<cmd>Legendary<cr>", desc = "Open Command Palette" },
    },
    dependencies = {
      "kkharji/sqlite.lua",
      "folke/which-key.nvim",
    },
    config = function()
      require("legendary").setup({
        include_builtin = true,
        include_legendary_cmds = true,
        extensions = {
          which_key = {
            -- auto_register = {
            -- 	neotree = true,
            -- 	neo_tree = true,
            -- 	["neo-tree"] = true,
            -- },
            auto_register = true,
            do_binding = false,
            use_groups = true,
          },
        },
      })

      -- Load all regular keymaps
      local keymaps = require("config.keymaps")
      require("legendary").keymaps(keymaps.items)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function()
          require("legendary").keymaps(require("config.keymaps").items, {
            buffer = true,
            filetype = "neo-tree",
          })
        end,
      })
    end,
  },
  {
    "m4xshen/hardtime.nvim",

    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {

      lazy = false,
      enabled = false,
      restriction_mode = "hint",
    },
  },
  { "mong8se/actually.nvim" },
  { "tenxsoydev/tabs-vs-spaces.nvim", config = true },
  {
    'TrevorS/uuid-nvim',
    lazy = true,
    config = function()
      -- optional configuration
      require('uuid').setup {
        case = 'upper',
      }
      vim.keymap.set('n', '<leader>ut', uuidnvim.toggle_highlighting)
      vim.keymap.set('i', '<C-u>', uuid.insert_v4)
    end,
  }
}
