-- # Structure:
--- - Core UI: Visual elements like themes, statuslines, notifications
--- - Editor Enhancement: Features that improve basic editing
--- - Project Management: Tools for moving around code and projects
--- - LSP & Completion: Language server and completion configurations
--- - CMP:
--- - :
--- - Extras: Fun stuff
--- - AI Tools: AI-assisted coding and writing features
---
return {

	--============================== Core Plugins ==============================--
	{ "nvim-lua/plenary.nvim" },
	{
		'kevinhwang91/nvim-ufo',
		dependencies = {
			'kevinhwang91/promise-async',
		},
		opts = {
			provider_selector = function(bufnr, filetype, buftype)
				return { 'treesitter', 'indent' }
			end
		}
	},
	{
		"lukas-reineke/cmp-under-comparator",
	},
	{
		"nvim-tree/nvim-web-devicons",
		event = { "VeryLazy" },
		dependencies = {
			"Allianaab2m/nvim-material-icon-v3",
		},
		config = function()
			require("nvim-web-devicons").setup({
				override = require("nvim-material-icon").get_icons(),
			})
		end,
		default = true,
	},
	{ "echasnovski/mini.icons", version = "*" },
	{
		"folke/which-key.nvim",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			win = {
				border = "rounded",
			},
		},
	},
	--=============================== LLM Provider ================================--
	-- {
	--   "github/copilot.vim"
	-- },
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			vim.cmd([[cab cc CodeCompanion]])
			require("codecompanion").setup(require("config.code-companion"))
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make", -- correct for lazy.nvim
	},
	{
		"ahmedkhalf/project.nvim",
		opts = {
			manual_mode = false,
			detection_methods = { "pattern", "lsp" },
			patterns = { ".git", "Makefile", "package.json", ".svn", ".cproj", "csproj" },
			show_hidden = false,
		},
		config = function()
			require("telescope").load_extension("projects")
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = true,
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"nvimdev/dashboard-nvim", -- Correct repository name
		lazy = false,
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local function generate_header()
				local day = os.date("%A")
				local hour = tonumber(os.date("%H"))
				local greeting = hour < 12 and "Good Morning!"
						or hour < 18 and "Good Afternoon!"
						or "Good Evening!"

				return {
					greeting,
					"Today is " .. day,
				}
			end

			return { -- Passed directly to dashboard.setup()
				theme = "hyper",
				disable_at_vimenter = true,
				change_to_vcs_root = true,
				config = {
					header = generate_header(),
					week_header = {
						enable = true,
						concat = " - Let's Code!",
					},
					disable_move = false,
					shortcut = {
						{
							desc = " Find File",
							group = "DashboardShortCut",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " Recent Files",
							group = "DashboardShortCut",
							action = "Telescope oldfiles",
							key = "r",
						},
						{
							desc = " Config",
							group = "DashboardShortCut",
							action = "edit ~/.config/nvim/init.lua",
							key = "c",
						},
					},
					footer = { "Have a productive session!" },
				},
			}
		end
	},
	--============================== Project Management ==============================--
	{
		"https://github.com/adelarsq/neovcs.vim",
		lazy = true,
		keys = {
			"<leader>vcs",
		},
		opts = {},
	},
	{
		"HugoBde/subversigns.nvim",
		lazy = true,
	},
	{
		"danymat/neogen",
		lazy = true,
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
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		--   -- refer to `:h file-pattern` for more examples
		--   "BufReadPre path/to/my-vault/*.md",
		--   "BufNewFile path/to/my-vault/*.md",
		-- },
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see above for full list of optional dependencies ☝️
		},
		---@module 'obsidian'
		---@type obsidian.config.ClientOpts
		opts = {
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/Notes",
				},
				{
					name = "work",
					path = "~/Documents/Obsidian Vault/",
				},
			},
			daily_notes = {
				-- Optional, if you keep daily notes in a separate directory.
				folder = "Daily Log",
				-- Optional, if you want to change the date format for the ID of daily notes.
				date_format = "%Y-%m-%d",
				-- Optional, if you want to change the date format of the default alias of daily notes.
				alias_format = "%B %-d, %Y",
				-- Optional, default tags to add to each new daily note created.
				default_tags = { "daily-notes" },
				-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
				template = nil,
				-- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
				workdays_only = true,
			},

			-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
			completion = {
				-- Enables completion using nvim_cmp
				nvim_cmp = true,
				-- Enables completion using blink.cmp
				blink = false,
				-- Trigger completion at 2 chars.
				min_chars = 2,
			},

			-- 	  mappings = {
			--   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			--   ["gf"] = {
			--     action = function()
			--       return require("obsidian").util.gf_passthrough()
			--     end,
			--     opts = { noremap = false, expr = true, buffer = true },
			--   },
			--   -- Toggle check-boxes.
			--   ["<leader>ch"] = {
			--     action = function()
			--       return require("obsidian").util.toggle_checkbox()
			--     end,
			--     opts = { buffer = true },
			--   },
			--   -- Smart action depending on context: follow link, show notes with tag, toggle checkbox, or toggle heading fold
			--   ["<cr>"] = {
			--     action = function()
			--       return require("obsidian").util.smart_action()
			--     end,
			--     opts = { buffer = true, expr = true },
			--   },
			-- },


			picker = {
				-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
				name = "fzf-lua",
				-- Optional, configure key mappings for the picker. These are the defaults.
				-- Not all pickers support all mappings.
				note_mappings = {
					-- Create a new note from your query.
					new = "<C-x>",
					-- Insert a link to the selected note.
					insert_link = "<C-l>",
				},
				tag_mappings = {
					-- Add tag(s) to current note.
					tag_note = "<C-x>",
					-- Insert a tag at the current location.
					insert_tag = "<C-l>",
				},
			},

			-- Optional, sort search results by "path", "modified", "accessed", or "created".
			-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
			-- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
			sort_by = "modified",
			sort_reversed = true,

			-- Set the maximum number of lines to read from notes on disk when performing certain searches.
			search_max_lines = 1000,

			-- Optional, determines how certain commands open notes. The valid options are:
			-- 1. "current" (the default) - to always open in the current window
			-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
			-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
			open_notes_in = "current",

			-- Optional, define your own callbacks to further customize behavior.
			-- callbacks = {
			--   -- Runs at the end of `require("obsidian").setup()`.
			--   ---@param client obsidian.Client
			--   post_setup = function(client) end,
			--
			--   -- Runs anytime you enter the buffer for a note.
			--   ---@param client obsidian.Client
			--   ---@param note obsidian.Note
			--   enter_note = function(client, note) end,
			--
			--   -- Runs anytime you leave the buffer for a note.
			--   ---@param client obsidian.Client
			--   ---@param note obsidian.Note
			--   leave_note = function(client, note) end,
			--
			--   -- Runs right before writing the buffer for a note.
			--   ---@param client obsidian.Client
			--   ---@param note obsidian.Note
			--   pre_write_note = function(client, note) end,
			--
			--   -- Runs anytime the workspace is set/changed.
			--   ---@param client obsidian.Client
			--   ---@param workspace obsidian.Workspace
			--   post_set_workspace = function(client, workspace) end,
			-- },

			-- Optional, configure additional syntax highlighting / extmarks.
			-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
			ui = {
				enable = true,      -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				max_file_length = 5000, -- disable UI features for files with more than this many lines
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					["x"] = { char = "", hl_group = "ObsidianDone" },
					[">"] = { char = "", hl_group = "ObsidianRightArrow" },
					["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					["!"] = { char = "", hl_group = "ObsidianImportant" },
					-- Replace the above with this if you don't have a patched font:
					-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

					-- You can also add more custom ones...
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					ObsidianTodo = { bold = true, fg = "#f78c6c" },
					ObsidianDone = { bold = true, fg = "#89ddff" },
					ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					ObsidianTilde = { bold = true, fg = "#ff5370" },
					ObsidianImportant = { bold = true, fg = "#d73128" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
					ObsidianHighlightText = { bg = "#75662e" },
				},
			},

			-- Specify how to handle attachments.
			attachments = {
				-- The default folder to place images in via `:Obsidian paste_img`.
				-- If this is a relative path it will be interpreted as relative to the vault root.
				-- You can always override this per image by passing a full path to the command instead of just a filename.
				img_folder = "assets/imgs", -- This is the default

				-- A function that determines default name or prefix when pasting images via `:Obsidian paste_img`.
				---@return string
				img_name_func = function()
					-- Prefix image names with timestamp.
					return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
				end,

				-- A function that determines the text to insert in the note when pasting an image.
				-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
				-- This is the default implementation.
				---@param client obsidian.Client
				---@param path obsidian.Path the absolute path to the image file
				---@return string
				img_text_func = function(client, path)
					path = client:vault_relative_path(path) or path
					return string.format("![%s](%s)", path.name, path)
				end,
			},

			-- See https://github.com/obsidian-nvim/obsidian.nvim/wiki/Notes-on-configuration#statusline-component
			statusline = {
				enabled = true,
				format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
			},
			preferred_link_style = "wiki",

			-- Optional, boolean or a function that takes a filename and returns a boolean.
			-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
			disable_frontmatter = false


			-- see below for full list of options 👇
		},
	},
	{
		"hat0uma/doxygen-previewer.nvim",
		keys = { -- Lazy-load on these keymaps
			"<leader>dd",
			"<leader>du",
		},
		-- lazy = true,
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
	{
		"shortcuts/no-neck-pain.nvim",
		lazy = false,
		version = "*",
		blend = 0.1,
		skipEnteringNoNeckPainBuffer = true,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		opts = {
			file_types = { "markdown", "Avante", "codecompanion", "hover", "lspsaga" },
		},
		ft = { "markdown", "Avante", "codecompanion", "hover", "lspsaga" },
		config = function()
			require('render-markdown').setup({
				completions = { lsp = { enabled = true } },
				heading = {
					width = { 'block' },
					border = true,
				},
			})
		end
	},

	--============================== UI Enhancements ==============================--
	{
		"karb94/neoscroll.nvim",
		lazy = false,
		opts = {
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			duration_multiplier = 1.0,
			easing = "linear", -- quadratic, linear,
			pre_hook = nil,
			post_hook = nil,
			performance_mode = false,
			ignored_events = {
				"WinScrolled",
				"CursorMoved",
			},
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		lazy = false,
		opts = {
			smear_between_buffers = true,
			scroll_buffer_space = true,
			smear_between_neighbor_lines = true, -- Smear when moving to adjacent lines
			smear_insert_mode = true,
			legacy_computing_symbols_support = true,
			never_draw_over_target = false,
			vertical_bar_cursor = false,
			vertical_bar_cursor_insert_mode = true,
			min_horizontal_distance_smear = 2,
			min_vertical_distance_smear = 2,
			-- Attempt to hide the real cursor by drawing a character below it.
			-- Can be useful when not using `termguicolors`
			hide_target_hack = true,
			max_kept_windows = 80, --default is 50 Number of windows that stay open for rendering the effect.
			-- Sets animation framerate
			time_interval = 17, -- Sets animation framerate in milliseconds. default 17 milliseconds

			-- Amount of time the cursor has to stay still before triggering animation.
			-- Useful if the target changes and rapidly comes back to its original position.
			-- E.g. when hitting a keybinding that triggers CmdlineEnter.
			-- Increase if the cursor makes weird jumps when hitting keys.
			delay_event_to_smear = 3, -- milliseconds

			-- Delay for `vim.on_key` to avoid redundancy with vim events triggers.
			delay_after_key = 5, -- milliseconds

			-- Smear configuration ---------------------------------------------------------

			-- How fast the smear's head moves towards the target.
			-- 0: no movement, 1: instantaneous
			stiffness = 0.65,

			-- How fast the smear's tail moves towards the target.
			-- 0: no movement, 1: instantaneous
			trailing_stiffness = 0.49, -- 0.3,

			-- Controls if middle points are closer to the head or the tail.
			-- < 1: closer to the tail, > 1: closer to the head
			trailing_exponent = 1, -- default 2

			-- How much the smear slows down when getting close to the target.
			-- < 0: less slowdown, > 0: more slowdown. Keep small, e.g. [-0.2, 0.2]
			slowdown_exponent = 0,

			-- Stop animating when the smear's tail is within this distance (in characters) from the target.
			distance_stop_animating = 0.15,

			-- Set of parameters for insert mode
			stiffness_insert_mode = 0.4,
			trailing_stiffness_insert_mode = 0.4,
			trailing_exponent_insert_mode = 1,
			distance_stop_animating_vertical_bar = 0.875, -- Can be decreased (e.g. to 0.1) if using legacy computing symbols

			-- When to switch between rasterization methods
			max_slope_horizontal = 0.5,
			min_slope_vertical = 2,

			-- color_levels = 16,                   -- Minimum 1, don't set manually if using cterm_cursor_colors
			gamma = 2.2,                            -- For color blending
			max_shade_no_matrix = 0.75,             -- 0: more overhangs, 1: more matrices
			matrix_pixel_threshold = 0.7,           -- 0: all pixels, 1: no pixel
			matrix_pixel_threshold_vertical_bar = 0.3, -- 0: all pixels, 1: no pixel
			matrix_pixel_min_factor = 0.5,          -- 0: all pixels, 1: no pixel
			volume_reduction_exponent = 0.3,        -- 0: no reduction, 1: full reduction
			minimum_volume_factor = 0.7,            -- 0: no limit, 1: no reduction
			max_length = 60,                        -- 35,                           -- Maximum smear length
			max_length_insert_mode = 1,
		},
	},
	{
		"rcarriga/nvim-notify",
		lazy = false,
		-- Use default renderer with custom window settings
		opts = {
			render = "default",
			stages = "fade_in_slide_out",
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
			end,
		},
	},
	{
		"folke/noice.nvim",
		lazy = false,
		opts = {
			lsp = {
				progress = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
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
				},
			},
			format = {
				markdown = {
					enabled = true, -- Make sure markdown formatting is enabled
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- {
	--   "lewis6991/hover.nvim",
	--   lazy = false,
	--   dependencies = { "neovim/nvim-lspconfig" },
	--   config = function()
	--     require("hover").setup({
	--       init = function(client, bufnr) -- Add parameters here
	--         require("hover.providers.lsp")
	--         -- Uncomment any additional providers you want to use:
	--         -- require('hover.providers.gh')
	--         -- require('hover.providers.gh_user')
	--         -- require('hover.providers.jira')
	--         require("hover.providers.dap")
	--         -- require('hover.providers.fold_preview')
	--         -- require('hover.providers.diagnostic')
	--         require("hover.providers.man")
	--         require("hover.providers.dictionary")
	--         -- require('hover.providers.highlight')
	--       end,
	--       preview_opts = {
	--         border = "single",
	--       },
	--       preview_window = false,
	--       title = true,
	--       mouse_providers = {
	--         "LSP",
	--       },
	--       --[[ mouse_delay = 1000, ]]
	--     })
	--   end,
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			--[[ "3rd/image.nvim", ]]
			-- opts = {},

			{
				"s1n7ax/nvim-window-picker",
				version = "*",
				opts = {
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						bo = {
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							buftype = { "terminal", "quickfix" },
						},
					},
				},
			},
		},
		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				shared_tree_across_tabs = true,
				default_component_configs = {
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
						default = "*",
						folder_empty_open = "󰝰",
					},
					git_status = {
						symbols = {
							added = "✚",
							modified = "",
							deleted = "✖",
							renamed = "󰁕",
						},
					},
				},
				window = {
					mappings = {
						["<CR>"] = "open",
						["p"] = "toggle_preview",
						["<leader><space>"] = "toggle_preview",
						["l"] = "open",
						["C"] = "close_node",
						["t"] = "open_tab_drop",
						["T"] = "open_tab_stay",
						-- 	mappings = require("config.keymaps").get_tree_mappings(),
					},
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = true,
					},
					hijack_netrw_behavior = "open_default",
				},
				commands = {
					open_tab_stay = function()
						require("neo-tree.sources.filesystem.commands").open_tabnew()
						vim.cmd("wincmd p") -- Return to previous window
					end,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				indicator = {
					icon = "▎",
					style = "icon",
				},
				theme = "auto",
				section_separators = { left = "", right = "" },
				-- component_separators = { left = '', right = '' },
				component_separators = { left = "", right = "" },
				--[[ section_separators = { left = "", right = "" }, ]]
				disabled_filetypes = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "" },
					},
					-- right_padding = 4
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {},
				lualine_x = { "filesize", "encoding", "fileformat" },
				lualine_y = { "progress", "location" },
				lualine_z = {
					{
						"filetype",
						separator = { right = "" },
					},
				},
			},
			inactive_sections = {
				lualine_a = { "branch", "diff", "diagnostics" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			-- highlights = get_bufferline_highlights(),
			options = {
				themable = true,
				separator_style = "thin",
				diagnostics = "nvim_lsp",
				indicator = {
					icon = "▎",
					style = "icon",
				},
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				color_icons = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" },
				},
				sort_by = "relative_directory",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					return "(" .. count .. ")"
				end,
				-- name_formatter = function(buf)  -- buf contains:
				-- name               -- | str        | the basename of the active file
				-- path               -- | str        | the full path of the active file
				-- bufnr               | int        | the number of the active buffer
				-- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
				-- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
				-- end,
			},
		},
	},

	--=============================== LSP Ecosystem ================================--
	{
		"williamboman/mason.nvim",
		lazy = false,
		opts = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason.nvim", -- mason core
			"neovim/nvim-lspconfig", -- native LSP configurations
			"hrsh7th/cmp-nvim-lsp", -- for capabilities
		},
		config = function()
			-- 1) Basic Mason setup
			require("mason").setup() -- mason.nvim v2.0+ :contentReference[oaicite:3]{index=3}

			-- 2) mason-lspconfig setup: ensure servers, auto‑enable them
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls", "clangd", "lua_ls", "pyright", "bashls",
					"tailwindcss", "html", "eslint", "vimls",
					"docker_compose_language_service", "dockerls",
					"cssls", "css_variables", "cssmodules_ls",
					"diagnosticls", "helm_ls",
				},
				automatic_enable = true, -- new in v2.0 :contentReference[oaicite:4]{index=4}
			})

			-- 3) Diagnostics UI tweaks
			vim.diagnostic.config({
				virtual_text     = false,
				signs            = true,
				update_in_insert = false,
				severity_sort    = true,
			})
			local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- 4) Set up LSP‐capabilities and formatting autocmd
			local capabilities = require("cmp_nvim_lsp")
					.default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- cmp capabilities :contentReference[oaicite:5]{index=5}
			local augroup      = vim.api.nvim_create_augroup("LspFormatting", {})

			local on_attach    = function(client, bufnr)
				-- only format non‑C/H files
				if client.supports_method("textDocument/formatting") then
					local ft = vim.bo[bufnr].filetype
					if ft ~= "c" and ft ~= "h" then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group    = augroup,
							buffer   = bufnr,
							callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
						})
					end
				end
			end

			-- 5) Configure each server via native API
			local lspconfig    = vim.lsp
					.config -- new in 0.11 :contentReference[oaicite:6]{index=6}
			local util         = require("lspconfig.util")

			-- default setup for most servers
			local servers      = { "pyright", "lua_ls", "ts_ls", "bashls", "html", "cssls", "eslint" }
			for _, name in ipairs(servers) do
				lspconfig(name, {
					capabilities = capabilities,
					on_attach    = on_attach,
				})
			end

			lspconfig("clangd", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					clangd = {
						Format = {
							Enable = false -- Disable clangd's built-in formatter
						}
					}
				}
			})

			-- typescript server with custom root_dir
			lspconfig("ts_ls", {
				capabilities = capabilities,
				on_attach    = on_attach,
				root_dir     = util.root_pattern("package.json", "tsconfig.json", ".git"),
			})
		end,
	},

	-- None-LS (null-ls) for formatting
	{
		"jay-babu/mason-null-ls.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"prettierd",
					"stylua",
					-- "ruff",
					"shfmt",
					"fixjson",
					"mdformat",
					"markdownlint",
					"yamlfix",
					"cmakelang",
					"cmakelint",
					"cmake_format",
					"nginx_config_formatter",
					"gitlint",
					"gitleak",
					"yamllint",
				},
				automatic_installation = true,
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Web
					null_ls.builtins.formatting.prettierd,
					-- null_ls.builtins.formatting.dprint,

					-- null_ls.builtins.formatting.ruff, -- Python
					-- null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.shfmt, -- Shell scripts
					-- null_ls.builtins.formatting.fixjson, -- JSON

					-- Markdown
					null_ls.builtins.formatting.mdformat,
					null_ls.builtins.diagnostics.markdownlint,

					null_ls.builtins.formatting.yamlfix, -- YAML
					-- null_ls.builtins.diagnostics.tsc,

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
		"windwp/nvim-autopairs",
		lazy = false,
		dependencies = { "hrsh7th/nvim-cmp" },
		event = "InsertEnter",
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")

			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { "string" },
					javascript = { "template_string" },
					typescript = { "template_string" },
					typescriptreact = { "template_string", "string", "comment" },
					javascriptreact = { "template_string", "string", "comment" },
				},
			})

			-- Add custom rules for JSX/TSX with more complete filetype handling
			npairs.add_rules({
				Rule("<", ">", { "typescriptreact" }),
				Rule("{", "}", { "typescriptreact" }),
				Rule("(", ")", { "typescriptreact" }),
				Rule("[", "]", { "typescriptreact" }),
				Rule("'", "'", { "typescriptreact" }),
				Rule('"', '"', { "typescriptreact" }),
				Rule("`", "`", { "typescriptreact" }),
			})

			-- Treesitter condition-based pairs
			npairs.add_rules({
				Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
				Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp_status_ok, cmp = pcall(require, "cmp")
			if cmp_status_ok then
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},
	-- {
	--   "abecodes/tabout.nvim",
	--   dependencies = { "nvim-treesitter/nvim-treesitter" },
	--   opts = { -- Add 'local' declaration
	--     tabkey = "<C-Tab>",
	--     backwards_tabkey = "<S-Tab>",
	--     completion = true,
	--     ignore_beginning = false,
	--   }, -- Removed trailing comma
	-- },
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
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"HiPhish/rainbow-delimiters.nvim",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"rrethy/nvim-treesitter-endwise",
			"windwp/nvim-autopairs",
			"abecodes/tabout.nvim",
			{
				"numToStr/Comment.nvim",
				config = function()
					-- Local definition ensures the `pre_hook` is scoped to this block
					local pre_hook = require("ts_context_commentstring.integrations.comment_nvim")
							.create_pre_hook()

					require("Comment").setup({
						pre_hook = pre_hook, -- Use the locally defined hook
					})
				end,
			},
			{
				"JoosepAlviste/nvim-ts-context-commentstring",
				config = function()
					require("ts_context_commentstring").setup({})
					vim.g.skip_ts_context_commentstring_module = true
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
					"python",
					"lua",
					"luadoc",
					"html",
					"css",
					"rust",
					"bash",
					"cmake",
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
					"jsdoc",
					"regex",
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
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "bottom",
			auto_close = true,
			auto_preview = true, -- auto open a window when hovering an item
			use_diagnostic_signs = true,
			use_lsp_diagnostic_signs = true,
			mode = "workspace_diagnostics",
			multiline = false,
			padding = false,
			auto_jump = { "lsp_definitions" },
			modes = {
				diagnostics = { auto_open = false },
				preview_float = {
					mode = "diagnostics",
					preview = {
						type = "float",
						relative = "editor",
						border = "rounded",
						title = "Preview",
						title_pos = "center",
						position = { 0, -2 },
						size = { width = 0.3, height = 0.3 },
						zindex = 200,
					},
				},
			}
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "horizontal", -- Opens at the bottom
			open_mapping = [[<c-\>]], -- Toggle with Ctrl+\ (default)
			size = 15,             -- Height of the terminal split
			persist_size = true,
			shade_terminals = true,
			insert_mappings = false, -- Disable default insert mode mappings
			close_on_exit = true,
			border = "curved",
			shell = vim.o.shell,
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		-- lazy = false,
		event = 'LspAttach',
		opts = {
			-- Custom configuration
			finder = {
				default = "telescope", -- Use telescope as the default finder
				methods = { "reference,", "definition", "telescope" },
				layout = "normal", -- Layout for the finder window
				keys = {
					quit = "q",      -- Custom quit key
				},
			},
			symbol_in_winbar = {
				enable = true,
				separator = "  ",
			},
			ui = {
				progress = {
					enable = false,
				},
				title = true,
				border = "rounded",
				actionfix = "",
				expand = "",
				collapse = "",
				-- kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				code_action = "💡",
				diagnostic = "🐞",
				colors = {
					normal_bg = "#022746",
				},
			},
			lightbulb = {
				enable = false,
				sign = true,
				virtual_text = true,
				jump_num_shortcut = true,
				show_soruce = true,
			},
			diagnostic = {
				show_code_action = true,
				show_source = true,
				jump_num_shortcut = true,
				keys = {
					exec_action = "o",
					quit = "q",
				},
			},
			project = {
				enable = true,
				detection_method = function()
					-- Use project.nvim's detection methods
					local project_util = require("project_nvim.utils.path")
					return project_util.get_project_root()
				end
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- "folke/trouble.nvim",
			"ahmedkhalf/project.nvim",
			-- "MeanderingProgrammer/render-markdown.nvim",
		},
	},
	-- {
	--   "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
	-- },
	{
		"Davidyz/VectorCode",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "VectorCode", -- if you're lazy-loading VectorCode
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim",
		},
		opts = {},
	},

	--=============================== CMP Ecosystem ================================--
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"windwp/nvim-autopairs",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			-- Main cmp setup
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Tab>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "codecompanion_models" },
					{ name = "codecompanion_slash_commands" },
					{ name = "codecompanion_tools" },
					{ name = "codecompanion_variables" },
					{ name = "cmdline" },
					{ name = 'render-markdown' },
					-- {
					-- 	name = "lazydev",
					-- 	group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					-- },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
						show_labeldetails = true,
					}),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						require("cmp-under-comparator").under, -- Needs plugin install!
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				experimental = {
					ghost_text = { h1_group = "CmpGhostText" },
				},
			})

			-- Cmdline setup for search ('/')
			-- cmp.setup.cmdline("/", {
			--   mapping = cmp.mapping.preset.cmdline({
			--     ["<C-n>"] = { c = cmp.mapping.select_next_item() },
			--     ["<C-p>"] = { c = cmp.mapping.select_prev_item() },
			--     ["<CR>"] = { c = cmp.mapping.confirm({ select = true }) },
			--   }),
			--   sources = {
			--     { name = "buffer" },
			--   },
			-- })

			-- Cmdline setup for search ('/')
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = { c = cmp.mapping.select_next_item() },
					["<C-p>"] = { c = cmp.mapping.select_prev_item() },
					["<S-CR>"] = { c = cmp.mapping.confirm({ select = true }) },
				}),

				sources = {
					{ name = "buffer" },
				},
			})

			-- Cmdline setup for command line (':')
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-n>"] = { c = cmp.mapping.select_next_item() },
					["<C-p>"] = { c = cmp.mapping.select_prev_item() },
					["<S-CR>"] = { c = cmp.mapping.confirm({ select = true }) },
				}),

				sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			})

			-- Load snippets
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	--=============================== DAP Debugger Ecosystem ================================--
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			"mrjones2014/legendary.nvim",
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"nvim-neotest/nvim-nio",
				},
				config = function()
					local dap = require("dap")
					local dapui = require("dapui")

					-- Setup dapui
					dapui.setup()

					-- Open/Close dapui automatically on debugging events
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			-- DAP Virtual Text Plugin
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {
					commented = true, -- Add comments for better readability
					enabled = true,
					enable_commands = true,
				},
			},
		},
		config = function()
			local dap = require("dap")
			local keymaps = require("config.keymaps")
			require("legendary").keymaps(keymaps.dap_mappings(dap))

			-- Example Adapter for gdb (adjust for embedded development)
			dap.adapters.gdb = {
				type = "executable",
				command = "arm-none-eabi-gdb", -- Replace with your gdb executable
				name = "gdb",
			}

			dap.configurations.c = {
				{
					name = "Launch",
					type = "gdb",
					request = "launch",
					program = "${workspaceFolder}/build/your_binary.elf", -- Replace with your ELF path
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					runInTerminal = false,
					setupCommands = {
						{
							text = "-enable-pretty-printing", -- Pretty-printing for better debugging output
							description = "Enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}

			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c
		end,
	},

	--=============================== Very Extra ================================--
	{
		"kawre/leetcode.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Leet", -- Load only on command
		opts = {
			-- configuration goes here
		},
	},
	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",      -- For standard functions
			"MunifTanjim/nui.nvim",       -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
		-- Offline mode configuration. For more details, see the "Offline mode" section below.
		--[[ offline_mode = { ]]
		--[[   -- Should offline mode be enabled? ]]
		--[[   enabled = false, ]]
		--[[   -- Do not connect to GitHub at all. Not even to get release information. ]]
		--[[   no_github = false, ]]
		--[[   -- What path should be looked at to find locally available releases ]]
		--[[   cache_dir = utils.path_join(utils.is_windows, vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"), ]]
		--[[ }, ]]
	},

	{
		"mrjones2014/legendary.nvim",
		keys = {
			{ "<C-p>", "<cmd>Legendary<cr>", desc = "Open Command Palette" },
		}, -- lazy = true,
		dependencies = {
			"kkharji/sqlite.lua",
			"folke/which-key.nvim",
		},
		config = function()
			require("legendary").setup({
				include_builtin = true,
				include_legendary_cmds = true,
				extensions = {
					which_key = {
						-- auto_register = {
						-- 	neotree = true,
						-- 	neo_tree = true,
						-- 	["neo-tree"] = true,
						-- },
						auto_register = true,
						do_binding = false,
						use_groups = true,
					},
				},
			})

			-- Load all regular keymaps
			local keymaps = require("config.keymaps")
			require("legendary").keymaps(keymaps.items)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "neo-tree",
				callback = function()
					require("legendary").keymaps(require("config.keymaps").items, {
						buffer = true,
						filetype = "neo-tree",
					})
				end,
			})

			-- Setup LSP keymaps when attaching to buffers
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local lsp_maps = require("config.keymaps").lsp_mappings(bufnr)
					require("legendary").keymaps(lsp_maps)
				end,
			})
		end,
	},
}
