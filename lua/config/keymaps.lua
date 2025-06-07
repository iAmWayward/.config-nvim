-- config/keymaps.lua
local M = {}
-- {{{ Section Name
-- fold markers
-- }}}
--

M.items = {
	-- Base keymaps
	{ mode = { "n", "x" }, "<leader>n", group = "+NoNeckPain" },

	{
		mode = "n",
		"<leader>hd",
		function()
			local cursor_highlight = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
			print("Highlight group under cursor: " .. cursor_highlight)
		end,
		description = "Show highlight group under cursor",
	},
	{ mode = "n", "<leader>tT", "<cmd>Themery<cr>", description = "Change theme" },
	{ mode = "n", "<leader>tt", "<cmd>TransparentToggle<cr>", description = "Toggle Transparency" },
	{ mode = { "n", "x" }, "<leader>cp", '"+y', description = "Copy to system clipboard" },
	{ mode = { "n", "x" }, "<leader>cv", '"+p', description = "Paste from system clipboard" },
	{ mode = { "n", "x" }, "C-<tab>", 'copilot#Accept("<CR>")', description = "accept from Copilot" },
	{
		mode = "n",
		"<leader>uh",
		function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end,
		description = "Toggle Inlay Hints",
	},
	{
		mode = "n",
		"<leader>tn",
		"<cmd>:set relativenumber!<cr>",
		description = "Toggle relative numbers",
	},
	-- NoNeckPain
	{
		itemgroup = "+NoNeckPain",
		description = "Center code in the terminal to reduce neck strain and increase ergonomics",
		icon = "",
		keymaps = {
			{ mode = "n", "<leader>nnp", "<cmd>NoNeckPain<cr>", description = "Toggle No Neck Pain" },
			{ mode = "n", "<leader>nwu", "<cmd>NoNeckPainWidthUp<cr>", description = "Increase width" },
			{ mode = "n", "<leader>nwd", "<cmd>NoNeckPainWidthDown<cr>", description = "Decrease width" },
			{ mode = "n", "<leader>nns", "<cmd>NoNeckPainScratchPad<cr>", description = "Toggle scratchpad" },
		},
	},
	{
		itemgroup = "+UFO",
		description = "Center code in the terminal to reduce neck strain and increase ergonomics",
		icon = "",
		keymaps = {
			{ mode = "n", "zR", require("ufo").openAllFolds, description = "Open all folds" },
			{ mode = "n", "zM", require("ufo").closeAllFolds, description = "Close all folds" },
			{ mode = "n", "zr", require("ufo").openFoldsExceptKinds, description = "Open folds except kind" },
			{ mode = "n", "zm", require("ufo").closeFoldsWith, description = "Close folds with..." },
			{
				mode = "n",
				"K",
				function()
					local ufo = require("ufo")
					-- If ufo.peekFoldedLinesUnderCursor exists and returns true (meaning it showed a fold)
					if ufo and ufo.peekFoldedLinesUnderCursor and ufo.peekFoldedLinesUnderCursor() then
						return -- UFO handled it, so we're done.
					end
					require("pretty_hover").hover()
				end,
				description = "Peek fold (UFO) or pretty_hover",
			},
		},
	},
	-- Doxygen
	{
		itemgroup = "+Documentation",
		description = "Code documentation tools",
		icon = "󰏫",
		keymaps = {
			{ "<leader>dd", "<cmd>DoxygenOpen<CR>", desc = "Open Doxygen" },
			{ "<leader>du", "<cmd>DoxygenUpdate<CR>", desc = "Update Doxygen" },
		},
	},

	-- Neogen
	{
		itemgroup = "+Neogen",
		description = "Quickly generate header comments for a variety of languages using various format specifications.",
		icon = "",
		keymaps = {
			{
				mode = "n",
				"<leader>ng",
				function()
					require("neogen").generate()
				end,
				description = "Generate docs",
			},
			{
				mode = "n",
				"<leader>nf",
				function()
					require("neogen").generate({ type = "func" })
				end,
				description = "Function doc",
			},
			{
				mode = "n",
				"<leader>nc",
				function()
					require("neogen").generate({ type = "class" })
				end,
				description = "Class doc",
			},
		},
	},
	{
		itemgroup = "+Diagnostics",
		description = "Index errors, warnings, and info dialouges and diagnostics.",
		icon = "",
		keymaps = {
			{
				"<leader>xx",
				function()
					require("config.toggle-trouble").toggle_below()
				end,
				desc = "鈴 Diagnostics below code (Trouble)",
			},
			{
				"<leader>xX",
				function()
					require("config.toggle-trouble").toggle_buffer_diagnostics()
				end,
				desc = "󰒡 Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				function()
					require("config.toggle-trouble").toggle_symbols()
				end,
				desc = "󰒡 Symbols (Trouble)",
			},
			{
				"<leader>xr",
				function()
					require("config.toggle-trouble").toggle_lsp()
				end,
				desc = "󰒡 LSP Definitions / References (Trouble)",
			},
			{
				"<leader>xL",
				function()
					require("config.toggle-trouble").toggle_loclist()
				end,
				desc = "󰒡 Location List (Trouble)",
			},
			{
				"<leader>xQ",
				function()
					require("config.toggle-trouble").toggle_qflist()
				end,
				desc = "󰒡 Quickfix List (Trouble)",
			},
			{
				"<leader>xi",
				function()
					require("config.toggle-trouble").toggle_implement()
				end,
				desc = "󰒡 Symbols (Trouble)",
			},
			{
				"<leader>xtd",
				function()
					require("config.toggle-trouble").toggle_typedef()
				end,
				desc = "󰒡 LSP Definitions / References (Trouble)",
			},
		},
	},

	-- Neo-tree
	{
		itemgroup = "+File Tree",
		description = "File tree navigation",
		icon = "",
		keymaps = {
			{
				mode = "n",
				"<Bar>",
				"<cmd>Neotree reveal<cr>",
				description = "Reveal file in Neo-tree",
			},
			{
				mode = "n",
				"rf",
				function()
					vim.cmd("Neotree float reveal_file=" .. vim.fn.expand("<cfile>") .. " reveal_force_cwd")
				end,
				description = "Reveal in float",
			},
			{
				mode = "n",
				"<leader>B",
				"<cmd>Neotree buffers toggle position=right<cr>",
				description = "Buffer list",
			},
			{
				mode = "n",
				"<leader>s",
				"<cmd>Neotree float git_status<cr>",
				description = "Git status",
			},
			{
				mode = "n",
				"<leader><space>",
				"<cmd>Neotree filesystem show<cr>",
				description = "Show filesystem",
			},
			{
				mode = "n",
				"<leader>o",
				"<cmd>Neotree toggle<cr>",
				description = "Toggle Neo-tree",
			},
		},
		condition = function()
			return vim.bo.filetype == "neo-tree"
		end,
		opts = {
			buffer = 0, -- 0 means current buffer
			show_keys = true,
		},
	},

	-- Bufferline
	{
		itemgroup = "+Bufferline",
		description = "Use buffers as tabs to allow one terminal tab to encapsulate a project",
		icon = "",
		keymaps = {
			{ mode = { "n", "i" }, "<M-PageUp>", "<cmd>BufferLineCyclePrev<CR>", description = "Previous buffer" },
			{ mode = { "n", "i" }, "<M-PageDown>", "<cmd>BufferLineCycleNext<CR>", description = "Next buffer" },
			{ mode = "n", "<leader>q", "<cmd>bp|bd #<CR>", description = "Close buffer" },
		},
	},

	{
		itemgroup = "+Scrolling",
		description = "Smooth scrolling with neoscroll",
		icon = "󰅟",
		keymaps = {
			{
				mode = { "n", "v", "x" },
				"<C-k>",
				function()
					require("neoscroll").ctrl_u({ duration = 250 })
				end,
			},
			{
				mode = { "n", "v", "x" },
				"<C-j>",
				function()
					require("neoscroll").ctrl_d({ duration = 250 })
				end,
			},
			{
				mode = { "n", "v", "x" },
				"<C-b>",
				function()
					require("neoscroll").ctrl_b({ duration = 450 })
				end,
			},
			{
				mode = { "n", "v", "x" },
				"<C-f>",
				function()
					require("neoscroll").ctrl_f({ duration = 450 })
				end,
			},
			{
				mode = { "n", "v", "x" },
				"<C-y>",
				function()
					require("neoscroll").scroll(-0.1, { move_cursor = false, duration = 100 })
				end,
			},
			{
				mode = { "n", "v", "x" },
				"<C-e>",
				function()
					require("neoscroll").scroll(0.1, { move_cursor = false, duration = 100 })
				end,
			},
			{
				mode = "n",
				"zt",
				function()
					require("neoscroll").zt({ half_win_duration = 250 })
				end,
			},
			{
				mode = "n",
				"zz",
				function()
					require("neoscroll").zz({ half_win_duration = 250 })
				end,
			},
			{
				mode = "n",
				"zb",
				function()
					require("neoscroll").zb({ half_win_duration = 250 })
				end,
			},
			{
				mode = { "n", "v", "x", "i" }, -- Add relevant modes here
				"<PageUp>",
				function()
					require("neoscroll").scroll(-vim.api.nvim_win_get_height(0) + 10, { duration = 250 })
				end,
				description = "Page Up (Neoscroll)",
			},
			{
				mode = { "n", "v", "x", "i" }, -- Add relevant modes here
				"<PageDown>",
				function()
					require("neoscroll").scroll(vim.api.nvim_win_get_height(0) - 10, { duration = 250 })
				end,
				description = "Page Down (Neoscroll)",
			},
		},
	},

	-- Telescope
	{
		itemgroup = "+Telescope",
		description = "Find files and strings using telescope",
		icon = "",
		keymaps = {
			{ mode = "n", "<leader>ff", require("telescope.builtin").find_files, description = "Find Files" },
			{ mode = "n", "<leader>fg", require("telescope.builtin").live_grep, description = "Live Grep" },
			{ mode = "n", "<leader>fb", require("telescope.builtin").buffers, description = "Find Buffers" },
			{ mode = "n", "<leader>fh", require("telescope.builtin").help_tags, description = "Help Tags" },
		},
	},
	{
		mode = { "n", "v" }, -- Add relevant modes here
		"<leader>gp",
		function()
			require("neoscroll").scroll(vim.api.nvim_win_get_height(0) - 10, { duration = 250 })
		end,
		description = "Page Down (Neoscroll)",
	},
	{
		mode = "n",
		"<leader>gp",
		function()
			vim.system({ "git", "pull" }, { text = true }, function(result)
				vim.notify(result.stdout)
			end)
		end,
		desc = "Git Pull",
	},
}

