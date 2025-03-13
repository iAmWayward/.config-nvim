return {
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
				require("config.keymaps").mason_setup(bufnr) -- Load keymaps from config/keymaps.lua

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
							["*"] = { format = { enable = true } }
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

				["ts_ls"] = function()
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
								},
							},
						},
					})
				end,
			})
		end,
	},
}
