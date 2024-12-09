--tree 
vim.keymap.set("n", "<leader>o", ":Neotree toggle<CR>", { desc = "Open NvimTree" })

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
]]


