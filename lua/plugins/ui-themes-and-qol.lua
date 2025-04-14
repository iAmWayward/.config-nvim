return {
  {
    "daschw/leaf.nvim",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("leaf").setup({
        theme = "dark",
        contrast = "high",
        transparent = vim.g.transparent_enabled or false,
      })
    end,
  },
  {
    "Tsuzat/NeoSolarized.nvim",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("NeoSolarized").setup({
        style = "dark",
        terminal_colors = true,
        transparent = vim.g.transparent_enabled or false,
        styles = {
          sidebars = vim.g.transparent_enabled and "transparent" or nil,
          floats = vim.g.transparent_enabled and "transparent" or nil,
        },
      })
    end,
    style = "dark",
    terminal_colors = true,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = vim.g.transparent_enabled or false,
        }
      })
    end,
  },
  {
    "sainnhe/edge",
    priority = 1000, -- Higher priority to load earlier
    init = function()
      vim.g.edge_transparent_background = vim.g.transparent_enabled or 0
    end,
  },
  -- {"kartikp10/noctis.nvim",
  --   requires = { 'rktjmp/lush.nvim' }
  -- },
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = vim.g.transparent_enabled or false,
        styles = {
          sidebars = vim.g.transparent_enabled and "transparent" or nil,
          floats = vim.g.transparent_enabled and "transparent" or nil,
        },
      })
    end,
  },
  {
    "Shatur/neovim-ayu",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("ayu").setup({
        mirage = false,
        overrides = function()
          if vim.g.transparent_enabled then
            return {
              Normal = { bg = "NONE" },
              NormalNC = { bg = "NONE" },
              SignColumn = { bg = "NONE" },
              Folded = { bg = "NONE" },
              VertSplit = { bg = "NONE" },
              BufferLine = { bg = "NONE" }
            }
          end
          return {}
        end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- Higher priority to load earlier
    config = function()
      require("gruvbox").setup({
        transparent_mode = vim.g.transparent_enabled or false,
        styles = {
          sidebars = vim.g.transparent_enabled and "transparent" or nil,
          floats = vim.g.transparent_enabled and "transparent" or nil,
        },
      })
    end,
  },
  {
    "catppuccin/nvim",
    priority = 1000, -- Higher priority to load earlier
    -- lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = vim.g.transparent_enabled or false,
      transparent = true,
      integrations = {
        --     aerial = true,
        --     alpha = true,
        cmp = true,
        dashboard = true,
        --     flash = true,
        fzf = true,
        --     grug_far = true,
        -- gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        --     leap = true,
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
        --     neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        --     snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require('transparent').setup({
        extra_groups = {
          --[[ "NormalFloat",     -- Required for floating windows ]]
          "NeoTreeNormal",   -- If you're using neo-tree
          "TelescopeNormal", -- For telescope
          "BufferLineFill",  -- For bufferline background
          "BufferLineOffset",
          "StatusLineNC",
          "DropBarMenuNormalFloat",
          "TabLine",
          "TabLineFill",
          "Whitespace",
          "WinBar",
          "WinBarNC"
          -- "lualine",
        },
        exclude_groups = {
          "NotifyBackground",
          "NormalFloat",
          "Notify",
          "notify"
        },
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Small delay to ensure theme is fully applied
          vim.defer_fn(function()
            require('transparent').clear_prefix('DropBar')
            require('transparent').clear_prefix('lualine_c')
            require('transparent').clear_prefix('NeoTree')
            require('transparent').clear_prefix('TelescopeNormal')
            require('transparent').clear_prefix('BufferLineBackground')
            require('transparent').clear_prefix('BufferOffset')
            require('transparent').clear_prefix('BufferLineOffset')
            require('transparent').clear_prefix('DropBarMenuNormalFloat')
          end, 10)
        end
      })
    end,
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    priority = 800,
    config = function()
      require("themery").setup({
        themes = {
          {
            name = "Tokyo Night",
            colorscheme = "tokyonight",
          },
          {
            name = "Catppuccin",
            colorscheme = "catppuccin",
            opts = { transparent_background = true },
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
        globalBefore = [[ ]],
      })
    end
  },
}
