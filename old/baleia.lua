return {
  "m00qek/baleia.nvim",
  version = "*",
  config = function()
    local baleia = require("baleia").setup({
      -- ... (your existing color config remains the same)
    })

    vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        -- Check if the file contains ANSI escape sequences
        if table.concat(lines, "\n"):match("\27%[%d+m") then
          -- Apply Baleia directly to the original buffer
          baleia.once(bufnr)
        end
      end,
    })
  end,
}
