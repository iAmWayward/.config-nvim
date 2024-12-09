return {
  -- Mason for managing external tools
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason-LSPConfig for managing LSP installations and configurations
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "lua_ls", "pyright", "bashls", "tailwindcss", "html",
          "eslint", "vimls",
        },
      })

      -- Use setup_handlers for streamlined LSP setup
      require("mason-lspconfig").setup_handlers({
        -- Default handler for servers with no specific configuration
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,

        -- Custom configurations for specific servers
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
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
      })
    end,
  },
  -- Null-LS for formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.prettier,
        },
      })
    end,
  },
  -- Mason-Null-LS for managing Null-LS formatters and linters
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "stylua", "shellcheck", "shfmt", "prettier" },
        automatic_installation = true,
      })
    end,
  },
}

