return
{
  -- {
  --   "j-hui/fidget.nvim",
  --   opts = {
  --     progress = {
  --       ignore_empty_message = false,
  --       clear_on_detach = function(client_id)
  --         local client = vim.lsp.get_client_by_id(client_id)
  --         return client and client.name or nil
  --       end,
  --       -- notification_group = function(msg)
  --       --   return msg.lsp_client.name
  --       -- end,
  --     },
  --     -- integration = {
  --     --   lualine = true
  --     -- },
  --     notification = {
  --       override_vim_notify = true, -- Automatically override vim.notify() with Fidget
  --     },
  --   },
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          diagnostics = "nvim_lsp",
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          theme = "auto",
          section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          component_separators = { left = "", right = "" },
          --[[ section_separators = { left = "", right = "" }, ]]
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '' }
            },
            -- right_padding = 4
          },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {},
          lualine_x = { 'filesize', 'encoding', 'fileformat' },
          lualine_y = { 'progress', 'location' },
          lualine_z = {
            {
              'filetype',
              separator = { right = '' }
            },
          },
        },
        inactive_sections = {
          lualine_a = { 'branch', 'diff', 'diagnostics' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  },
}
