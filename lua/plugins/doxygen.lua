return {
	{
		"danymat/neogen",
		event = "VeryLazy",
		opts = {
			enabled = true,
			input_after_comment = true,
			languages = {
				cpp = {
					template = {
						annotation_convention = "doxygen",
					},
				},
				c = {
					template = {
						annotation_convention = "doxygen",
					},
				},
				python = {
					template = {
						annotation_convention = "google_docstrings",
					},
				},
				lua = {
					template = {
						annotation_convention = "emmylua",
					},
				},
				javascript = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				javascriptreact = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				typescript = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				typescriptreact = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				tsx = {
					template = {
						annotation_convention = "tsdoc",
					},
				},
				jsx = {
					template = {
						annotation_convention = "jsdoc",
					},
				},
				sh = {
					template = {
						annotation_convention = "google_bash",
					},
				},
			},
		},
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"hat0uma/doxygen-previewer.nvim",
		keys = { -- Lazy-load on these keymaps
			"<leader>dd",
			"<leader>du",
		},
		lazy = true,
		opts = {},
		dependencies = { "hat0uma/prelive.nvim" },
		update_on_save = true,
		cmd = {
			"DoxygenOpen",
			"DoxygenUpdate",
			"DoxygenStop",
			"DoxygenLog",
			"DoxygenTempDoxyfileOpen",
		},
	},
}
