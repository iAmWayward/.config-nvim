return {
  -- Show neovim file editing as discord activity
  -- { "andweeb/presence.nvim" },
  { "vyfor/cord.nvim" },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.2,
      easing = "linear", -- quadratic, linear,
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      ignored_events = {
        "WinScrolled",
        "CursorMoved",
      },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      smear_between_buffers = true,
      scroll_buffer_space = true,
      smear_between_neighbor_lines = true, -- Smear when moving to adjacent lines
      smear_insert_mode = true,
      legacy_computing_symbols_support = true,
      never_draw_over_target = false,
      vertical_bar_cursor = false,
      vertical_bar_cursor_insert_mode = true,
      min_horizontal_distance_smear = 2,
      min_vertical_distance_smear = 2,
      -- Attempt to hide the real cursor by drawing a character below it.
      -- Can be useful when not using `termguicolors`
      hide_target_hack = true,
      max_kept_windows = 80, --default is 50 Number of windows that stay open for rendering the effect.
      -- Sets animation framerate
      time_interval = 17,    -- Sets animation framerate in milliseconds. default 17 milliseconds

      -- Amount of time the cursor has to stay still before triggering animation.
      -- Useful if the target changes and rapidly comes back to its original position.
      -- E.g. when hitting a keybinding that triggers CmdlineEnter.
      -- Increase if the cursor makes weird jumps when hitting keys.
      delay_event_to_smear = 3, -- milliseconds

      -- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
      delay_after_key = 5, -- milliseconds

      -- Smear configuration ---------------------------------------------------------

      -- How fast the smear's head moves towards the target.
      -- 0: no movement, 1: instantaneous
      stiffness = 0.85,

      -- How fast the smear's tail moves towards the target.
      -- 0: no movement, 1: instantaneous
      trailing_stiffness = 0.75, -- 49 0.3,

      -- Controls if middle points are closer to the head or the tail.
      -- < 1: closer to the tail, > 1: closer to the head
      trailing_exponent = 3, -- default 2

      -- How much the smear slows down when getting close to the target.
      -- < 0: less slowdown, > 0: more slowdown. Keep small, e.g. [-0.2, 0.2]
      slowdown_exponent = -.20,

      -- Stop animating when the smear's tail is within this distance (in characters) from the target.
      distance_stop_animating = 0.15,

      -- Set of parameters for insert mode
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.65,
      trailing_exponent_insert_mode = 2,
      distance_stop_animating_vertical_bar = 0.1, -- Can be decreased (e.g. to 0.1) if using legacy computing symbols

      -- When to switch between rasterization methods
      max_slope_horizontal = 0.5,
      min_slope_vertical = 2,

      -- color_levels = 16,                   -- Minimum 1, don't set manually if using cterm_cursor_colors
      gamma = 2.2,                               -- For color blending
      max_shade_no_matrix = 0.75,                -- 0: more overhangs, 1: more matrices
      matrix_pixel_threshold = 0.8,              -- 0: all pixels, 1: no pixel
      matrix_pixel_threshold_vertical_bar = 0.3, -- 0: all pixels, 1: no pixel
      matrix_pixel_min_factor = 0.5,             -- 0: all pixels, 1: no pixel
      volume_reduction_exponent = 0.3,           -- 0: no reduction, 1: full reduction
      minimum_volume_factor = 0.7,               -- 0: no limit, 1: no reduction
      max_length = 60,                           -- 35,                           -- Maximum smear length
      max_length_insert_mode = 1,
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    event = "VeryLazy",
    version = "*",
    blend = 0.1,
    skipEnteringNoNeckPainBuffer = true,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      width = 120, -- width of the Zen window
      height = 1,  -- height of the Zen window
      window = {
        options = {
          signcolumn = "no",      -- disable signcolumn
          number = false,         -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false,     -- disable cursorline
          cursorcolumn = false,   -- disable cursor column
          foldcolumn = "0",       -- disable fold column
          list = false,           -- disable whitespace characters
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false,   -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
            -- you may turn on/off statusline in zen mode by setting 'laststatus'
            -- statusline will be shown only if 'laststatus' == 3
            laststatus = 0,               -- turn off the statusline in zen mode
          },
          twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false },     -- disables the tmux statusline
          todo = { enabled = false },     -- if set to "true", todo-comments.nvim highlights will be disabled
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
          -- this will change the font size on wezterm when in zen mode
          -- See alse also the Plugins/Wezterm section in this projects README
          wezterm = {
            enabled = false,
            -- can be either an absolute font size or the number of incremental steps
            font = "+4", -- (10% increase per step)
          },
          -- this will change the scale factor in Neovide when in zen mode
          -- See alse also the Plugins/Wezterm section in this projects README
          neovide = {
            enabled = false,
            -- Will multiply the current scale factor by this number
            scale = 1.2,
            -- disable the Neovide animations while in Zen mode
            disable_animations = {
              neovide_animation_length = 0,
              neovide_cursor_animate_command_line = false,
              neovide_scroll_animation_length = 0,
              neovide_position_animation_length = 0,
              neovide_cursor_animation_length = 0,
              neovide_cursor_vfx_mode = "",
            }
          },
        }
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },


}
