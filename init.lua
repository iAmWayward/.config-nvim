--tree
vim.keymap.set("n", "<leader>o", ":Neotree toggle current reveal_force_cwd<CR>", { desc = "Open NvimTree" })

-- telecsope


-- Set leader keys

require("config.lazy")

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find Buffers" })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })

vim.cmd [[
  colorscheme tokyonight-night
  hi Normal guibg=NONE
  hi SignColumn guibg=NONE
  hi FloatBorder guibg=NONE
  hi NormalFloat guibg=NONE
  hi StatusLine guibg=NONE
  hi StatusLineNC guibg=NONE
  hi BufferLine guibg=NONE
  hi BufferLineFill guibg=NONE
  hi BufferLineCloseButton guibg=NONE
  hi BufferLineCloseButtonVisible guibg=NONE
  hi BufferLineCloseButtonSelected guibg=NONE
  hi BufferLineBufferSelected guibg=NONE
  hi BufferLineBufferVisible guibg=NONE
  hi BufferLineBuffer guibg=NONE
  hi BufferLineSeparator guibg=NONE
  hi BufferLineSeparatorSelected guibg=NONE
  hi BufferLineTab guibg=NONE
  hi BufferLineTabSelected guibg=NONE
  hi BufferLineTabVisible guibg=NONE
  hi BufferLineTabClose guibg=NONE
  hi WinBar guibg=NONE
  hi WinBarNC guibg=NONE
  ]]

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
