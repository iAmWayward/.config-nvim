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
              vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })
              ]],
        },
        {
          name = "Gruvbox Dark",
          colorscheme = "gruvbox",
          before = [[ vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  ]],
          after = [[ vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
          ]],
        },
        {
          name = "Catppuccin",
          colorscheme = "catppuccin",
          opts = { transparent_background = true }, -- This should be fine
          before = [[
            require("catppuccin").setup({
              transparent_background = true,
            })
          ]],
          after = [[vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })]],
        },
        {
          name = "Ayu",
          colorscheme = "ayu",
          before = [[
            vim.g.ayu_mirage = true
          ]],
          after = [[
              vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
          ]],
        },
      },
      livePreview = true,
      globalBefore = [[              vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })]],
      globalAfter = [[              vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
              vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })
  ]],
    })
  end
}
