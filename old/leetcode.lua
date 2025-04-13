return
{
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",                     -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim",         -- For standard functions
      "MunifTanjim/nui.nvim",          -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
    -- Offline mode configuration. For more details, see the "Offline mode" section below.
    --[[ offline_mode = { ]]
    --[[   -- Should offline mode be enabled? ]]
    --[[   enabled = false, ]]
    --[[   -- Do not connect to GitHub at all. Not even to get release information. ]]
    --[[   no_github = false, ]]
    --[[   -- What path should be looked at to find locally available releases ]]
    --[[   cache_dir = utils.path_join(utils.is_windows, vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"), ]]
    --[[ }, ]]
  }
}
