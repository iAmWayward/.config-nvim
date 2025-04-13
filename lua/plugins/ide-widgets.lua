return
{
  {
    "rcarriga/nvim-notify"
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
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
      -- require("config.keymaps").dropbar_setup() -- Keymaps
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
  -- {
  --   "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   ---@type snacks.Config
  --   opts = {
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = false },
  --     explorer = { enabled = false },
  --     indent = { enabled = false },
  --     input = { enabled = true },
  --     picker = { enabled = true },
  --     notifier = { enabled = true },
  --     quickfile = { enabled = true },
  --     scope = { enabled = true },
  --     scroll = { enabled = false },
  --     statuscolumn = { enabled = false },
  --     words = { enabled = true },
  --   },
  -- },
}