M.lsp_mappings = function(bufnr)
	return {

		{
			itemgroup = "+LSPSaga",
			description = "Quick operations based on code project context.",
			icon = "",
			keymaps = {
				{
					mode = "n",
					"gh",
					"<cmd>Lspsaga finder<CR>",
					description = "LSP Finder",
					buffer = bufnr,
				},
				{
					mode = "n",
					"gd",
					"<cmd>Lspsaga peek_definition<CR>",
					description = "Peek Definition",
					buffer = bufnr,
				},
				{
					mode = "n",
					"gD",
					vim.lsp.buf.definition,
					description = "Go to Definition",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>ca",
					"<cmd>Lspsaga code_action<CR>",
					description = "Code Action",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>rn",
					"<cmd>Lspsaga rename<CR>",
					description = "Rename Symbol",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>O",
					"<cmd>Lspsaga outline<CR>",
					description = "Toggle Outline",
					buffer = bufnr,
				},
				{
					mode = "n",
					"gi",
					function()
						require("telescope.builtin").lsp_implementations()
					end,
					-- require("telescope.builtin").lsp_implementations(),
					-- vim.lsp.buf.implementation,
					description = "Go to Implementation",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>gR",
					function()
						require("telescope.builtin").lsp_references()
					end,
					description = "Find References",
					buffer = bufnr,
				},
				-- {
				-- mode = "n",
				-- "gR",
				-- vim.lsp.buf.references,
				-- description = "Find References",
				-- buffer = bufnr,
				-- },
				{
					mode = "n",
					"<leader>sh",
					vim.lsp.buf.signature_help,
					description = "Signature Help",
					buffer = bufnr,
				},
				{
					mode = "n",
					"[d",
					"<cmd>Lspsaga diagnostic_jump_prev<CR>",
					description = "Previous Diagnostic",
					buffer = bufnr,
				},
				{
					mode = "n",
					"]d",
					"<cmd>Lspsaga diagnostic_jump_next<CR>",
					description = "Next Diagnostic",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>e",
					"<cmd>Lspsaga show_line_diagnostics<CR><cmd>Lspsaga code_action<CR>",
					description = "Show Line Diagnostic",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>F",
					function()
						vim.lsp.buf.format({ async = true })
					end,
					description = "Format Code",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>ws",
					vim.lsp.buf.workspace_symbol,
					description = "Workspace Symbol",
					buffer = bufnr,
				},
				{
					mode = "n",
					"<leader>sf",
					"<cmd>Lspsaga finder<CR>",

					-- vim.lsp.buf.workspace_symbol,
					description = "Workspace Symbol",
					buffer = bufnr,
				},
			},
		},
	}
