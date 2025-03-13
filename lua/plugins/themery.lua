return {
  "zaldih/themery.nvim",
  lazy = false,
  config = function()
    require("themery").setup({
      themes = {
        {
          name = "Tokyo Night",
          colorscheme = "tokyonight",
          before = [[
              vim.g.tokyonight_style = "night"
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_dark_sidebar = false
    vim.g.tokyonight_dark_float = false
              ]],
          after = [[
              vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
          ]],
        },
        {
          name = "Gruvbox Dark",
          colorscheme = "gruvbox",
          before = [[
  ]],
          after = [[
          ]],
        },
        {
          name = "Catppuccin",
          colorscheme = "catppuccin",
          opts = { transparent_background = true }, -- This should be fine
          before = [[
            vim.g.catppuccin_transparent = true
          ]],
        },
        {
          name = "Ayu",
          colorscheme = "ayu",
          before = [[
            vim.g.ayu_mirage = true
          ]],
        },
      },
      livePreview = true,
      globalBefore = [[
        -- Apply explicit transparency settings for bufferline
        require("bufferline").setup({
          highlights = {
            fill = { bg = "NONE" },
            background = { bg = "NONE" },
            buffer = { bg = "NONE" },
            buffer_visible = { bg = "NONE" },
            buffer_selected = { bg = "NONE" },
          }
        })

        -- Apply explicit transparency settings for lualine
        require("lualine").setup({
          options = {
            theme = "auto",
            component_separators = "",
            section_separators = "",
          },
          sections = {
            lualine_a = { { "mode", bg = "NONE" } },
            lualine_b = { { "branch", bg = "NONE" }, { "diff", bg = "NONE" } },
            lualine_c = { { "filename", bg = "NONE" } },
            lualine_x = { { "encoding", bg = "NONE" }, { "fileformat", bg = "NONE" }, { "filetype", bg = "NONE" } },
            lualine_y = { { "progress", bg = "NONE" } },
            lualine_z = { { "location", bg = "NONE" } },
          }
        })
      ]],
      globalAfter = [[
  ]],
    })
  end
}
