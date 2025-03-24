-- init.lua
require("config.lazy")
require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()

vim.defer_fn(function()
  vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
end, 100)

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
vim.cmd("highlight StatusLineNC guibg=NONE ctermbg=NONE")

vim.api.nvim_set_hl(0, "lualine_c_normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "lualine_b_normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "lualine_a_normal", { bg = "NONE" })

vim.api.nvim_set_option("clipboard", "unnamed")
