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
            -- Set up capabilities with nvim-cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Common on_attach function for all LSP servers
            local on_attach = function(client, bufnr)
                -- Keymaps configuration
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
                map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
                map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
                map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                map('n', 'gr', vim.lsp.buf.references, 'Find References')
                map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
                map('n', '<leader>sh', vim.lsp.buf.signature_help, 'Signature Help')
                map('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
                map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
                map('n', '<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
                map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format Code')

                -- Auto-format on save if supported
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format { async = false } end
                    })
                end
            end

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "ts_ls", "clangd", "lua_ls", "pyright", "bashls", "tailwindcss", "html",
                    "eslint", "vimls",
                },
            })

            require("mason-lspconfig").setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            ["*"] = { format = { enable = false } }
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

                ["typescript-language-server"] = function()
                    require("lspconfig").ts_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            typescript = {
                                updateImportsOnFileMove = { enabled = "always" },
                                suggest = {
                                    completeFunctionCalls = true,
                                },
                                vtsls = {
                                    enableMoveToFileCodeAction = true,
                                    autoUseWorkspaceTsdk = true,
                                    experimental = {
                                        maxInlayHintLength = 30,
                                        completion = {
                                            enableServerSideFuzzyMatch = true,
                                        },
                                    },
                                },
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                        },
                    })
                end,

                ["clangd"] = function()
                    require("lspconfig").clangd.setup({
                        cmd = { "clangd" },
                        filetypes = { "c", "cpp", "objc", "objcpp" },
                        root_dir = require("lspconfig.util").root_pattern(
                            "compile_commands.json",
                            ".git",
                            "Makefile"
                        ),
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,
            })
        end,
    },
}
