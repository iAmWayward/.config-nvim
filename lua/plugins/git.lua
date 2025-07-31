return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      --	require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "moyiz/git-dev.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require('git-conflict').setup {
        default_mappings = true,
        default_commands = true,
        highlights = {
          incoming = 'DiffText',
          current = 'DiffAdd',
        }
      }
    end
  },
}
