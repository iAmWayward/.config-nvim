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

        if client.supports_method("textDocument/formatting") then
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
        ensure_installed = { "prettierd" },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettierd,
        },
        on_attach = function(client, bufnr)
          local filetype = vim.bo[bufnr].filetype
          if filetype == "c" or filetype == "h" then
            return
          end

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
            })
          end
        end,
        on_init = function(new_client, _)
          new_client.offset_encoding = 'utf-16'
        end,
      })
    end,
  },
}
