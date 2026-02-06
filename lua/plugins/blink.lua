return {
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = "cargo build --release",
    lazy = true,
    version = "2.*",
    dependencies = {
      -- "MahanRahmati/blink-nerdfont.nvim",
      -- "dmitmel/cmp-digraphs",
      "Kaiser-Yang/blink-cmp-avante",
      -- "alexandre-abrioux/blink-cmp-npm.nvim",
      -- "disrupted/blink-cmp-conventional-commits",
      -- "Kaiser-Yang/blink-cmp-git",
      -- "jdrupal-dev/css-vars.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      "bydlw98/blink-cmp-env",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
          "rafamadriz/friendly-snippets",
          event = "InsertEnter",
          config = function()
            vim.keymap.set({ "i", "s" }, "<C-E>", function()
              if require("luasnip").choice_active() then
                require("luasnip").change_choice(1)
              end
            end, { desc = "Cycle snippet choices" })

            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()       -- load VSCode-style snippets (friendly-snippets)
          require("luasnip.loaders.from_lua").lazy_load()          -- load any custom LuaSnip snippet files
          -- Extend filetypes to include doc-comment snippets from friendly-snippets:
          require("luasnip").filetype_extend("cpp", { "cppdoc" })  -- Doxygen for C++
          require("luasnip").filetype_extend("c", { "cdoc" })      -- Doxygen for C
          require("luasnip").filetype_extend("sh", { "shelldoc" }) -- Shell script docs
          require("luasnip").filetype_extend("python", { "pydoc" }) -- Google-style pydoc
          require("luasnip").filetype_extend("javascript", { "jsdoc" }) -- JSDoc for JS
          require("luasnip").filetype_extend("typescript", { "tsdoc" }) -- TSDoc for TS
        end,
      },
    },

    opts = {
      keymap = {
        ["<A-Enter>"] = { "accept" }, -- select_and_accept
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      snippets = { preset = "luasnip" },

      completion = {
        trigger = {
          show_on_keyword = true,
        --   show_on_trigger_character = false,
        },
        ghost_text = {
          enabled = true,
          show_with_menu = false
        },

        documentation = {
          draw = function(opts)
            if opts.item and opts.item.documentation then
              local out = require("pretty_hover.parser").parse(opts.item.documentation.value)
              opts.item.documentation.value = out:string()
            end

            opts.default_implementation(opts)
          end,
        },
      },
      sources = {
        default = {
          "lazydev",
          "lsp",
          "env",
          "path",
          "snippets",
          "avante",
          -- "conventional_commits",
          "dadbod",
          "buffer",
          -- "css_vars",
          "ripgrep", --git, npm
        },      --
        providers = {
          snippets = {
            name = "LuaSnip",
            module = "blink.cmp.sources.snippets",
            opts = { 
              -- friendly_snippets = true,
              -- search_paths = { vim.fn.stdpath('config') .. '/snippets' },
              -- global_snippets = { 'all' },
              -- Set to '+' to use the system clipboard, or '"' to use the unnamed register
              clipboard_register = nil,
              -- Whether to put the snippet description in the label description
              use_label_description = false,
            },
            --             should_show_items = function(ctx)
            --   return ctx.trigger.initial_kind ~= 'trigger_character' and not require('blink.cmp').snippet_active()
            -- end,
            score_offset = 0,
          },
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            fallbacks = { "buffer" },
            score_offset = -3, -- if desired lower than LSP/snippets
          },
          env = {
            name = "Env",
            module = "blink-cmp-env",
            score_offset = 25,
            opts = { show_braces = false, show_documentation_window = true, prefix_min_len = 4 },
          },
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
            score_offset = 25,
            opts = { prefix_min_len = 3 },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          avante = {
            score_offset = 75,
            module = "blink-cmp-avante",
            name = "Avante",
            opts = { prefix_min_len = 3 },
          },
          buffer = {
            module = 'blink.cmp.sources.buffer',
            score_offset = -10,
            opts = {
              -- default to all visible buffers
              get_bufnrs = function()
                return vim
                  .iter(vim.api.nvim_list_wins())
                  :map(function(win) return vim.api.nvim_win_get_buf(win) end)
                  :filter(function(buf) return vim.bo[buf].buftype ~= 'nofile' end)
                  :totable()
              end,
              -- buffers when searching with `/` or `?`
              get_search_bufnrs = function() return { vim.api.nvim_get_current_buf() } end,
              -- Maximum total number of characters (in an individual buffer) for which buffer completion runs synchronously. Above this, asynchronous processing is used.
              max_sync_buffer_size = 20000,
              -- Maximum total number of characters (in an individual buffer) for which buffer completion runs asynchronously. Above this, the buffer will be skipped.
              max_async_buffer_size = 200000,
              -- Maximum text size across all buffers (default: 500KB)
              max_total_buffer_size = 500000,
              -- Order in which buffers are retained for completion, up to the max total size limit (see above)
              retention_order = { 'focused', 'visible', 'recency', 'largest' },
              -- Cache words for each buffer which increases memory usage but drastically reduces cpu usage. Memory usage depends on the size of the buffers from `get_bufnrs`. For 100k items, it will use ~20MBs of memory. Invalidated and refreshed whenever the buffer content is modified.
              use_cache = true,
              -- Whether to enable buffer source in substitute (:s), global (:g) and grep commands (:grep, :vimgrep, etc.).
              -- Note: Enabling this option will temporarily disable Neovim's 'inccommand' feature
              -- while editing Ex commands, due to a known redraw issue (see neovim/neovim#9783).
              -- This means you will lose live substitution previews when using :s, :smagic, or :snomagic
              -- while buffer completions are active.
              enable_in_ex_commands = false,
            }
          },
          -- css_vars = {
          -- 	name = "css-vars",
          -- 	module = "css-vars.blink",
          -- 	score_offset = 25,
          -- 	opts = { prefix_min_len = 3, search_extensions = { ".js", ".ts", ".jsx", ".tsx" } },
          -- },
          ripgrep = {
            module = "blink-ripgrep",
            name = "Ripgrep",
            opts = {
              backend = {
                additional_paths = {},
                context_size = 5,
                ripgrep = {
                  max_filesize = "1G",
                },
              },
              prefix_min_len = 5,
              transform_items = function(_, items)
                for _, item in ipairs(items) do
                  item.labelDetails = { description = "(rg)" }
                end
                return items
              end,
            },
          },
          path = {
            module = 'blink.cmp.sources.path',
            score_offset = 3,
            fallbacks = { 'buffer' },
            opts = {
              trailing_slash = true,
              label_trailing_slash = true,
              get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
              show_hidden_files_by_default = false,
              -- Treat `/path` as starting from the current working directory (cwd) instead of the root of your filesystem
              ignore_root_slash = false,
              -- Maximum number of files/directories to return. This limits memory use and responsiveness for very large folders.
              max_entries = 10000,
            }
          },
          -- nerdfont = {
          --   module = "blink-nerdfont", name = "Nerd Fonts", score_offset = 15, opts = { insert = true }
          -- },
          -- npm = {
          --   name = "npm",
          --   module = "blink-cmp-npm",
          --   async = true,
          --   score_offset = 50,
          --   opts = { ignore = {}, only_semantic_versions = true, prefix_min_len = 4 }
          -- },
          -- conventional_commits = {
          --   name = "Conventional Commits",
          --   module = "blink-cmp-conventional-commits",
          --   enabled = function() return vim.bo.filetype == "gitcommit" end,
          --   opts = { prefix_min_len = 3 },
          -- },
          -- git = {
          --   module = "blink-cmp-git",
          --   name = "Git",
          --   score_offset = 50,
          --   enabled = function()
          --     return vim.bo.filetype == "gitcommit"
          --         or vim.bo.filetype == "gitrebase"
          --         or vim.bo.filetype == "gitconfig"
          --   end,
          --   opts = { prefix_min_len = 3 }
          -- },
          -- digraphs = {
          --   name = "digraphs",
          --   module = "blink.compat.source",
          --   opts = { prefix_min_len = 3, cache_digraphs_on_start = true },
          --   score_offset = -3,
          -- },
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 80,
          },
        },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },
}
