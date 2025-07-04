return {
  -- {
  --   "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
  -- },
  {
    "williamboman/mason-lspconfig.nvim",
    -- lazy = false,
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "docker_compose_language_service",
          "dockerls",
          "ts_ls",
          "vimls",
          "lemminx",
          "yamlls",
          -- "markdown_oxide",
          "css_variables",
          "clangd",
          -- "cpptools", -- INFO: MANUALLY INSTALL TIHS
        },
        automatic_installation = true,
        handlers = {
          -- Default handler: check for nvim/lsp/<server>.lua and use it if present
          function(server_name)
            local opts = { capabilities = capabilities }
            local has_custom, custom = pcall(require, "lsp." .. server_name)
            if has_custom then
              opts = vim.tbl_deep_extend("force", opts, custom)
            end
            require("lspconfig")[server_name].setup(opts)
          end,
          -- Example custom handler for lua_ls (can add others similarly)
          ["lua_ls"] = function()
            local opts = {
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = { globals = { "vim" } },
                  telemetry = { enable = false },
                },
              },
            }
            require("lspconfig").lua_ls.setup(opts)
          end,
        },
      })

      -- Autoformat on save for all but C/C headers
      -- vim.api.nvim_create_autocmd("LspAttach", {
      -- 	group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true }),
      -- 	callback = function(args)
      -- 		local bufnr = args.buf
      -- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- 		local ft = vim.bo[bufnr].filetype
      -- 		if ft == "c" or ft == "h" or ft == "cpp" or ft == "markdown" then
      -- 			return
      -- 		end
      -- 		if client.supports_method("textDocument/formatting") then
      -- 			vim.api.nvim_clear_autocmds({ group = "LspAutoFormat", buffer = bufnr })
      -- 			vim.api.nvim_create_autocmd("BufWritePre", {
      -- 				group = "LspAutoFormat",
      -- 				buffer = bufnr,
      -- 				callback = function()
      -- 					vim.lsp.buf.format({
      -- 						bufnr = bufnr,
      -- 						filter = function(lsp_client)
      -- 							-- Prefer null-ls if available
      -- 							if package.loaded["null-ls"] and lsp_client.name == "null-ls" then
      -- 								return true
      -- 							end
      -- 							-- Fallback to any other
      -- 							return lsp_client.name ~= "null-ls"
      -- 						end,
      -- 					})
      -- 				end,
      -- 			})
      -- 		end
      -- 	end,
      -- })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local ft = vim.bo[bufnr].filetype

          -- Skip formatting for certain filetypes
          if vim.tbl_contains({ "c", "h", "cpp", "markdown" }, ft) then
            return
          end

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspAutoFormat_" .. bufnr, { clear = true }),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(lsp_client)
                    -- Prefer null-ls/none-ls if available
                    return lsp_client.name ~= "null-ls" or not package.loaded["null-ls"]
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },

  -- None-LS (null-ls) for formatting
  {
    "jay-babu/mason-null-ls.nvim",
    -- lazy = false,
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettierd",
          "stylua",
          "shfmt",
          "fixjson",
          -- "mdformat",
          -- "markdownlint",
          "yamlfix",
          "cmakelang",
          "cmakelint",
          "commitlint",
          "cmake_format",
          "nginx_config_formatter",
          "gitlint",
          "gitleak",
          "yamllint",
        },
        automatic_installation = true,
        handlers = {},
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Web
          null_ls.builtins.formatting.prettierd,
          -- null_ls.builtins.formatting.dprint,

          null_ls.builtins.formatting.stylua, -- Lua
          null_ls.builtins.formatting.shfmt, -- Shell scripts
          -- null_ls.builtins.formatting.fixjson, -- JSON

          -- Markdown
          -- null_ls.builtins.formatting.mdformat.with({
          -- 	extra_args = { "--disable", "MD022" }, -- <- add this line
          -- }),

          -- -- null_ls.builtins.diagnostics.markdownlint,
          -- null_ls.builtins.diagnostics.markdownlint.with({
          -- 	extra_args = { "--disable", "MD022" }, -- <- add this line
          -- }),
          --
          null_ls.builtins.formatting.yamlfix, -- YAML
          -- null_ls.builtins.formatting.yamllint, -- YAML

          -- CMake
          null_ls.builtins.formatting.cmake_format.with({
            command = "cmake_format",
          }),
        },
        -- Make sure there aren't multiple encodings.
        -- on_init = function(new_client, _)
        -- 	new_client.offset_encoding = "utf-16"
        -- end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
          local rainbow_delimiters = require("rainbow-delimiters")
          require("rainbow-delimiters.setup")({
            strategy = { [""] = rainbow_delimiters.strategy.global },
            query = { [""] = "rainbow-delimiters" },
          })
        end,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "rrethy/nvim-treesitter-endwise",
      {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        opts = {},
        -- this is equivalent to setup({}) function
      },
      -- "abecodes/tabout.nvim",
      {
        "numToStr/Comment.nvim",
        config = function()
          -- Local definition ensures the `pre_hook` is scoped to this block
          local pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

          require("Comment").setup({
            pre_hook = pre_hook, -- Use the locally defined hook
          })
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
          -- vim.g.skip_ts_context_commentstring_module = true --TODO: evaluate
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
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "git_config",
          "gitcommit",
          "gitignore",
          "git_rebase",
          "gitattributes",
          "cpp",
          "c",
          "make",
          "cmake",
          "python",
          "lua",
          "luadoc",
          "html",
          "css",
          "rust",
          "bash",
          "comment",
          "csv",
          "desktop",
          "dockerfile",
          "doxygen",
          "fish",
          "editorconfig",
          "markdown",
          "markdown_inline",
          "ssh_config",
          "tsx",
          "typescript",
          "javascript",
          "ini",
          "vim",
          "xml",
          "yaml",
          "http",
          -- "regex",
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
            node_incremental = "grn",
            node_decremental = "grm",
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
}
