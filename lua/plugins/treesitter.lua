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
              location = location,
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
      matchup = {
      enable = true,              -- mandatory, false will disable the whole extension
      disable = {},  -- optional, list of language that will be disabled
    -- [options]
  },
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      highlight_definitions = { enable = true },
      indent = { enable = false },
      incremental_selection = { enable = true },
    })
  end,

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

