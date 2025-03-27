return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  --[[ 'nvim-neo-tree/neo-tree.nvim', ]]
  config = function()
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
        -- highlights = get_bufferline_highlights(),
      },
    })
  end,
}
