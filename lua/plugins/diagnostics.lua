return {
  -- Diagnostics and Outline panels
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
        position = { 0, 4 }, -- -2
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
  -- {
  --   "rachartier/tiny-inline-diagnostic.nvim",
  --   event = "VeryLazy", -- Or `LspAttach`
  --   priority = 1000,    -- needs to be loaded in first
  --   config = function()
  --     require('tiny-inline-diagnostic').setup({
  --       -- Style preset for diagnostic messages
  --       -- Available options:
  --       -- "modern", "classic", "minimal", "powerline",
  --       -- "ghost", "simple", "nonerdfont", "amongus"
  --       preset = "powerline",
  --
  --       transparent_bg = false,         -- Set the background of the diagnostic to transparent
  --       transparent_cursorline = false, -- Set the background of the cursorline to transparent (only one the first diagnostic)
  --       options = {
  --         -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
  --         show_source = {
  --           enabled = false,
  --           if_many = false,
  --         },
  --
  --         -- Use icons defined in the diagnostic configuration
  --         use_icons_from_diagnostic = true,
  --       }
  --     })
  --     vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
  --   end
  -- },


}
