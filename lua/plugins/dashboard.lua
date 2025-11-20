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
    local footerLines = require("Neoquotes.commands").QuoteOfTheDay()
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
            desc = " Code",
            group = "DashboardShortCut",
            action = "edit ~/Code",
            key = "C",
          },
          {
            desc = "  Config",
            group = "DashboardShortCut",
            action = "edit ~/.config/nvim/",
            key = "c",
          },
          {
            desc = "  Notes",
            group = "Obsidian",
            action = "edit ~/Documents/Obsidian Vault/",
            key = "n",
          },
          {
            desc = "󱓧 Today's Note",
            group = "Obsidian",
            action = "ObsidianDailies",
            key = "m",
          },
          {
            desc = "󱓧 Projects",
            group = "Projects",
            action = "NeovimProjectHistory",
            key = "p",
          },
        },
        footer = footerLines,
        vertical_center = false, -- Center the Dashboard on the vertical (from top to bottom)
      },
    })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
}
