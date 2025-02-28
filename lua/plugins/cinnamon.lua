return {
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
            easing = "quadratic",
            -- duration_multiplier = .75,
        },
    },
    -- change default options here
}
