return {
	{
		"shortcuts/no-neck-pain.nvim",
		event = "VeryLazy",
		version = "*",
		blend = 0.1,
		skipEnteringNoNeckPainBuffer = true,
	},
	{
		"ThePrimeagen/harpoon",
		event = "VeryLazy",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
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
				theme = "hyper", --doom
				disable_at_vimenter = true,
				change_to_vcs_root = true,
				config = {
					header = generate_header(),
					week_header = {
						enable = true,
						concat = " - Let's Code!",
					},
					-- disable_move = false,
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
			-- require("telescope").extensions.projects.projects({})
			require("telescope").load_extension("fzf")
		end,
	},
}
