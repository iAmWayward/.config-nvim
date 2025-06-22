return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
					},
				},
			},
		},
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"saghen/blink.compat",
		version = "2.*",
		lazy = true,
		opts = {},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			{ "dmitmel/cmp-digraphs" },
			{ "Kaiser-Yang/blink-cmp-avante" },
			{ "alexandre-abrioux/blink-cmp-npm.nvim" },
			{ "disrupted/blink-cmp-conventional-commits" },
			{ "Kaiser-Yang/blink-cmp-git" },
			{ "jdrupal-dev/css-vars.nvim" },
			{ "mikavilpas/blink-ripgrep.nvim" },
			{ "bydlw98/blink-cmp-env" },
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load() -- load VSCode-style snippets (friendly-snippets)
					require("luasnip.loaders.from_lua").lazy_load() -- load any custom LuaSnip snippet files
					-- Extend filetypes to include doc-comment snippets from friendly-snippets:
					require("luasnip").filetype_extend("cpp", { "cppdoc" }) -- Doxygen for C++
					require("luasnip").filetype_extend("c", { "cdoc" }) -- Doxygen for C
					require("luasnip").filetype_extend("sh", { "shelldoc" }) -- Shell script docs
					require("luasnip").filetype_extend("python", { "pydoc" }) -- Google-style pydoc
					require("luasnip").filetype_extend("javascript", { "jsdoc" }) -- JSDoc for JS
					require("luasnip").filetype_extend("typescript", { "tsdoc" }) -- TSDoc for TS
				end,
			},
		},
		opts = {
			keymap = {
				["<CR>"] = { "select_and_accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = {
					"lazydev",
					"ripgrep",
					"lsp",
					"env",
					"path",
					"snippets",
					"buffer",
					"digraphs",
					"avante",
					"npm",
					"conventional_commits",
					"git",
					"css_vars",
					"dadbod",
				},
				-- per_filetype = {
				-- 	sql = { "snippets", "dadbod", "buffer", "avante" },
				-- },
				providers = {
					npm = {
						name = "npm",
						module = "blink-cmp-npm",
						async = true,
						-- optional - make blink-cmp-npm completions top priority (see `:h blink.cmp`)
						score_offset = 100,
						-- optional - blink-cmp-npm config
						opts = {
							ignore = {},
							only_semantic_versions = true,
							only_latest_version = false,
							prefix_min_len = 3,
						},
					},
					env = {
						name = "Env",
						module = "blink-cmp-env",
						opts = {
							-- item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
							show_braces = false,
							show_documentation_window = true,
						},
					},
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					git = {
						module = "blink-cmp-git",
						name = "Git",
						opts = {
							-- options for the blink-cmp-git
						},
					},
					digraphs = {
						-- IMPORTANT: use the same name as you would for nvim-cmp
						name = "digraphs",
						module = "blink.compat.source",
						-- this table is passed directly to the proxied completion source
						-- as the `option` field in nvim-cmp's source config
						-- this is NOT the same as the opts in a plugin's lazy.nvim spec
						opts = {

							-- this is an option from cmp-digraphs
							cache_digraphs_on_start = true,
						},
						-- all blink.cmp source config options work as normal:
						score_offset = -3,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {

							prefix_min_len = 3,
						},
					},
					conventional_commits = {
						name = "Conventional Commits",
						module = "blink-cmp-conventional-commits",
						enabled = function()
							return vim.bo.filetype == "gitcommit"
						end,
						opts = {},
					},
					css_vars = {
						name = "css-vars",
						module = "css-vars.blink",
						opts = {
							-- NOTE: The search is not optimized to look for variables in JS files.
							-- changing the search_extensions might get false positives and weird completion results.
							search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
						},
					},
					ripgrep = {
						module = "blink-ripgrep",
						name = "Ripgrep",
						opts = {
							prefix_min_len = 3,
							context_size = 5, -- preview size
							max_filesize = "1G",
							additional_paths = {}, -- dictionary, framework documentation, other sources
							-- toggles = {
							-- 	on_off = "<leader>tg", -- The keymap to toggle the plugin on and off from blink
							-- },
							transform_items = function(_, items)
								for _, item in ipairs(items) do
									-- example: append a description to easily distinguish rg results
									item.labelDetails = {
										description = "(rg)",
									}
								end
								return items
							end,
						},
					},
				},
			},
		},
	},
}
