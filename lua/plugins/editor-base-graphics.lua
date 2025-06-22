return {
	{
		"folke/noice.nvim",
		opts = {
			lsp = {
				progress = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false, -- Renaming symbols in a project is handled by lspsaga
				lsp_doc_border = true,
			},
			views = {
				notify = {
					position = "top",
					reverse = true, -- New notifications appear at the top
					zindex = 100, -- Ensure proper layering
					merge = false, -- Show all notifications individually
					replace = true, -- Don't replace existing notifications
					-- render = ""
				},
				-- Optionally configure LSP progress position if needed
				lsp_progress = {
					position = "bottom_right",
					spinner = "aesthetic",
				},
			},
			format = {
				markdown = {
					enabled = true,
				},
			},
			documentation = {
				opts = {},
			},
		},
		dependencies = {
			{
				"rcarriga/nvim-notify",
				-- Use default renderer with custom window settings
				opts = {
					render = "compact", -- default, simple, compact, wrapped-compact
					stages = "fade_in_slide_out", --fade
					timeout = 3000,
					background_colour = "#000000", -- TODO theme this
					fps = 60,
					icons = {
						ERROR = "",
						WARN = "",
						INFO = "",
						DEBUG = "",
						TRACE = "",
					},
					minimum_width = 50,
					max_width = 100,
					max_height = 20,
					top_down = true,

					-- Custom window parameters for rounded borders and transparency
					on_open = function(win)
						vim.api.nvim_win_set_config(win, {
							border = "rounded",
							style = "minimal",
							-- winblend = 5
						})
						vim.wo[win].conceallevel = 2
						vim.wo[win].wrap = true
						-- vim.lsp.handlers["$/progress"] = vim.notify
					end,
				},
			},
			"MunifTanjim/nui.nvim",
		},
	},
}
