return {
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
    "samiulsami/fFtT-highlights.nvim",
    config = function()
      ---@module "fFtT-highlights"
      ---@type fFtT_highlights.opts
      require("fFtT-highlights"):setup({
        ---See below for default configuration options
      })
    end,
  },
}
