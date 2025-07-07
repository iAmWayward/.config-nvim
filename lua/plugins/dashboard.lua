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

    -- Get today's quote
    local footerLines = require("quotes.commands").QuoteOfTheDay()
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
            desc = " Find File",
            group = "DashboardShortCut",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = "  Recent Files",
            group = "DashboardShortCut",
            action = "Telescope oldfiles",
            key = "r",
          },
          {
            desc = "  Config",
            group = "DashboardShortCut",
            action = "edit ~/.config/nvim/",
            key = "c",
          },
          {
            desc = "  Notes",
            group = "DashboardShortCut",
            action = "edit ~/Documents/Notes/",
            key = "n",
          },
        },
        footer = footerLines,
        vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}

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
