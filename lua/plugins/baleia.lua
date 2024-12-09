return {
  "m00qek/baleia.nvim",
  version = "*",
  config = function()
    local baleia = require("baleia").setup({
      colors = {
        black   = "#1c1c1c",
        red     = "#ff5f5f",
        green   = "#5fff87",
        yellow  = "#ffd75f",
        blue    = "#5f87ff",
        magenta = "#d75fff",
        cyan    = "#5fd7ff",
        white   = "#eeeeee",
        bright_black   = "#4e4e4e",
        bright_red     = "#ff6c6b",
        bright_green   = "#98be65",
        bright_yellow  = "#ecbe7b",
        bright_blue    = "#51afef",
        bright_magenta = "#c678dd",
        bright_cyan    = "#46d9ff",
        bright_white   = "#dfdfdf",
      },
    })

    vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        -- Check if the file contains ANSI escape sequences
        if table.concat(lines, "\n"):match("\27%[%d+m") then
          -- Wrap buffer number in a Neovim buffer object
          local buffer = vim.api.nvim_create_buf(false, false)
          vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)

          baleia.once(buffer) -- Apply Baleia to the buffer object
        end
      end,
    })
  end,
}

