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
        },
        {
          name = "Gruvbox Dark",
          colorscheme = "gruvbox",
        },
        {
          name = "Catppuccin",
          colorscheme = "catppuccin",
          opts = { transparent_background = true },
          before = [[
            require("catppuccin").setup({
              transparent_background = true,
            })
          ]],
        },
         {
          name = "Leaf",
          colorscheme = "leaf",
        },
        -- {
        --   name = "Noctis",
        --   colorscheme = "noctis",
        -- },
         {
          name = "Neo Solarized",
          colorscheme = "NeoSolarized",
        },
        {
          name = "Ayu",
          colorscheme = "ayu",
          before = [[ vim.g.ayu_mirage = true ]],
        },
      },
      livePreview = true,
      globalBefore = [[ vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" }) ]],
      globalAfter = [[ vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" }) ]],
    })
  end
}
