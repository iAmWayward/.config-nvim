_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
  return _G.__cached_neo_tree_selector
end
return {
  --============================== Core Plugins ==============================--
  -- { "pandasoli/nekovim" },
  -- Develop neovim plugins
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
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy"
  },
  {
    "ThePrimeagen/vim-be-good",
    event = "VeryLazy",
  },
  {
    "alec-gibson/nvim-tetris",
    event = "VeryLazy",
  },
  {
    "seandewar/nvimesweeper",
    event = "VeryLazy",
  },
  {
    "seandewar/killersheep.nvim",
    event = "VeryLazy",
    config = function()
      require("killersheep").setup {
        gore = true,         -- Enables/disables blood and gore.
        keymaps = {
          move_left = "h",   -- Keymap to move cannon to the left.
          move_right = "l",  -- Keymap to move cannon to the right.
          shoot = "<Space>", -- Keymap to shoot the cannon.
        },
      }
    end,
  },
}
