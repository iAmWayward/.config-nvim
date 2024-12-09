return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Dependency for Telescope
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make", -- Use `build` instead of `run` for Lazy.nvim
  },
}

