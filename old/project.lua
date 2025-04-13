return {
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "Makefile", "package.json", ".svn", ".cproj", "csproj" },
        show_hidden = false,
      })
      require('telescope').load_extension('projects')
    end,
  },
  {
    'https://github.com/adelarsq/neovcs.vim',
    keys = {
      '<leader>v',
    },
    config = function()
      require('neovcs').setup()
    end
  },
  { 'HugoBde/subversigns.nvim' },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    --[[ ft = "markdown", ]]
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre /home/george/Documents/Obsidian Vault/*.md",
      "BufNewFile /home/george/Documents/Obsidian Vault/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian Vault",
        },
        --[[ { ]]
        --[[   name = "work", ]]
        --[[   path = "~/vaults/work", ]]
        --[[ }, ]]
      },

      -- see below for full list of options 👇
    },
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
}
