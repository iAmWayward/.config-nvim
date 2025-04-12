return {
  {
    "xiyaowong/transparent.nvim",
    lazy = true,
    config = function()
      require('transparent').setup({
        extra_groups = {
          --[[ "NormalFloat",     -- Required for floating windows ]]
          "NeoTreeNormal",   -- If you're using neo-tree
          "TelescopeNormal", -- For telescope
          "BufferLineFill",  -- For bufferline background
          "DropBarNormal",
          "DropBarNormalNC",
          "DropBarMenuNormal",
          "DropBarMenuNormalNC",
          "BufferLine",
          "Bufferline",
          "dropbar",
          "DropBar"
        },
        exclude_groups = {
          "NotifyBackground",
          "NormalFloat"
        },
      })
    end,
  },
  {
    "daschw/leaf.nvim",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("leaf").setup({
        theme = "dark",
        contrast = "high",
      })
    end,
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    style = "dark",
    terminal_colors = true,
    opts = {
      styles = {
        sidebars = "transparent",
        floats = "transparent",
        statusline = "transparent",
        statuslinenc = "transparent",
      },
    }
  },
  { "EdenEast/nightfox.nvim" },
  { "sainnhe/edge" },
  -- {"kartikp10/noctis.nvim",
  --   requires = { 'rktjmp/lush.nvim' }
  -- },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
    },
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    opts = {
      mirage = true,
    },
    config = function()
      require("ayu").setup({
        mirage = false,
        overrides = function()
          return {
            NormalNC = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            Folded = { bg = "NONE" },
            VertSplit = { bg = "NONE" },
          }
        end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
    end,
  },
  {
    "catppuccin/nvim",
    -- lazy = true,
    name = "catppuccin",
    flavour = "mocha",
    opts = {
      transparent = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "NONE" }, -- lualine
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      -- [[ vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" }) ]],
    },
    config = function()
      --[[ vim.cmd("colorscheme catppuccin") ]]
    end,
    specs = {
      {
        "akinsho/bufferline.nvim",
        --[[ optional = true, ]]
        opts = function(_, opts)
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.groups.integrations.bufferline")
                .get()
          end
        end,
      },
    },
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "Tokyo Night",
            colorscheme = "tokyonight",
            before = [[
              vim.g.tokyonight_style = "night"
              vim.g.tokyonight_transparent = true
              vim.g.tokyonight_transparent_sidebar = true
              vim.g.tokyonight_dark_sidebar = false
              vim.g.tokyonight_dark_float = false
              ]],
          },
          {
            name = "Catppuccin",
            colorscheme = "catppuccin",
            opts = { transparent_background = true },
            before = [[
            require("catppuccin").setup({
              transparent_background = true,
            })
          ]],
          },
          {
            name = "Gruvbox Dark",
            colorscheme = "gruvbox",
          },
          {
            name = "Leaf",
            colorscheme = "leaf",
          },
          -- {
          --   name = "Noctis",
          --   colorscheme = "noctis",
          -- },
          {
            name = "Neo Solarized",
            colorscheme = "NeoSolarized",
          },
          {
            name = "Ayu",
            colorscheme = "ayu",
            before = [[ vim.g.ayu_mirage = true ]],
            after = [[ vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" }) ]],
            overrides = function()
              return {
                -- Normal = { bg = "NONE" },
                -- NormalNC = { bg = "NONE" },
                -- lualine_c_normal = { bg = "NONE" },
                -- StatusLine = { bg = "NONE" },
                -- Add other groups as needed
              }
            end
          },
          {
            name = "Edge",
            colorscheme = "edge",
          },
          {
            name = "Nightfox",
            colorscheme = "nightfox",
          },
        },
        livePreview = true,
        globalBefore = [[
require('transparent').clear_prefix('NeoTree')
]],
        globalAfter = [[
require('transparent').clear_prefix('NeoTree')
-- ]],
      })
    end
  }
}
