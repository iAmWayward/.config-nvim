return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  --[[ 'nvim-neo-tree/neo-tree.nvim', ]]
  config = function()
    local function get_bufferline_highlights()
      local colorscheme = vim.g.colors_name or ""
      if colorscheme:find("catppuccin") then
        return require("catppuccin.groups.integrations.bufferline").get()
      end
      -- Add checks for other themes here if they provide bufferline integrations

      -- Fallback styling if no integration is found
      return {
        background = { bg = "NONE" },
        buffer_selected = { bold = true, italic = false },
        buffer_visible = { bg = "NONE" },
        fill = { bg = "NONE" },
        separator = { bg = "NONE" },
        separator_selected = { bg = "NONE" },
        separator_visible = { bg = "NONE" },
        indicator_selected = { bg = "NONE" },
        modified = { bg = "NONE" },
        modified_selected = { bg = "NONE" },
        modified_visible = { bg = "NONE" },
      }
    end

    -- Initial setup
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        indicator = {
          icon = '▎',
          style = 'icon',
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
        highlights = get_bufferline_highlights(),
      },
    })

    -- Auto-update bufferline when colorscheme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        require("bufferline").setup({ options = { highlights = get_bufferline_highlights() } })
      end,
    })
  end,
}
