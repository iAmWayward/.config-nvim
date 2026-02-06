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
      ghost_text = {
        enabled = true,
      },
      keymap = {
        ["<A-Enter>"] = { "accept" }, -- select_and_accept
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      snippets = { preset = "luasnip" },

      completion = {
        trigger = {
          -- When true, will show the completion window after typing any of alphanumerics, `-` or `_`
          show_on_keyword = true,
        },

        --   -- When true, will show the completion window after typing a trigger character
        --   show_on_trigger_character = false,
        --
        -- },
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
            module = "blink.compat.source",
            opts = { prefix_min_len = 2 },
            --             should_show_items = function(ctx)
            --   return ctx.trigger.initial_kind ~= 'trigger_character' and not require('blink.cmp').snippet_active()
            -- end,
            score_offset = 0,
          },
          buffer = {
            name = "buffer",
            module = "blink.compat.source",
            opts = { prefix_min_len = 3 },
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
