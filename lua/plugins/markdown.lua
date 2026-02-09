return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    event = { "VeryLazy" },
    dependencies = {
      "Allianaab2m/nvim-material-icon-v3",
    },
    config = function()
      require("nvim-web-devicons").setup({
        override = require("nvim-material-icon").get_icons(),
      })
    end,
    default = true,
  },
  { "echasnovski/mini.icons", version = "*" },
  {
      "3rd/image.nvim",
      build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
      opts = {
          processor = "magick_cli",
          backend = "ueberzug",
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              only_render_image_at_cursor_mode = "popup",
              floating_windows = false, -- if true, images will be rendered in floating markdown windows
              filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                  html = {
                    enabled = true,
                  },
                  css = {
                    enabled = true,
                  },
            -- },
            -- neorg = {
            --   enabled = true,
            --   filetypes = { "norg" },
            },
          }
      }
  },
  -- Style visual elements of neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      preset = "obsidian",
      file_types = {
        "checkhealth",
        "Avante",
        "hover",
        "lspsaga",
        "pretty_hover",
        "pretty-hover",
        "markdown",
        "help",
        "gitcommit",
      },
    },
    ft = {
      "Avante",
      "hover",
      "lspsaga",
      "pretty_hover",
      "pretty-hover",
      "help",
      "FzfPreview",
      "gitcommit",
      "markdown",
    },
    config = function()
      require("render-markdown").setup({
        -- completions = { lsp = { enabled = true } },
        -- completions = { blink = { enabled = true } },
        heading = {
          right_pad = 1,
          left_pad = 1,
          width = { "block" },
          border = true,
          position = "inline",
          enabled = true,
          render_modes = true,
          atx = true, -- render special stuff instead of ###
          setext = true,
          sign = true,

          border_virtual = true,

          above = "▄",
          below = "▀",
        },
        pipe_table = {
          render_modes = { "round" },
        },
        code_blocks = {
          languages = { c = "doxygen", cpp = "doxygen" },
        },
        bullet = {
          right_pad = 1
        },
        checkbox = {
          enabled = true,
          right_pad = 6,
          custom = {
            followup = {
              raw = "[>]",
              rendered = "",
              highlight = "RenderMarkdownFollowup",
              scope_highlight = nil,
            },
            cancel = {
              raw = "[~]",
              rendered = "󰰱",
              highlight = "RenderMarkdownCancel",
              scope_highlight = nil,
            },
            important = {
              raw = "[!]",
              rendered = "",
              highlight = "RenderMarkdownImportant",
              scope_highlight = nil,
            },
          },
        },
        html = {
          enabled = true,
        },
        win_options = {
          -- Window options to use that change between rendered and raw view.

          -- @see :h 'conceallevel'
          conceallevel = {
            -- Used when not being rendered, get user setting.
            default = vim.o.conceallevel,
            rendered = 3,
          },
        },
      })
    end,
  },

  -- Comment styling
  {
    "folke/todo-comments.nvim",
    opts = {
      signs = true,        -- show icons in the signs column
      sign_priority = 500, -- sign priority
      -- keywords recognized as todo comments
      keywords = {
        FIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          signs = true, -- configure signs for some keywords individually
        },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",         -- The gui style to use for the fg highlight group.
        bg = "BOLD",         -- The gui style to use for the bg highlight group.
      },
      merge_keywords = true, -- when true, custom keywords will be merged with the defaults
      -- highlighting of the line containing the todo comment
      -- * before: highlights before the keyword (typically comment characters)
      -- * keyword: highlights of the keyword
      -- * after: highlights after the keyword (todo text)
      highlight = {
        multiline = false,        -- enable multine todo comments
        multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
        multiline_context = 10,   -- extra lines that will be re-evaluated when changing a line
        before = "",              -- "fg" or "bg" or empty
        keyword = "fg",           -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "fg",             -- "fg" or "bg" or empty
        -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,     -- uses treesitter to match keywords in comments only
        max_line_len = 400,       -- ignore lines longer than this
        exclude = {},             -- list of file types to exclude highlighting
      },
      -- list of named colors where we try to extract the guifg from the
      -- list of highlight groups or use the hex color if hl not found as a fallback
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
      },
    },
  },
}
