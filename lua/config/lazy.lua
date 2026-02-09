require("config.options")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local lsp_maps = require("config.keymaps").lsp_mappings(bufnr)
    require("legendary").keymaps(lsp_maps)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Completion
    -- vim.lsp.completion.enable(nil, args.data.client_id, bufnr, { autotrigger = true })
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- Highlight under cursor (only if the client supports it)
    if client.server_capabilities.documentHighlightProvider then
      local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })

      -- Highlight references when the cursor is held
      vim.api.nvim_create_autocmd("CursorHold", {
        group = highlight_group,
        buffer = bufnr,
        callback = function()
          -- Silently try to highlight, don't show errors/notifications
          pcall(vim.lsp.buf.document_highlight)
        end,
      })

      -- Clear highlights when the cursor moves
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = highlight_group,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.clear_references()
        end,
      })
    end
  end,
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },

  install = { colorscheme = { "tokyonight" } }, -- colorscheme that will be used when installing plugins.
  checker = { enabled = true },                -- automatically check for plugin updates
})