end

M.dap_mappings = function(dap)
	return {
		{
			itemgroup = "+Debugger",
			description = "Comprehensive debugging",
			icon = "",
			keymaps = {
				{ mode = "n", "<F5>", dap.continue, description = "Start/Continue Debugging" },
				{ mode = "n", "<F10>", dap.step_over, description = "Step Over" },
				{ mode = "n", "<F11>", dap.step_into, description = "Step Into" },
				{ mode = "n", "<F12>", dap.step_out, description = "Step Out" },
				{ mode = "n", "<Leader>b", dap.toggle_breakpoint, description = "Toggle Breakpoint" },
				{
					mode = "n",
					"<Leader>cb",
					function()
						dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
					end,
					description = "Conditional Breakpoint",
				},
				{ mode = "n", "<Leader>dr", dap.repl.open, description = "Open REPL" },
				{ mode = "n", "<Leader>dl", dap.run_last, description = "Run Last Session" },
			},
		},

		-- Project Navigation
		{
			itemgroup = "+Projects",
			description = "Project management and navigation",
			icon = "󰉋",
			keymaps = {
				{ "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Find projects" },
				{
					"<leader>hp",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon file",
				},
				{
					"<leader>hq",
					function()
						require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
					end,
					desc = "Harpoon menu",
				},
			},
		},

		-- Obsidian
		{
			itemgroup = "+Notes",
			description = "Obsidian note management",
			icon = "󰈙",
			keymaps = {
				{ "<leader>no", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
				{ "<leader>nn", "<cmd>ObsidianNew<CR>", desc = "New note" },
				{ "<leader>nl", "<cmd>ObsidianLink<CR>", desc = "Link note" },
			},
		},
	}
end

return M
