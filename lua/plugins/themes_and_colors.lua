return {
  -- {
  -- 	"bluz71/vim-nightfly-colors",
  -- },
  --
  {
    "lunarvim/Onedarker.nvim",
    event = "VeryLazy",
  },
  {
    "stevedylandev/darkmatter-nvim",
    event = "VeryLazy",
  },
  {
    "sainnhe/everforest",
    event = "VeryLazy",
  },
  {
    "projekt0n/github-nvim-theme",
    -- lazy = false,
    event = "VeryLazy",
  },
  {
    "datsfilipe/vesper.nvim",
    event = "VeryLazy",
  },
  {
    "Mofiqul/dracula.nvim",
    event = "VeryLazy",
  },
  ------------
  {
    "sainnhe/everforest",
    event = "VeryLazy",
  },
  {
    "scottmckendry/cyberdream.nvim",
    event = "VeryLazy",
  },
  {
    "datsfilipe/vesper.nvim",
    event = "VeryLazy",
  },
  {
    "arcticicestudio/nord-vim",
    event = "VeryLazy",
  },
  {
    "mofiqul/vscode.nvim",
    event = "VeryLazy",
  },
  {
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
  },
  {
    "rose-pine/neovim",
    event = "VeryLazy",
  },
  {
    "fynnfluegge/monet.nvim",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    event = "VeryLazy",
  },
  -- {
  --   "rafamadriz/neon",
  --   event = "VeryLazy",
  --   opts = {
  --     neon_style = "dark",
  --   },
  -- },
  {
    'marko-cerovac/material.nvim',

  },
  {
    "daschw/leaf.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = vim.g.transparent_enabled or false,
        },
      })
    end,
  },
  {
    "sainnhe/edge",
    event = "VeryLazy",
    init = function()
      vim.g.edge_transparent_background = vim.g.transparent_enabled or 0
    end,
  },
  -- {"kartikp10/noctis.nvim",
  --   requires = { 'rktjmp/lush.nvim' }
  -- },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
    config = function()
      require("ayu").setup({
        mirage = false,
        overrides = function()
          if vim.g.transparent_enabled then
            return {
              Normal = { bg = "NONE" },
              NormalNC = { bg = "NONE" },
              SignColumn = { bg = "NONE" },
              LineNr = { fg = "#BBDEFF" },
              -- CursorLineNr = { fg = "BOLD" },
              Folded = { bg = "NONE" },
              VertSplit = { bg = "NONE" },
              BufferLine = { bg = "NONE" },
              -- SignColumn = { fg = "" }
            }
          end
          return {}
        end,
      })
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "VeryLazy",
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
    event = "VeryLazy",
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
        gitsigns = true,
        headlines = true,
        -- illuminate = true,
        indent_blankline = { enabled = true },
        --     leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = false,
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
      local transparent = require("transparent")
      -- Define async_execute in the same scope where it's used
      local async_execute = function(command)
        vim.fn.jobstart(command, { detach = true })
      end
      -- Setup transparent.nvim
      require("transparent").setup({
        extra_groups = {
          "NeoTreeNormal",
          "TelescopeNormal",
          "BufferLineFill",
          "BufferLineOffset",
          "StatusLineNC",
          "DropBarMenuNormalFloat",
          "TabLine",
          "TabLineFill",
          "Whitespace",
          "WinBar",
          "WinBarNC",
          "BufferLineTabSeparator",
          "BufferLine*",
          "NoicePopupmenuBorder",
        },
        exclude_groups = {
          "NotifyBackground",
          "NormalFloat",
          "Notify",
          "notify",
        },
      })

      -- Custom toggle function with Kitty integration
      function Toggle_Transparency()
        transparent.toggle()
        local is_transparent = transparent.is_transparent()

        -- local kitty_cmd = is_transparent
        -- 		and "kitty @ --to=unix:/tmp/kitty set-background-opacity 0.85; " .. "kitty @ --to=unix:/tmp/kitty set-config background_blur 20"
        -- 	or "kitty @ --to=unix:/tmp/kitty set-background-opacity 1.0; "
        -- 		.. "kitty @ --to=unix:/tmp/kitty set-config background_blur 0"
        --
        -- async_execute(kitty_cmd)
      end
    end,
    init = function()
      -- Define async_execute again in this scope since it's needed here
      local async_execute = function(command)
        vim.fn.jobstart(command, { detach = true })
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          -- Small delay to ensure theme is fully applied
          -- vim.defer_fn(function()
          -- 	require("config.kitty-colors").set_kitty_colors()
          -- end, 100)
          vim.defer_fn(function()
            require("transparent").clear_prefix("DropBar")
            require("transparent").clear_prefix("lualine_c")
            require("transparent").clear_prefix("NeoTree")
            require("transparent").clear_prefix("TelescopeNormal")
            require("transparent").clear_prefix("BufferLineBackground")
            require("transparent").clear_prefix("BufferOffset")
            require("transparent").clear_prefix("BufferLineOffset")
            require("transparent").clear_prefix("BufferLineDevTextInactive")
            require("transparent").clear_prefix("BufferLineBuffer")
            require("transparent").clear_prefix("BufferLineFill")
            require("transparent").clear_prefix("BufferLineDevIconTxtInactive ")
            require("transparent").clear_prefix("DropBarMenuNormalFloat")
            require("transparent").clear_prefix("BufferLineTab")
            require("transparent").clear_prefix("BufferLineTabSeparator")
            require("transparent").clear_prefix("NoicePopupmenuBorder")
            require("transparent").clear_prefix("BufferLineNumbersVisible")
            require("transparent").clear_prefix("BufferLineCloseButtonVisible")
            require("transparent").clear_prefix("BufferLineIndicatorVisible")
            require("transparent").clear_prefix("BufferLinePickVisible")
            require("transparent").clear_prefix("BufferLineInfoVisible")
            require("transparent").clear_prefix("BufferLineNumbers")

            require("transparent").clear_prefix("BufferLine*")
            require("transparent").clear_prefix("NoicePopupmenuBorder")
            require("transparent").clear_prefix("WinSeparator")

            -- Re-apply Kitty transparency after theme change
            -- if vim.g.transparent_enabled then
            -- async_execute(
            -- 	"kitty @ --to=unix:/tmp/kitty set-background-opacity 0.69; "
            -- 		.. "kitty @ --to=unix:/tmp/kitty set-config background_blur 10"
            -- )
            -- end
            local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
            vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
            vim.api.nvim_set_hl(0, "lualine_c", { bg = "NONE" })
          end, 0)
        end,
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
            name = "Nord",
            colorscheme = "nord",
          },
          {
            name = "VSCode",
            colorscheme = "vscode",
          },
          {
            name = "kanagawa",
            colorscheme = "kanagawa",
          },
          -- {
          -- 	name = "Neovim",
          -- 	colorscheme = "neovim",
          -- },
          {
            name = "Vesper",
            colorscheme = "vesper",
          },
          -- {
          -- 	name = "Everfrost",
          -- 	colorscheme = "everfrost",
          -- },
          -- {
          -- 	name = "jellybeans-nvim",
          -- 	colorscheme = "metalelf0/jellybeans-nvim",
          -- },
          {
            name = "Dracula",
            colorscheme = "dracula",
          },
          {
            name = "Cyberdream",
            colorscheme = "cyberdream",
          },
          {
            name = "DarkMatter",
            colorscheme = "darkmatter",
          },

          -- {
          -- 	name = "OneDark",
          -- 	colorscheme = "onedarkpro-nvim",
          -- },
          -- {
          -- 	name = "Github",
          -- 	colorscheme = "github-nvim-theme",
          -- },
          -- {
          -- 	name = "Nightfly Colors",
          -- 	colorscheme = "vim-nightfly-colors",
          -- },
        },
        livePreview = true,
        globalBefore = [[
						vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
						vim.api.nvim_set_hl(0, "lualine_c", { bg = "NONE" })
        ]],
        globalAfter = [[
				      require('config.kitty-colors').set_kitty_colors()
              vim.api.nvim_set_hl(0, "lualine_c", { bg = "NONE" })
				    ]],
      })
    end,
  },
}
