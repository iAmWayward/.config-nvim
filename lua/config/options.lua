vim.g.material_style = "deep ocean"
vim.opt.updatetime = 200 --300
vim.o.winborder = "rounded"
vim.opt.confirm = true   -- Ask if save is desired if :q from an unsaved buffer
-- vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true })
-- vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true })
-- vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true })

vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Updated for 0.11

-- vim.opt_local.conceallevel = 2
vim.o.conceallevel = 2

vim.o.signcolumn = "yes"
vim.o.number = true
vim.opt.statuscolumn = [[%=%l %s]]
-- vim.cmd.set = "termguicolors"
vim.opt.termguicolors = true
vim.o.shell = "fish"

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2      -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2   -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2  -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
--
vim.opt.splitbelow = true -- New splits open below
vim.opt.splitright = false
-- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

vim.diagnostic.config({
  underline = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },

  -- signs = true,
  update_in_insert = true,
  severity_sort = true,
})
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- vim.o.completeopt = "menu,menuone,noinsert,fuzzy"
vim.g.copilot_no_tab_map = true
--
-- vim.opt.linebreak = true
