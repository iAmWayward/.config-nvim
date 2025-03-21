return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*"
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "markdown", "Avante", "codecompanion" },
    },
    ft = { "markdown", "Avante" },
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
  }
}

-- https://github.com/hat0uma/prelive.nvim#Configuration
