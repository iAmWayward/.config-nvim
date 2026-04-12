return {
  {
    "iAmWayward/Scratchview",
    main = "scratchview",
    lazy = false,
    branch = "volt-up",
    priority = 100,
    opts = {
      priority = { "readme", "git_log", "directory" },
      -- views = {
      --   readme    = { ... },
      --   git_log   = { ... },
      --   directory = { ... },
      --   custom    = { { name = "todo", build = function(ctx) ... end } },
      -- },
      -- keymaps = { next_view = "<Tab>", prev_view = "<S-Tab>" },
    },
  },
}
