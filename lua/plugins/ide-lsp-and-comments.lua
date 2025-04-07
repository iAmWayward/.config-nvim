return {
  -- Mason for package management
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- Unified on_attach function
      local on_attach = function(client, bufnr)
        require("config.keymaps").mason_setup(bufnr)

        -- Skip formatting for C/H files
        local filetype = vim.bo[bufnr].filetype
        if client.supports_method("textDocument/formatting") and filetype ~= "c" and filetype ~= "h" then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
          })
        end
      end

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "ts_ls", "clangd", "lua_ls", "pyright", "bashls",
          "tailwindcss", "html", "eslint", "vimls",
        },
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              ["*"] = { format = { enable = true }
              }
            }
          })
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,

        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            capabilities = {
              capabilities,
              positionEncodings = { "utf-16", "utf-32" },
            },
            on_attach = on_attach,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--completion-style=detailed",
              -- "--header-insertion=iwyu",
              "--suggest-missing-includes",
              "--offset-encoding=utf-16",
            },
          })
        end,

        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
          })
        end,
      })
    end,
  },

  -- None-LS (null-ls) for formatting
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettierd",
          "stylua",
          "ruff",
          "shfmt",
          "fixjson",
          "mdformat",
          "markdownlint",
          "yamlfix",
          "cmake_format",
          "dprint"
        },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")
      --[[ local augroup = vim.api.nvim_create_augroup("LspFormatting", {}) ]]

      null_ls.setup({
        sources = {
          -- Web
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.dprint,

          null_ls.builtins.formatting.ruff,    -- Python
          null_ls.builtins.formatting.stylua,  -- Lua
          null_ls.builtins.formatting.shfmt,   -- Shell scripts
          null_ls.builtins.formatting.fixjson, -- JSON

          -- Markdown
          null_ls.builtins.formatting.mdformat,
          null_ls.builtins.diagnostics.markdownlint,


          null_ls.builtins.formatting.yamlfix, -- YAML
          null_ls.builtins.diagnostics.tsc,

          -- CMake
          null_ls.builtins.formatting.cmake_format.with({
            command = "cmake_format"
          }),
        },
        on_attach = function(client, bufnr)
          -- let the unified LSP on_attach handle the formatting setup
        end,
        on_init = function(new_client, _)
          new_client.offset_encoding = 'utf-16'
        end,
      })
    end,
  },
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
        fold = { enable = true },
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
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Main cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Enter>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "codecompanion" }
          },
          {
            { name = "buffer" },
            { name = "path" },
          }
        ),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labeldetails = true,
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Cmdline setup for search ('/')
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Cmdline setup for command line (':')
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        )
      })

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  }
}
