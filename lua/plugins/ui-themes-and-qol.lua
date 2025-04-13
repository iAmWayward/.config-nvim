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
require('transparent').clear_prefix('DropBar')
require('transparent').clear_prefix('BufferLineFill')
]],
        globalAfter = [[
require('transparent').clear_prefix('NeoTree')
require('transparent').clear_prefix('DropBarIconUISeparator')
require('transparent').clear_prefix('BufferLineFill')
-- ]],
      })
    end
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*"
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "markdown", "Avante", "codecompanion" },
    },
    ft = { "markdown", "Avante", "codecompanion" },
  },
  {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    opts = {
      keymaps = {
        basic = true,
        extra = true,
      },

      -- Only scroll the window
      options = {
        mode = "window",
        easing = "linear",
        duration_multiplier = .75,
      },
    },
    -- change default options here
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      -- Function to generate a dynamic header
      local function generate_header()
        local day = os.date("%A")            -- Get the day of the week
        local hour = tonumber(os.date("%H")) -- Get the current hour
        local greeting = ""

        if hour < 12 then
          greeting = "Good Morning!"
        elseif hour < 18 then
          greeting = "Good Afternoon!"
        else
          greeting = "Good Evening!"
        end

        return {
          greeting,
          "Today is " .. day,
        }
      end

      -- Dashboard setup
      require('dashboard').setup({
        theme = 'hyper', -- Ensure theme is explicitly set
        disable_at_vimenter = true,
        change_to_vcs_root = true,
        config = {
          header = generate_header(),
          week_header = {
            enable = true,
            concat = " - Let's Code!",
          },
          disable_move = false,
          shortcut = {
            {
              desc = "  Find File",
              group = "DashboardShortCut",
              action = "Telescope find_files",
              key = "f"
            },
            {
              desc

                     = " Recent Files",
              group  = "DashboardShortCut",
              action = "Telescope oldfiles",
              key    = "r"
            }, { desc = " Config", group = "DashboardShortCut", action = "edit ~/.config/nvim/init.lua", key = "c" }, },
          footer = { "Have a productive session!", },
        },
      })
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
