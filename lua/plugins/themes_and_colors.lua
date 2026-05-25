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
    "szymonwilczek/arete.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("arete").setup({
        transparent = vim.g.transparent_enabled or false,
        cache = true,
        styles = {
          comments = { italic = true },
          keywords = { bold = true },
          types = { bold = true },
          functions = {},
          variables = {},
        },
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

          -- arete.nvim · Ef family
          { name = "Ef · Arbutus",            colorscheme = "ef-arbutus" },
          { name = "Ef · Arcadia",            colorscheme = "ef-arcadia" },
          { name = "Ef · Atlantis",           colorscheme = "ef-atlantis" },
          { name = "Ef · Autumn",             colorscheme = "ef-autumn" },
          { name = "Ef · Bio",                colorscheme = "ef-bio" },
          { name = "Ef · Cherie",             colorscheme = "ef-cherie" },
          { name = "Ef · Cyprus",             colorscheme = "ef-cyprus" },
          { name = "Ef · Dark",               colorscheme = "ef-dark" },
          { name = "Ef · Day",                colorscheme = "ef-day" },
          { name = "Ef · Deuteranopia Dark",  colorscheme = "ef-deuteranopia-dark" },
          { name = "Ef · Deuteranopia Light", colorscheme = "ef-deuteranopia-light" },
          { name = "Ef · Dream",              colorscheme = "ef-dream" },
          { name = "Ef · Duo Dark",           colorscheme = "ef-duo-dark" },
          { name = "Ef · Duo Light",          colorscheme = "ef-duo-light" },
          { name = "Ef · Eagle",              colorscheme = "ef-eagle" },
          { name = "Ef · Elea Dark",          colorscheme = "ef-elea-dark" },
          { name = "Ef · Elea Light",         colorscheme = "ef-elea-light" },
          { name = "Ef · False",              colorscheme = "ef-false" },
          { name = "Ef · Fig",                colorscheme = "ef-fig" },
          { name = "Ef · Frost",              colorscheme = "ef-frost" },
          { name = "Ef · Kassio",             colorscheme = "ef-kassio" },
          { name = "Ef · Light",              colorscheme = "ef-light" },
          { name = "Ef · Maris Dark",         colorscheme = "ef-maris-dark" },
          { name = "Ef · Maris Light",        colorscheme = "ef-maris-light" },
          { name = "Ef · Melissa Dark",       colorscheme = "ef-melissa-dark" },
          { name = "Ef · Melissa Light",      colorscheme = "ef-melissa-light" },
          { name = "Ef · Night",              colorscheme = "ef-night" },
          { name = "Ef · Orange",             colorscheme = "ef-orange" },
          { name = "Ef · Owl",                colorscheme = "ef-owl" },
          { name = "Ef · Reverie",            colorscheme = "ef-reverie" },
          { name = "Ef · Rosa",               colorscheme = "ef-rosa" },
          { name = "Ef · Spring",             colorscheme = "ef-spring" },
          { name = "Ef · Summer",             colorscheme = "ef-summer" },
          { name = "Ef · Symbiosis",          colorscheme = "ef-symbiosis" },
          { name = "Ef · Theme",              colorscheme = "ef-theme" },
          { name = "Ef · Tint",               colorscheme = "ef-tint" },
          { name = "Ef · Trio Dark",          colorscheme = "ef-trio-dark" },
          { name = "Ef · Trio Light",         colorscheme = "ef-trio-light" },
          { name = "Ef · Tritanopia Dark",    colorscheme = "ef-tritanopia-dark" },
          { name = "Ef · Tritanopia Light",   colorscheme = "ef-tritanopia-light" },
          { name = "Ef · Winter",             colorscheme = "ef-winter" },

          -- arete.nvim · Modus family
          { name = "Modus · Operandi",              colorscheme = "modus-operandi" },
          { name = "Modus · Operandi Deuteranopia", colorscheme = "modus-operandi-deuteranopia" },
          { name = "Modus · Operandi Tinted",       colorscheme = "modus-operandi-tinted" },
          { name = "Modus · Operandi Tritanopia",   colorscheme = "modus-operandi-tritanopia" },
          { name = "Modus · Vivendi",               colorscheme = "modus-vivendi" },
          { name = "Modus · Vivendi Deuteranopia",  colorscheme = "modus-vivendi-deuteranopia" },
          { name = "Modus · Vivendi Tinted",        colorscheme = "modus-vivendi-tinted" },
          { name = "Modus · Vivendi Tritanopia",    colorscheme = "modus-vivendi-tritanopia" },

          -- arete.nvim · Tempus family
          { name = "Tempus · Autumn",  colorscheme = "tempus_autumn" },
          { name = "Tempus · Classic", colorscheme = "tempus_classic" },
          { name = "Tempus · Dawn",    colorscheme = "tempus_dawn" },
          { name = "Tempus · Day",     colorscheme = "tempus_day" },
          { name = "Tempus · Dusk",    colorscheme = "tempus_dusk" },
          { name = "Tempus · Fugit",   colorscheme = "tempus_fugit" },
          { name = "Tempus · Future",  colorscheme = "tempus_future" },
          { name = "Tempus · Night",   colorscheme = "tempus_night" },
          { name = "Tempus · Past",    colorscheme = "tempus_past" },
          { name = "Tempus · Rift",    colorscheme = "tempus_rift" },
          { name = "Tempus · Spring",  colorscheme = "tempus_spring" },
          { name = "Tempus · Summer",  colorscheme = "tempus_summer" },
          { name = "Tempus · Tempest", colorscheme = "tempus_tempest" },
          { name = "Tempus · Totus",   colorscheme = "tempus_totus" },
          { name = "Tempus · Warp",    colorscheme = "tempus_warp" },
          { name = "Tempus · Winter",  colorscheme = "tempus_winter" },

          -- arete.nvim · Doric family
          { name = "Doric · Almond",   colorscheme = "doric-almond" },
          { name = "Doric · Beach",    colorscheme = "doric-beach" },
          { name = "Doric · Cherry",   colorscheme = "doric-cherry" },
          { name = "Doric · Copper",   colorscheme = "doric-copper" },
          { name = "Doric · Coral",    colorscheme = "doric-coral" },
          { name = "Doric · Dark",     colorscheme = "doric-dark" },
          { name = "Doric · Earth",    colorscheme = "doric-earth" },
          { name = "Doric · Fire",     colorscheme = "doric-fire" },
          { name = "Doric · Jade",     colorscheme = "doric-jade" },
          { name = "Doric · Light",    colorscheme = "doric-light" },
          { name = "Doric · Magma",    colorscheme = "doric-magma" },
          { name = "Doric · Marble",   colorscheme = "doric-marble" },
          { name = "Doric · Mermaid",  colorscheme = "doric-mermaid" },
          { name = "Doric · Oak",      colorscheme = "doric-oak" },
          { name = "Doric · Obsidian", colorscheme = "doric-obsidian" },
          { name = "Doric · Pine",     colorscheme = "doric-pine" },
          { name = "Doric · Plum",     colorscheme = "doric-plum" },
          { name = "Doric · Siren",    colorscheme = "doric-siren" },
          { name = "Doric · Valley",   colorscheme = "doric-valley" },
          { name = "Doric · Walnut",   colorscheme = "doric-walnut" },
          { name = "Doric · Water",    colorscheme = "doric-water" },
          { name = "Doric · Wind",     colorscheme = "doric-wind" },

          -- arete.nvim · Standard family
          { name = "Standard · Adwaita",      colorscheme = "standard-adwaita" },
          { name = "Standard · Dark",         colorscheme = "standard-dark" },
          { name = "Standard · Dark Tinted",  colorscheme = "standard-dark-tinted" },
          { name = "Standard · Light",        colorscheme = "standard-light" },
          { name = "Standard · Light Tinted", colorscheme = "standard-light-tinted" },
          { name = "Standard · Wombat",       colorscheme = "standard-wombat" },

          -- arete.nvim · Prot16 family
          { name = "Prot16 · Alto Dark",        colorscheme = "prot16-alto-dark" },
          { name = "Prot16 · Alto Light",       colorscheme = "prot16-alto-light" },
          { name = "Prot16 · Archaic Dark",     colorscheme = "prot16-archaic-dark" },
          { name = "Prot16 · Archaic Light",    colorscheme = "prot16-archaic-light" },
          { name = "Prot16 · Bionis Dark",      colorscheme = "prot16-bionis-dark" },
          { name = "Prot16 · Bionis Light",     colorscheme = "prot16-bionis-light" },
          { name = "Prot16 · Blau Dark",        colorscheme = "prot16-blau-dark" },
          { name = "Prot16 · Blau Light",       colorscheme = "prot16-blau-light" },
          { name = "Prot16 · Camo Dark",        colorscheme = "prot16-camo-dark" },
          { name = "Prot16 · Camo Light",       colorscheme = "prot16-camo-light" },
          { name = "Prot16 · Caprice Dark",     colorscheme = "prot16-caprice-dark" },
          { name = "Prot16 · Caprice Light",    colorscheme = "prot16-caprice-light" },
          { name = "Prot16 · Cyprium Dark",     colorscheme = "prot16-cyprium-dark" },
          { name = "Prot16 · Cyprium Light",    colorscheme = "prot16-cyprium-light" },
          { name = "Prot16 · Equinox Dark",     colorscheme = "prot16-equinox-dark" },
          { name = "Prot16 · Equinox Light",    colorscheme = "prot16-equinox-light" },
          { name = "Prot16 · Ficus Dark",       colorscheme = "prot16-ficus-dark" },
          { name = "Prot16 · Ficus Light",      colorscheme = "prot16-ficus-light" },
          { name = "Prot16 · Flowerbed Dark",   colorscheme = "prot16-flowerbed-dark" },
          { name = "Prot16 · Flowerbed Light",  colorscheme = "prot16-flowerbed-light" },
          { name = "Prot16 · Fortuna Dark",     colorscheme = "prot16-fortuna-dark" },
          { name = "Prot16 · Fortuna Light",    colorscheme = "prot16-fortuna-light" },
          { name = "Prot16 · Gaia Dark",        colorscheme = "prot16-gaia-dark" },
          { name = "Prot16 · Gaia Light",       colorscheme = "prot16-gaia-light" },
          { name = "Prot16 · Hinterland Dark",  colorscheme = "prot16-hinterland-dark" },
          { name = "Prot16 · Hinterland Light", colorscheme = "prot16-hinterland-light" },
          { name = "Prot16 · Hyperion Dark",    colorscheme = "prot16-hyperion-dark" },
          { name = "Prot16 · Hyperion Light",   colorscheme = "prot16-hyperion-light" },
          { name = "Prot16 · Magus Dark",       colorscheme = "prot16-magus-dark" },
          { name = "Prot16 · Magus Light",      colorscheme = "prot16-magus-light" },
          { name = "Prot16 · Nefelio Dark",     colorscheme = "prot16-nefelio-dark" },
          { name = "Prot16 · Nefelio Light",    colorscheme = "prot16-nefelio-light" },
          { name = "Prot16 · Neptune Dark",     colorscheme = "prot16-neptune-dark" },
          { name = "Prot16 · Neptune Light",    colorscheme = "prot16-neptune-light" },
          { name = "Prot16 · Noir Dark",        colorscheme = "prot16-noir-dark" },
          { name = "Prot16 · Noir Light",       colorscheme = "prot16-noir-light" },
          { name = "Prot16 · Ocarina Dark",     colorscheme = "prot16-ocarina-dark" },
          { name = "Prot16 · Ocarina Light",    colorscheme = "prot16-ocarina-light" },
          { name = "Prot16 · Oliveira Dark",    colorscheme = "prot16-oliveira-dark" },
          { name = "Prot16 · Oliveira Light",   colorscheme = "prot16-oliveira-light" },
          { name = "Prot16 · Orionis Dark",     colorscheme = "prot16-orionis-dark" },
          { name = "Prot16 · Orionis Light",    colorscheme = "prot16-orionis-light" },
          { name = "Prot16 · Overgrowth Dark",  colorscheme = "prot16-overgrowth-dark" },
          { name = "Prot16 · Overgrowth Light", colorscheme = "prot16-overgrowth-light" },
          { name = "Prot16 · Playa Dark",       colorscheme = "prot16-playa-dark" },
          { name = "Prot16 · Playa Light",      colorscheme = "prot16-playa-light" },
          { name = "Prot16 · Seabed Dark",      colorscheme = "prot16-seabed-dark" },
          { name = "Prot16 · Seabed Light",     colorscheme = "prot16-seabed-light" },
          { name = "Prot16 · Sonho Dark",       colorscheme = "prot16-sonho-dark" },
          { name = "Prot16 · Sonho Light",      colorscheme = "prot16-sonho-light" },
          { name = "Prot16 · Symbiosis Dark",   colorscheme = "prot16-symbiosis-dark" },
          { name = "Prot16 · Symbiosis Light",  colorscheme = "prot16-symbiosis-light" },
          { name = "Prot16 · Termina Dark",     colorscheme = "prot16-termina-dark" },
          { name = "Prot16 · Termina Light",    colorscheme = "prot16-termina-light" },
          { name = "Prot16 · Vin Dark",         colorscheme = "prot16-vin-dark" },
          { name = "Prot16 · Vin Light",        colorscheme = "prot16-vin-light" },

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
