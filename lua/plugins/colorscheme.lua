return {
  { "xiyaowong/transparent.nvim" },
  {"daschw/leaf.nvim",
      config = function()
      require("leaf").setup({
        theme = "dark",
        contrast = "high",
      })
    end,
},
  {"Tsuzat/NeoSolarized.nvim",
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
          --[[ component_separators = { left = "", right = "" }, ]]
          --[[ section_separators = { left = "", right = "" }, ]]
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
      })
    end,
  },
}
