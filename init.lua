-- init.lua

require("config.lazy")
require("config.keymaps").set_base()
require("config.keymaps").mason_setup()
require("config.keymaps").telescope_setup()

--[[]]

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Set transparent backgrounds for UI elements
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    -- BufferLine highlights
    vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineTab", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineTabClose", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineCloseButton", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineSeparator", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineSeparatorVisible", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { bg = "NONE" })
  end,
})
