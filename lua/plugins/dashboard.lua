-- return {
-- 	{
-- 		"nvimdev/dashboard-nvim",
-- 		-- event = "VimEnter",
-- 		dependencies = { "nvim-tree/nvim-web-devicons" },
-- 		opts = function()
-- 			local function generate_header()
-- 				local day = os.date("%A")
-- 				local hour = tonumber(os.date("%H"))
-- 				local greeting = hour < 12 and "Good Morning!" or hour < 18 and "Good Afternoon!" or "Good Evening!"
--
-- 				return {
-- 					greeting,
-- 					"Today is " .. day,
-- 				}
-- 			end
--
-- 			return {
-- 				theme = "hyper", --doom
-- 				disable_at_vimenter = true,
-- 				change_to_vcs_root = true,
-- 				config = {
-- 					header = generate_header(),
-- 					week_header = {
-- 						enable = true,
-- 						concat = " - Let's Code!",
-- 					},
-- 					-- disable_move = false,
-- 					shortcut = {
-- 						{
-- 							desc = " Find File",
-- 							group = "DashboardShortCut",
-- 							action = "Telescope find_files",
-- 							key = "f",
-- 						},
-- 						{
-- 							desc = " Recent Files",
-- 							group = "DashboardShortCut",
-- 							action = "Telescope oldfiles",
-- 							key = "r",
-- 						},
-- 						{
-- 							desc = " Config",
-- 							group = "DashboardShortCut",
-- 							action = "edit ~/.config/nvim/init.lua",
-- 							key = "c",
-- 						},
-- 					},
-- 					footer = { "Have a productive session!" },
-- 				},
-- 			}
-- 		end,
-- 	},
-- }

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local function generateHeader()
			local day = os.date("%A")
			local hour = tonumber(os.date("%H"))
			local greeting = hour < 12 and "Good Morning!" or hour < 18 and "Good Afternoon!" or "Good Evening!"

			return {
				greeting,
				"Today is " .. day,
			}
		end

		local quotes = require("config.phrase-of-the-day")

		-- Function to get daily quote (same quote for the entire day)
		local function getDailyQuote()
			-- Get current date as a number for seeding
			local date = os.date("*t")
			local dayOfYear = date.yday + (date.year * 365) -- Include year to ensure different quotes across years

			-- Combine all quotes into one table
			local allQuotes = {}
			for _, quote in ipairs(quotes.taoist) do
				table.insert(allQuotes, quote)
			end
			for _, quote in ipairs(quotes.buddhist) do
				table.insert(allQuotes, quote)
			end

			-- Use day-based index (deterministic for the day)
			local quoteIndex = (dayOfYear % #allQuotes) + 1
			return allQuotes[quoteIndex]
		end

		-- Get today's quote
		local dailyQuote = getDailyQuote()
		-- Format the quote for the footer
		local footerLines = {
			"",
			"💭 " .. dailyQuote.text,
			"   — " .. dailyQuote.author,
			"",
		}
		require("dashboard").setup({

			change_to_vcs_root = true,

			theme = "doom",
			config = {
				-- header = generateHeader(),
				week_header = {
					enable = true,
				},
				center = {
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Find File           ",
						desc_hl = "String",
						key = "b",
						keymap = "SPC f f",
						key_hl = "Number",
						key_format = " %s", -- remove default surrounding `[]`
						action = "lua print(2)",
					},
					{
						icon = " ",
						desc = "Find Dotfiles",
						key = "f",
						keymap = "SPC f d",
						key_format = " %s", -- remove default surrounding `[]`
						action = "lua print(3)",
					},
				},
				footer = footerLines,
				vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
