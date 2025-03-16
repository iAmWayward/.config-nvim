return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
    {
      "numToStr/Comment.nvim",
      config = function()
        require('Comment').setup({
          pre_hook = function(ctx)
            local U = require("Comment.utils")
            local ts_utils = require("ts_context_commentstring.utils")
            local ts_internal = require("ts_context_commentstring.internal")
            local location = nil

            if ctx.ctype == U.ctype.block then
              location = ts_utils.get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = ts_utils.get_visual_start_location()
            end

            return ts_internal.calculate_commentstring({
              key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
              location = ts_utils.get_visual_start_location() or { 0, 0 }
            })
          end,
        })
      end,
    },
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
        require('ts_context_commentstring').setup({})
        vim.g.skip_ts_context_commentstring_module = true -- Disable deprecated functionality
      end,
    },
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "git_config", "gitcommit", "gitignore", "git_rebase", "gitattributes",
        "cpp", "c", "make", "python", "lua", "luadoc", "html", "css", "rust",
        "bash", "cmake", "comment", "csv", "desktop", "dockerfile", "doxygen",
        "fish", "editorconfig", "markdown", "markdown_inline", "ssh_config",
        "tsx", "typescript", "javascript", "ini", "vim", "xml", "yaml", "http", "jsdoc"
      },
      sync_install = false,
      auto_install = true,
      ignore_install = {},
      modules = {},
      matchup = {
        enable = true,                                                          -- mandatory, false will disable the whole extension
        disable = {},                                                           -- optional, list of language that will be disabled
      },
      highlight = { enable = true, additional_vim_regex_highlighting = false }, -- default vim highlight. Disable it in treesitter and enable it here if it's buggy.
      highlight_definitions = { enable = true },
      indent = { enable = false },
      incremental_selection = { enable = true },
      autotag = { enable = true }, -- Enable auto-tagging for HTML, JSX, etc.
      rainbow = { enable = true }, -- Enable rainbow delimiters
    })
  end,

  require('nvim-ts-autotag').setup({
    opts = {
      -- Defaults
      enable_close = true,         -- Auto close tags
      enable_rename = true,        -- Auto rename pairs of tags
      enable_close_on_slash = true -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
      --[[ ["html"] = { ]]
      --[[   enable_close = false ]]
      --[[ } ]]
    }
  }),

  init = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    vim.g.rainbow_delimiters = {
      strategy = {
        [''] = rainbow_delimiters.strategy.global,
      },
      query = {
        [''] = 'rainbow-delimiters',
      }
    }
  end
}
