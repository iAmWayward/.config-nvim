return {
  { "xiyaowong/transparent.nvim" },
  {
    "daschw/leaf.nvim",
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
  },
  -- {"kartikp10/noctis.nvim",
  --   requires = { 'rktjmp/lush.nvim' }
  -- },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      -- styles = {
      --   sidebars = "transparent",
      --   floats = "transparent",
      --   statusline = "transparent",
      --   statuslinenc = "transparent",
      --
      -- },
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
        mirage = true,
        -- overrides = function()
        --   return {
        --     Normal = { bg = "NONE" },
        --     NormalNC = { bg = "NONE" },
        --     SignColumn = { bg = "NONE" },
        --     Folded = { bg = "NONE" },
        --     VertSplit = { bg = "NONE" },
        --   }
        -- end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    -- opts = {
    --   transparent = true,
    --   styles = {
    --     sidebars = "transparent",
    --     floats = "transparent",
    --   },
    -- },
    config = function()
    end,
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
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
            name = "Gruvbox Dark",
            colorscheme = "gruvbox",
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
          },
        },
        livePreview = true,
        globalBefore = [[ vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" }) ]],
        globalAfter = [[ vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" }) ]],
      })
    end
  }
}
