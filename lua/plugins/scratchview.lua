return {
  {
    "iAmWayward/Scratchview",
    main = "scratchview",
    lazy = false,
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
