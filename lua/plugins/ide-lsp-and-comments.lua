return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "rrethy/nvim-treesitter-endwise",
      "windwp/nvim-autopairs",
      "abecodes/tabout.nvim",
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
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
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
        ignore_install = {},
        modules = {},
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-w>",
            scope_incremental = "<CR>",
            node_incremental = "<Tab>",
            node_decremental = "<S-Tab>",
          },
        },
        matchup = { enable = true },
        endwise = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          typescript = { "template_string" },
          typescriptreact = { "template_string", "string", "comment" },
          javascriptreact = { "template_string", "string", "comment" },
        }
      })

      -- Add custom rules for JSX/TSX with more complete filetype handling
      npairs.add_rules({
        Rule("<", ">", { "typescriptreact" }),
        Rule("{", "}", { "typescriptreact" }),
        Rule("(", ")", { "typescriptreact" }),
        Rule("[", "]", { "typescriptreact" }),
        Rule("'", "'", { "typescriptreact" }),
        Rule('"', '"', { "typescriptreact" }),
        Rule("`", "`", { "typescriptreact" }),
      })

      -- Treesitter condition-based pairs
      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" }))
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if cmp_status_ok then
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<Tab>",
      backwards_tabkey = "<S-Tab>",
      completion = true,
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = { [''] = rainbow_delimiters.strategy.global },
        query = { [''] = 'rainbow-delimiters' }
      }
    end
  },
  {
    "hat0uma/doxygen-previewer.nvim",
    opts = {},
    dependencies = { "hat0uma/prelive.nvim" },
    update_on_save = true,
    cmd = {
      "DoxygenOpen",
      "DoxygenUpdate",
      "DoxygenStop",
      "DoxygenLog",
      "DoxygenTempDoxyfileOpen"
    },
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        input_after_comment = true,
        languages = {
          cpp = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          c = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          },
          lua = {
            template = {
              annotation_convention = "emmylua"
            }
          },
          javascript = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          typescriptreact = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          tsx = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          jsx = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          sh = {
            template = {
              annotation_convention = "google_bash"
            }
          },
        }
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<Leader>ng",  "<cmd>Neogen<CR>", desc = "Generate documentation" },
      { "<Leader>ngc", "<cmd>Neogen<CR>", desc = "Generate documentation" },
    },
  }
}
