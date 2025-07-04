return {
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
	-- Utility that makes it easy to see a file in its scope
	{
		"simonmclean/triptych.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-tree/nvim-web-devicons", -- optional for icons
			"antosha417/nvim-lsp-file-operations", -- optional LSP integration
		},
		opts = {
			opts = {
				extension_mappings = {
					["<c-f>"] = {
						mode = "n",
						fn = function(target, _)
							require("telescope.builtin").live_grep({
								search_dirs = { target.path },
							})
						end,
					},
				},
			},
		}, -- config options here
		keys = {
			{ "<leader>-", ":Triptych<CR>" },
		},
	},
	-- TODO: What is this?
	{
		"Wansmer/treesj",
		keys = { "<space>m", "<space>j", "<space>s" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
		config = function()
			require("treesj").setup({
				max_join_length = 120,
			})
		end,
	},

	-- Main file tree plugin
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- lazy = false, -- neo-tree will lazily load itself
		-- event = "VeryLazy",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"saifulapm/neotree-file-nesting-config",
			--[[ "3rd/image.nvim", ]]
			{
				"s1n7ax/nvim-window-picker",
				version = "*",
			},
		},
		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			shared_tree_across_tabs = true,
			enable_cursor_hijack = true,
			hide_root_node = true,
			tabs_layout = "active", -- start, end, active, center, equal, focus
			open_files_do_not_replace_types = {
				"terminal",
				"telescope",
				"lspsaga",
				"notify",
				"sagaoutline",
				"trouble",
				"toggleterm",
				"Avante",
				"AvanteSelectedFiles",
				"AvanteInput",
			},
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				icon = {
					-- folder_closed = "",
					-- folder_open = "",
					folder_empty = "󰜌",
					default = "*",
					folder_empty_open = "󰝰",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight_opened_files = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- added = "+", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", --"",
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "󰁕", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "󰄱",
						staged = "",
						conflict = "",
						-- modified = "",
					},
				},
			},
			window = {
				mappings = {
					["<CR>"] = "open",
					["p"] = "paste_from_clipboard",
					["<leader><space>"] = { "toggle_preview", config = { use_float = true } },
					["l"] = "focus_preview",
					["C"] = "close_node",
					["w"] = "open_with_window_picker",
					["t"] = "open_tab_drop",
					["T"] = "open_tabnew",
					["<leader>ai"] = "avante_add_files",
					["S"] = "split_with_window_picker", -- or comment for default split
					["s"] = "vsplit_with_window_picker", -- or comment for default split
					["Z"] = "expand_all_nodes",
					["i"] = "show_file_details",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["o"] = {
						"show_help",
						nowait = false,
						config = { title = "Order by", prefix_key = "o" },
					},
					-- ['C'] = 'close_all_subnodes',
					-- 	mappings = require("config.keymaps").get_tree_mappings(),
				},
			},
			filesystem = {
				components = {
					harpoon_index = function(config, node, _)
						local harpoon_list = require("harpoon"):list()
						local path = node:get_id()
						local harpoon_key = vim.uv.cwd()

						for i, item in ipairs(harpoon_list.items) do
							local value = item.value
							if string.sub(item.value, 1, 1) ~= "/" then
								value = harpoon_key .. "/" .. item.value
							end

							if value == path then
								return {
									text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
									-- highlight = config.highlight or "NeoTreeDirectoryIcon",
								}
							end
						end
						return {}
					end,
				},
				hide_by_name = {
					"node_modules",
				},
				always_show_by_pattern = { -- uses glob style patterns
					".env*",
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true,
					group_empty_dirs = true,
				},
				renderers = {
					file = {
						{ "icon" },
						{ "name", use_git_status_colors = true },
						{ "harpoon_index" }, --> This is what actually adds the component in where you want it
						{ "diagnostics" },
						{ "git_status", highlight = "NeoTreeDimText" },
					},
				},
				hijack_netrw_behavior = "open_default",
			},
			buffers = {
				follow_current_file = {
					enabled = true,
				},
			},

			commands = {
				open_tab_stay = function()
					require("neo-tree.sources.filesystem.commands").open_tabnew()
					vim.cmd("wincmd p") -- Return to previous window
				end,

				avante_add_files = function(state)
					local node = state.tree:get_node()
					local filepath = node:get_id()
					local relative_path = require("avante.utils").relative_path(filepath)

					-- Add safe access to avante
					local ok, avante = pcall(require, "avante")
					if not ok then
						vim.notify("Avante not loaded yet", vim.log.levels.WARN)
						return
					end

					local sidebar = avante.get()
				end,
			},
			filter_rules = {
				include_current_win = false,
				autoselect_one = true,
				bo = {
					filetype = {
						"neo-tree",
						"neo-tree-popup",
						"notify",
						"sagaoutline",
						"trouble",
						"Avante",
						"AvanteSelectedFiles",
						"AvanteInput",
					},
					buftype = { "terminal", "quickfix", "sagaoutline", "trouble" },
				},
				-- Integrate with bufferline
				event_handlers = {
					event = "after_render",
					handler = function(state)
						if state.current_position == "left" or state.current_position == "right" then
							vim.api.nvim_win_call(state.winid, function()
								local str = require("neo-tree.ui.selector").get()
								if str then
									_G.__cached_neo_tree_selector = str
								end
							end)
						end
					end,
				},
			},
		},

		config = function(_, opts)
			opts.nesting_rules = require("neotree-file-nesting-config").nesting_rules
			require("neo-tree").setup(opts)
		end,
	},
}
