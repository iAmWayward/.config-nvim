--tree


require("config.lazy")
require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()


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
