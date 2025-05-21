-- # Structure:
--- - Core UI: Visual elements like themes, statuslines, notifications
--- - Editor Enhancement: Features that improve basic editing
--- - Project Management: Tools for moving around code and projects
--- - LSP & Completion: Language server and completion configurations
--- - CMP:
--- - :
--- PERF
--- - Extras: Fun stuff
--- - AI Tools: AI-assisted coding and writing features
--- TODO:
--- HACK:
--- NOTE:
--- FIX:
--- WARNING:

return {
	--============================== Core Plugins ==============================--
	-- { "pandasoli/nekovim" },
	{ "andweeb/presence.nvim", event = "VeryLazy" },
	{ "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		opts = {
			signs = true, -- show icons in the signs column
			sign_priority = 500, -- sign priority
			-- keywords recognized as todo comments
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					signs = true, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true, -- when true, custom keywords will be merged with the defaults
			-- highlighting of the line containing the todo comment
			-- * before: highlights before the keyword (typically comment characters)
			-- * keyword: highlights of the keyword
			-- * after: highlights after the keyword (todo text)
			highlight = {
				multiline = false, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				-- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {}, -- list of file types to exclude highlighting
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				-- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		opts = {
			---@param bufnr integer
			---@param filetype string
			---@param buftype string
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
			-- close_fold_kinds_for_ft
			-- close_fold_kinds = { "imports" },
			close_fold_kinds_for_ft = {
				description = [[After the buffer is displayed (opened for the first time), close the
                    folds whose range with `kind` field is included in this option. For now,
                    'lsp' provider's standardized kinds are 'comment', 'imports' and 'region',
                    and the 'treesitter' provider exposes the underlying node types.
                    This option is a table with filetype as key and fold kinds as value. Use a
                    default value if value of filetype is absent.
                    Run `UfoInspect` for details if your provider has extended the kinds.]],
				default = { default = {} },
			},
		},
	},
	{
		"lukas-reineke/cmp-under-comparator",
		event = "VeryLazy",
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
	{
		"github/copilot.vim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		-- event = "VeryLazy",
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
		lazy = true,
		build = "make",
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
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"nvimdev/dashboard-nvim",
		lazy = true,
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local function generate_header()
				local day = os.date("%A")
				local hour = tonumber(os.date("%H"))
				local greeting = hour < 12 and "Good Morning!" or hour < 18 and "Good Afternoon!" or "Good Evening!"

				return {
					greeting,
					"Today is " .. day,
				}
			end

			return {
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
		end,
	},
	--============================== Project Management ==============================--
	{
		"https://github.com/adelarsq/neovcs.vim",
		lazy = true,
		keys = {
			"<leader>v",
		},
		config = function()
			require("neovcs").setup()
		end,
	},
	{
		"HugoBde/subversigns.nvim",
		event = "VeryLazy",
	},
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

	-- {
	-- 	"obsidian-nvim/obsidian.nvim",
	-- 	version = "*", -- recommended, use latest release instead of latest commit
	-- 	lazy = true,
	-- 	ft = "markdown",
	-- 	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- 	-- event = {
	-- 	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	-- 	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	-- 	--   -- refer to `:h file-pattern` for more examples
	-- 	--   "BufReadPre path/to/my-vault/*.md",
	-- 	--   "BufNewFile path/to/my-vault/*.md",
	-- 	-- },
	-- 	dependencies = {
	-- 		-- Required.
	-- 		"nvim-lua/plenary.nvim",
	--
	-- 		-- see above for full list of optional dependencies ☝️
	-- 	},
	-- 	---@module 'obsidian'
	-- 	---@type obsidian.config.ClientOpts
	-- 	opts = {
	-- 		workspaces = {
	-- 			{
	-- 				name = "personal",
	-- 				path = "~/Documents/Notes",
	-- 			},
	-- 			{
	-- 				name = "work",
	-- 				path = "~/Documents/Obsidian Vault/",
	-- 			},
	-- 		},
	-- 		daily_notes = {
	-- 			-- Optional, if you keep daily notes in a separate directory.
	-- 			folder = "Daily Log",
	-- 			-- Optional, if you want to change the date format for the ID of daily notes.
	-- 			date_format = "%Y-%m-%d",
	-- 			-- Optional, if you want to change the date format of the default alias of daily notes.
	-- 			alias_format = "%B %-d, %Y",
	-- 			-- Optional, default tags to add to each new daily note created.
	-- 			default_tags = { "daily-notes" },
	-- 			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
	-- 			template = nil,
	-- 			-- Optional, if you want `Obsidian yesterday` to return the last work day or `Obsidian tomorrow` to return the next work day.
	-- 			workdays_only = true,
	-- 		},
	--
	-- 		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
	-- 		completion = {
	-- 			-- Enables completion using nvim_cmp
	-- 			nvim_cmp = true,
	-- 			-- Enables completion using blink.cmp
	-- 			blink = false,
	-- 			-- Trigger completion at 2 chars.
	-- 			min_chars = 2,
	-- 		},
	--
	-- 		-- 	  mappings = {
	-- 		--   -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
	-- 		--   ["gf"] = {
	-- 		--     action = function()
	-- 		--       return require("obsidian").util.gf_passthrough()
	-- 		--     end,
	-- 		--     opts = { noremap = false, expr = true, buffer = true },
	-- 		--   },
	-- 		--   -- Toggle check-boxes.
	-- 		--   ["<leader>ch"] = {
	-- 		--     action = function()
	-- 		--       return require("obsidian").util.toggle_checkbox()
	-- 		--     end,
	-- 		--     opts = { buffer = true },
	-- 		--   },
	-- 		--   -- Smart action depending on context: follow link, show notes with tag, toggle checkbox, or toggle heading fold
	-- 		--   ["<cr>"] = {
	-- 		--     action = function()
	-- 		--       return require("obsidian").util.smart_action()
	-- 		--     end,
	-- 		--     opts = { buffer = true, expr = true },
	-- 		--   },
	-- 		-- },
	--
	-- 		picker = {
	-- 			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
	-- 			name = "fzf-lua",
	-- 			-- Optional, configure key mappings for the picker. These are the defaults.
	-- 			-- Not all pickers support all mappings.
	-- 			note_mappings = {
	-- 				-- Create a new note from your query.
	-- 				new = "<C-x>",
	-- 				-- Insert a link to the selected note.
	-- 				insert_link = "<C-l>",
	-- 			},
	-- 			tag_mappings = {
	-- 				-- Add tag(s) to current note.
	-- 				tag_note = "<C-x>",
	-- 				-- Insert a tag at the current location.
	-- 				insert_tag = "<C-l>",
	-- 			},
	-- 		},
	--
	-- 		-- Optional, sort search results by "path", "modified", "accessed", or "created".
	-- 		-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
	-- 		-- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
	-- 		sort_by = "modified",
	-- 		sort_reversed = true,
	--
	-- 		-- Set the maximum number of lines to read from notes on disk when performing certain searches.
	-- 		search_max_lines = 1000,
	--
	-- 		-- Optional, determines how certain commands open notes. The valid options are:
	-- 		-- 1. "current" (the default) - to always open in the current window
	-- 		-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
	-- 		-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
	-- 		open_notes_in = "current",
	--
	-- 		-- Optional, define your own callbacks to further customize behavior.
	-- 		-- callbacks = {
	-- 		--   -- Runs at the end of `require("obsidian").setup()`.
	-- 		--   ---@param client obsidian.Client
	-- 		--   post_setup = function(client) end,
	-- 		--
	-- 		--   -- Runs anytime you enter the buffer for a note.
	-- 		--   ---@param client obsidian.Client
	-- 		--   ---@param note obsidian.Note
	-- 		--   enter_note = function(client, note) end,
	-- 		--
	-- 		--   -- Runs anytime you leave the buffer for a note.
	-- 		--   ---@param client obsidian.Client
	-- 		--   ---@param note obsidian.Note
	-- 		--   leave_note = function(client, note) end,
	-- 		--
	-- 		--   -- Runs right before writing the buffer for a note.
	-- 		--   ---@param client obsidian.Client
	-- 		--   ---@param note obsidian.Note
	-- 		--   pre_write_note = function(client, note) end,
	-- 		--
	-- 		--   -- Runs anytime the workspace is set/changed.
	-- 		--   ---@param client obsidian.Client
	-- 		--   ---@param workspace obsidian.Workspace
	-- 		--   post_set_workspace = function(client, workspace) end,
	-- 		-- },
	--
	-- 		-- Optional, configure additional syntax highlighting / extmarks.
	-- 		-- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
	-- 		ui = {
	-- 			enable = true, -- set to false to disable all additional syntax features
	-- 			update_debounce = 200, -- update delay after a text change (in milliseconds)
	-- 			max_file_length = 5000, -- disable UI features for files with more than this many lines
	-- 			-- Define how various check-boxes are displayed
	-- 			checkboxes = {
	-- 				-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
	-- 				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
	-- 				["x"] = { char = "", hl_group = "ObsidianDone" },
	-- 				[">"] = { char = "", hl_group = "ObsidianRightArrow" },
	-- 				["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
	-- 				["!"] = { char = "", hl_group = "ObsidianImportant" },
	-- 				-- Replace the above with this if you don't have a patched font:
	-- 				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
	-- 				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
	--
	-- 				-- You can also add more custom ones...
	-- 			},
	-- 			-- Use bullet marks for non-checkbox lists.
	-- 			bullets = { char = "•", hl_group = "ObsidianBullet" },
	-- 			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
	-- 			-- Replace the above with this if you don't have a patched font:
	-- 			-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
	-- 			reference_text = { hl_group = "ObsidianRefText" },
	-- 			highlight_text = { hl_group = "ObsidianHighlightText" },
	-- 			tags = { hl_group = "ObsidianTag" },
	-- 			block_ids = { hl_group = "ObsidianBlockID" },
	-- 			hl_groups = {
	-- 				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
	-- 				ObsidianTodo = { bold = true, fg = "#f78c6c" },
	-- 				ObsidianDone = { bold = true, fg = "#89ddff" },
	-- 				ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
	-- 				ObsidianTilde = { bold = true, fg = "#ff5370" },
	-- 				ObsidianImportant = { bold = true, fg = "#d73128" },
	-- 				ObsidianBullet = { bold = true, fg = "#89ddff" },
	-- 				ObsidianRefText = { underline = true, fg = "#c792ea" },
	-- 				ObsidianExtLinkIcon = { fg = "#c792ea" },
	-- 				ObsidianTag = { italic = true, fg = "#89ddff" },
	-- 				ObsidianBlockID = { italic = true, fg = "#89ddff" },
	-- 				ObsidianHighlightText = { bg = "#75662e" },
	-- 			},
	-- 		},
	--
	-- 		-- Specify how to handle attachments.
	-- 		attachments = {
	-- 			-- The default folder to place images in via `:Obsidian paste_img`.
	-- 			-- If this is a relative path it will be interpreted as relative to the vault root.
	-- 			-- You can always override this per image by passing a full path to the command instead of just a filename.
	-- 			img_folder = "assets/imgs", -- This is the default
	--
	-- 			-- A function that determines default name or prefix when pasting images via `:Obsidian paste_img`.
	-- 			---@return string
	-- 			img_name_func = function()
	-- 				-- Prefix image names with timestamp.
	-- 				return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
	-- 			end,
	--
	-- 			-- A function that determines the text to insert in the note when pasting an image.
	-- 			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
	-- 			-- This is the default implementation.
	-- 			---@param client obsidian.Client
	-- 			---@param path obsidian.Path the absolute path to the image file
	-- 			---@return string
	-- 			img_text_func = function(client, path)
	-- 				path = client:vault_relative_path(path) or path
	-- 				return string.format("![%s](%s)", path.name, path)
	-- 			end,
	-- 		},
	--
	-- 		-- See https://github.com/obsidian-nvim/obsidian.nvim/wiki/Notes-on-configuration#statusline-component
	-- 		statusline = {
	-- 			enabled = true,
	-- 			format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
	-- 		},
	-- 		preferred_link_style = "wiki",
	--
	-- 		-- Optional, boolean or a function that takes a filename and returns a boolean.
	-- 		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
	-- 		disable_frontmatter = false,
	--
	-- 		-- see below for full list of options 👇
	-- 	},
	-- },
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
	{
		"shortcuts/no-neck-pain.nvim",
		event = "VeryLazy",
		version = "*",
		blend = 0.1,
		skipEnteringNoNeckPainBuffer = true,
	},
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
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			file_types = { "checkhealth", "markdown", "Avante", "hover", "lspsaga", "pretty_hover", "pretty-hover" },
		},
		ft = { "markdown", "Avante", "hover", "lspsaga", "pretty_hover", "pretty-hover" },
		config = function()
			require("render-markdown").setup({
				completions = { lsp = { enabled = true } },
				heading = {
					width = { "block" },
					border = true,
					position = "inline",
					enabled = true,
					render_modes = true,
					atx = true, -- render special stuff instead of ###
					setext = true,
					sign = true,

					border_virtual = true,

					above = "", -- "▄",
					below = "", --"▀",
				},
				code_blocks = {
					languages = { c = "doxygen", cpp = "doxygen" },
				},
			})
		end,
	},

	--============================== UI Enhancements ==============================--
	{
		"karb94/neoscroll.nvim",
		event = "VeryLazy",
		opts = {
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = false,
			cursor_scrolls_alone = true,
			duration_multiplier = 1.2,
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
		event = "VeryLazy",
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
			stiffness = 0.70,

			-- How fast the smear's tail moves towards the target.
			-- 0: no movement, 1: instantaneous
			trailing_stiffness = 0.65, -- 49 0.3,

			-- Controls if middle points are closer to the head or the tail.
			-- < 1: closer to the tail, > 1: closer to the head
			trailing_exponent = 2, -- default 2

			-- How much the smear slows down when getting close to the target.
			-- < 0: less slowdown, > 0: more slowdown. Keep small, e.g. [-0.2, 0.2]
			slowdown_exponent = 0,

			-- Stop animating when the smear's tail is within this distance (in characters) from the target.
			distance_stop_animating = 0.15,

			-- Set of parameters for insert mode
			stiffness_insert_mode = 0.7,
			trailing_stiffness_insert_mode = 0.65,
			trailing_exponent_insert_mode = 2,
			distance_stop_animating_vertical_bar = 0.1, -- Can be decreased (e.g. to 0.1) if using legacy computing symbols

			-- When to switch between rasterization methods
			max_slope_horizontal = 0.5,
			min_slope_vertical = 2,

			-- color_levels = 16,                   -- Minimum 1, don't set manually if using cterm_cursor_colors
			gamma = 2.2, -- For color blending
			max_shade_no_matrix = 0.75, -- 0: more overhangs, 1: more matrices
			matrix_pixel_threshold = 0.7, -- 0: all pixels, 1: no pixel
			matrix_pixel_threshold_vertical_bar = 0.3, -- 0: all pixels, 1: no pixel
			matrix_pixel_min_factor = 0.5, -- 0: all pixels, 1: no pixel
			volume_reduction_exponent = 0.3, -- 0: no reduction, 1: full reduction
			minimum_volume_factor = 0.7, -- 0: no limit, 1: no reduction
			max_length = 60, -- 35,                           -- Maximum smear length
			max_length_insert_mode = 1,
		},
	},
	{
		"rcarriga/nvim-notify",
		-- lazy = false,
		event = "VeryLazy",
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
				-- vim.lsp.handlers["$/progress"] = vim.notify
			end,
		},
	},
	{
		"folke/noice.nvim",
		-- lazy = false,
		opts = {
			lsp = {
				progress = {
					enabled = true,
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
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
					spinner = "aesthetic",
				},
			},
			format = {
				markdown = {
					enabled = true,
				},
			},
			documentation = {
				-- view = "lspsaga",
				opts = {},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		-- lazy = false,
		event = "LspAttach",
		opts = {
			finder = {
				default = "telescope", -- Use telescope as the default finder
				methods = { "reference,", "definition", "telescope" },
				layout = "normal", -- Layout for the finder window
				keys = {
					quit = "q", -- Custom quit key
				},
			},
			outline = {
				win_position = "right",
				win_width = 30,
				auto_preview = true,
				detail = true,
				auto_close = true,
				close_after_jump = false,
				layout = "normal",
				max_height = 0.5,
				left_width = 0.1,
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
				-- colors = {
				-- 	normal_bg = "#022746",
				-- },
			},
			lightbulb = {
				enable = false,
				sign = true,
				virtual_text = true,
				jump_num_shortcut = true,
				show_soruce = true,
			},
			hover = {
				enable = true,
				open_link = "gx",
				-- open_cmd = "tabedit",
				open_browser = "default", -- or "firefox" etc.
				-- render = "markdown_oxide", -- Ensure markdown rendering is enabled
				border = "rounded",
				keys = {
					scroll_down = "<C-f>",
					scroll_up = "<C-b>",
					-- open_cmd = "vsplit",
					-- open_cmd = "edit",
				},
			},
			outline = {
				max_height = 0.3,
				left_width = 0.3,
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
					local project_util = require("project_nvim.utils.path")
					return project_util.get_project_root()
				end,
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			-- "folke/trouble.nvim",
			"ahmedkhalf/project.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
		},
	},
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {
			multi_server = true,
			border = "rounded",
		},
		dependencies = {
			"nvimdev/lspsaga.nvim", -- Ensure LspSaga loads first
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		-- event = "VeryLazy",
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
					},
				},
			},
		},
		config = function()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "󰌵",
					},
				},
			})
			require("neo-tree").setup({
				close_if_last_window = true,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				shared_tree_across_tabs = true,
				enable_cursor_hijack = true,
				tabs_layout = "active", -- start, end, center, equal, focus
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
					icon = {
						folder_closed = "",
						folder_open = "",
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
							added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted = "✖", -- this can only be used in the git_status source
							renamed = "󰁕", -- this can only be used in the git_status source
							-- Status type
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
							-- added = "✚",
							-- modified = "",
							-- deleted = "✖",
							-- renamed = "󰁕",
						},
					},
				},
				window = {
					mappings = {
						["<CR>"] = "open",
						["p"] = "paste_from_clipboard",
						["<leader><space>"] = "toggle_preview",
						["l"] = "open",
						["C"] = "close_node",
						["t"] = "open_tab_drop",
						["T"] = "open_tabnew",
						["oa"] = "avante_add_files",
						["S"] = "split_with_window_picker", -- or comment for default split
						["s"] = "vsplit_with_window_picker", -- or comment for default split
						["Z"] = "expand_all_nodes",
						-- 	mappings = require("config.keymaps").get_tree_mappings(),
					},
				},
				filesystem = {
					follow_current_file = {
						enabled = false,
						leave_dirs_open = true,
						group_empty_dirs = true,
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

					-- Add files to avante buffer
					avante_add_files = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local relative_path = require("avante.utils").relative_path(filepath)

						local sidebar = require("avante").get()

						local open = sidebar:is_open()
						-- ensure avante sidebar is open
						if not open then
							require("avante.api").ask()
							sidebar = require("avante").get()
						end

						sidebar.file_selector:add_selected_file(relative_path)

						-- remove neo tree buffer
						if not open then
							sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
						end
					end,
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		-- lazy = false,
		-- event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				indicator = {
					icon = "▎",
					style = "icon",
				},
				theme = "auto",
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				--[[ section_separators = { left = "", right = "" }, ]]
				disabled_filetypes = { "dashboard", "neo-tree", "lazy", "sagaoutline" },
				ignore_focus = {
					"neo-tree",
					"lspsaga",
					"sagaoutline",
					"trouble",
					"terminal",
					"toggleterm",
					"Avante",
					"AvanteSelectedFiles",
					"AvanteInput",
					"themery",
					"TelescopePrompt",
					"lazy",
				},
				always_divide_middle = true,
				globalstatus = false,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { right = "", left = "" },
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
						separator = { right = "", left = "" },
					},
				},
			},
			-- inactive_sections = {
			-- 	lualine_a = { "branch", "diff", "diagnostics" },
			-- 	lualine_b = {},
			-- 	lualine_c = {},
			-- 	lualine_x = {},
			-- 	lualine_y = {},
			-- 	lualine_z = {},
			-- },
		},
	},
	{
		"akinsho/bufferline.nvim",
		-- lazy = false,
		-- event = "VeryLazy",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			-- highlights = get_bufferline_highlights(),
			options = {
				themable = true,
				numbers = "none", -- | "ordinal" | "buffer_id" | "both" |
				separator_style = "thin", -- slant, padded_slant, slope, thick, thin
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
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
				-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
				-- 	return "(" .. count .. ")"
				-- end,
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
			require("mason").setup()

			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					"clangd",
					"lua_ls",
					"pyright",
					"bashls",
					"tailwindcss",
					"html",
					"eslint",
					"vimls",
					"docker_compose_language_service",
					"dockerls",
					"cssls",
					"css_variables",
					"cssmodules_ls",
					"diagnosticls",
					"helm_ls",
					"markdown_oxide",
				},
				automatic_enable = true, -- new in v2.0 :contentReference[oaicite:4]{index=4}
				file_watcher = {
					enable = true,
					debounce = 100, -- Debounce time in ms (optional)
				},
			})

			-- 3) Diagnostics UI tweaks
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})
			local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- 4) Set up LSP‐capabilities and formatting autocmd
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- cmp capabilities :contentReference[oaicite:5]{index=5}
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local on_attach = function(client, bufnr)
				-- only format non‑C/H files
				if client.supports_method("textDocument/formatting") then
					local ft = vim.bo[bufnr].filetype
					if ft ~= "c" and ft ~= "h" then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end
			end

			-- local lspconfig = require("lspconfig")
			local lspconfig = vim.lsp.config -- new in 0.11 :contentReference[oaicite:6]{index=6}
			local util = require("lspconfig.util")

			-- default setup for most servers
			local servers = { "pyright", "lua_ls", "ts_ls", "bashls", "html", "cssls", "eslint" }
			for _, name in ipairs(servers) do
				lspconfig(name, {
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			-- -- old way:
			-- for _, name in ipairs(servers) do
			-- 	lspconfig[name].setup({
			-- 		capabilities = capabilities,
			-- 		on_attach = on_attach,
			-- 	})
			-- end

			lspconfig("clangd", {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					clangd = {
						Format = {
							Enable = false, -- Disable clangd's built-in formatter
						},
					},
				},
			})

			-- typescript server with custom root_dir
			-- 		lspconfig("ts_ls", {
			-- 			capabilities = capabilities,
			-- 			on_attach    = on_attach,
			-- 			root_dir     = util.root_pattern("package.json", "tsconfig.json", ".git"),
			-- 		})
		end,
	},

	-- None-LS (null-ls) for formatting
	{
		"jay-babu/mason-null-ls.nvim",
		-- lazy = false,
		event = "VeryLazy",
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
				handlers = {},
			})

			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Web
					null_ls.builtins.formatting.prettierd,
					-- null_ls.builtins.formatting.dprint,

					-- null_ls.builtins.formatting.ruff, -- Python
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.shfmt, -- Shell scripts
					-- null_ls.builtins.formatting.fixjson, -- JSON

					-- Markdown
					null_ls.builtins.formatting.mdformat,
					null_ls.builtins.diagnostics.markdownlint,

					null_ls.builtins.formatting.yamlfix, -- YAML

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
					local pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()

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
					"cmake",
					"python",
					"lua",
					"luadoc",
					"html",
					"css",
					"rust",
					"bash",
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
	{ "RRethy/vim-illuminate" }, -- Highlight other uses of an expression
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			position = "bottom",
			pinned = false,
			auto_close = true,
			auto_preview = true, -- auto open a window when hovering an item
			use_diagnostic_signs = true,
			use_lsp_diagnostic_signs = true,
			-- mode = "workspace_diagnostics",
			multiline = true,
			padding = true,
			preview = {
				type = "float",
				relative = "editor",
				border = "rounded",
				title = "Preview",
				title_pos = "center",
				position = { 0, -2 },
				size = { width = 0.4, height = 0.4 },
				zindex = 100,
			},
			auto_jump = { "lsp_definitions" },
			modes = {
				diagnostics = {
					-- use a split, relative to the window:
					win = {
						type = "split",
						relative = "win",
						position = "bottom",
						-- 30% of the window height; can be <1.0 for % or >1 for fixed lines
						size = 0.3,
					},
				},
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		opts = {
			direction = "float", --horizontal", -- Opens at the bottom
			open_mapping = [[<c-\>]], -- Toggle with Ctrl+\ (default)
			autochdir = true,
			size = 15, -- Height of the terminal split
			persist_size = true,
			shade_terminals = false,
			insert_mappings = false, -- Disable default insert mode mappings
			close_on_exit = true,
			border = "curved",
			shell = "fish",
		},
	},
	-- {
	--   "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
	-- },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			provider = "openai", -- ollama , aihubmix,
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
				temperature = 0,
				max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
			},
			rag_service = {
				enabled = false, -- Enables the RAG service
				host_mount = os.getenv("HOME"), -- Host mount path for the rag service
				provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
				llm_model = "", -- The LLM model to use for RAG service
				embed_model = "", -- The embedding model to use for RAG service
				endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
			},
			-- web_search_engine = {
			-- 	provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
			-- 	proxy = nil,     -- proxy support, e.g., http://127.0.0.1:7890
			-- },
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
		},
	},
	-- {
	-- 	"Davidyz/VectorCode",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	cmd = "VectorCode", -- if you're lazy-loading VectorCode
	-- },
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
					{ name = "cmdline" },
					{ name = "render-markdown" },
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
						require("cmp-under-comparator").under,
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
		event = "VeryLazy",
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
				-- event = "VeryLazy",
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
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
		offline_mode = {
			enabled = true,
			no_github = false,
		},
		-- Offline mode configuration. For more details, see the "Offline mode" section below.
		--[[   -- What path should be looked at to find locally available releases ]]
		--[[   cache_dir = utils.path_join(utils.is_windows, vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"), ]]
	},
	{
		"mrjones2014/legendary.nvim",
		keys = {
			{ "<C-p>", "<cmd>Legendary<cr>", desc = "Open Command Palette" },
		},
		lazy = true,
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
	{
		"m4xshen/hardtime.nvim",

		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {

			lazy = false,
			enabled = false,
			restriction_mode = "hint",
		},
	},
}
