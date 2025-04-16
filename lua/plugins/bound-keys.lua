return {
  { "nvim-lua/plenary.nvim" },
  { 'echasnovski/mini.icons', version = '*' },
  {
    "mrjones2014/legendary.nvim",
    lazy = true,
    dependencies = {
      "kkharji/sqlite.lua",
      "folke/which-key.nvim",
    },
    keys = {
      { '<C-p>', '<cmd>Legendary<cr>', desc = 'Open Command Palette' },
    },
    config = function()
      require('legendary').setup({
        include_builtin = true,
        include_legendary_cmds = true,
        extensions = {
          which_key = {
            auto_register = true,
            do_binding = false,
            use_groups = true,
          }
        }
      })

      -- Load all regular keymaps
      local keymaps = require('config.keymaps')
      require('legendary').keymaps(keymaps.items)

      -- Setup LSP keymaps when attaching to buffers
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local lsp_maps = require('config.keymaps').lsp_mappings(bufnr)
          require('legendary').keymaps(lsp_maps)
        end
      })
    end
  },
  {
    "folke/which-key.nvim",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').setup({
        win = {
          border = 'single',
        }
      })
    end
  },
}
