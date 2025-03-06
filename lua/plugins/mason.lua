return {
  -- Mason for managing external tools
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> in the file counts for
	require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", "lua_ls", "pyright", "bashls", "tailwindcss", "html",
          "eslint", "vimls",
        },
      })

      require("mason-lspconfig").setup_handlers({
        -- Default handler for servers with no specific configuration
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            settings = {
              -- Disable formatting on save for all LSP servers by default
              ["*"] = {
                format = {
                  enable = false
                }
              }
            }
          })
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

        -- Enhanced Clangd configuration for STM32/Embedded Development
        ["clangd"] = function()
          local lspconfig = require("lspconfig")
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          lspconfig.clangd.setup({
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_dir = lspconfig.util.root_pattern(
              "compile_commands.json", -- Preferred for clangd
              ".git",
              "Makefile",
              "compile_flags.txt",
              ".ccls",
              ".svn"
            ),
            init_options = {
              client = {
                snippetSupport = true, -- Enable snippet support
              },
              index = {
                threads = 0, -- Use all available cores
                onChange = true, -- Re-index on file changes
              },
              compilationDatabaseDirectory = "build", -- Override default if necessary
              diagnostics = {
                onChange = 50, -- Reduce diagnostics delay
              },
            },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false

              -- Keymaps for LSP functions
              vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
              vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
              vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
              vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })

              -- Auto-format on save if the server supports it
              if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({ async = false })
                  end,
                })
              end

              -- Debugging log
              print("clangd attached to buffer " .. bufnr)

              -- Optional: Create a .ccls config file for project-specific settings
              vim.api.nvim_create_user_command('CreateCclsConfig', function()
                local config = {
                  clang = {
                    extraArgs = {
                      "-I/path/to/your/includes",
                      "-mcpu=cortex-m4",
                      "-mthumb",
                      "/development/toolchains/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc"
                    }
                  }
                }

                -- Write .ccls file
                local file = io.open(".ccls", "w")
                if file then
                  file:write(vim.fn.json_encode(config))
                  file:close()
                  print("Created .ccls config file")
                else
                  print("Failed to create .ccls config file")
                end
              end, {})
            end,
          })
        end,
      })
    end,
  }
}

