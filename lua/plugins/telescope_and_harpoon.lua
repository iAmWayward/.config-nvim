return {
  {
    "coffebar/neovim-project",
    opts = {
      -- projects = { -- define project roots
      --   "~/projects/*",
      --   "~/.config/*",
      --   -- "~/Code/*",
      --   -- "~/Code/MadeInLyh*",
      --   "~/Code/*/*",
      -- },
      auto_discover = {
        enabled = true,
        patterns = { ".git" }, -- Look for .git folders
      },
      picker = {
        type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
      },
      last_session_on_startup = true,
      dashboard_mode = true,
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,

  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    -- event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "Snikimonkd/telescope-git-conflicts.nvim",
      "nvim-telescope/telescope-dap.nvim",
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        conflicts = {},
      },
    },
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      -- you'll need at least one of these
      { "nvim-telescope/telescope.nvim" },
      -- {'ibhagwan/fzf-lua'},
    },
    config = function()
      require("neoclip").setup()
      require("telescope").load_extension("dap")
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "barrett-ruth/http-codes.nvim",
    config = true,
    -- or 'nvim-telescope/telescope.nvim'
    dependencies = "nvim-telescope/telescope.nvim",
    keys = { { "<leader>fH", "<cmd>HTTPCodes<cr>" } },
  },
  {
    "mrloop/telescope-git-branch.nvim",
  },
  {
    "jmacadie/telescope-hierarchy.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        -- Choose your own keys, this works for me
        "<leader>fi",
        "<cmd>Telescope hierarchy incoming_calls<cr>",
        desc = "LSP: [F]ind [I]ncoming Calls",
      },
      {
        "<leader>fo",
        "<cmd>Telescope hierarchy outgoing_calls<cr>",
        desc = "LSP: [F]ind [O]utgoing Calls",
      },
    },
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },

      -- optional picker via telescope
      { "nvim-telescope/telescope.nvim" },
      -- optional picker via fzf-lua
      -- { "ibhagwan/fzf-lua" },
      -- -- .. or via snacks
      -- {
      -- 	"folke/snacks.nvim",
      -- 	opts = {
      -- 		terminal = {},
      -- 	},
      -- },
    },
    event = "LspAttach",
    opts = {},
  },
}
