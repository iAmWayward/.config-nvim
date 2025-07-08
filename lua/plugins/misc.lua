--- TODO:
--- HACK:
--- NOTE:
--- FIX:
--- WARNING:
_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
  return _G.__cached_neo_tree_selector
end
return {
  --============================== Core Plugins ==============================--
  -- { "pandasoli/nekovim" },
  -- Develop neovim plugins
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },

  {
    "https://github.com/adelarsq/neovcs.vim",
    lazy = true,
    keys = {
      "<leader>v",
    },
    config = function()
      require("neovcs").setup()
    end,
  },
  {
    "kawre/leetcode.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Leet", -- Load only on command
    opts = {
      -- configuration goes here
    },
  },
  {
    "m4xshen/hardtime.nvim",

    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {

      lazy = false,
      enabled = false,
      restriction_mode = "hint",
    },
  },
}
