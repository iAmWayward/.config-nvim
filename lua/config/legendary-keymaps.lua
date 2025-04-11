local M = {}

-- Base keymaps (no plugin dependencies)
M.base_keymaps = {
  -- Theme switcher
  {
    mode = 'n',
    key = '<leader>T',
    cmd = '<cmd>Themery<cr>',
    desc = 'Change theme',
    opts = { noremap = true, silent = true }
  },

  -- Clipboard operations
  {
    mode = { 'n', 'x' },
    key = 'cp',
    cmd = '"+y',
    desc = 'Copy to system clipboard'
  },
  {
    mode = { 'n', 'x' },
    key = 'cv',
    cmd = '"+p',
    desc = 'Paste from system clipboard'
  },

  -- NoNeckPain keymaps
  {
    mode = 'n',
    key = '<leader>nnp',
    cmd = '<cmd>NoNeckPain<cr>',
    desc = 'Toggle No Neck Pain'
  },
  -- ... other NoNeckPain keymaps ...
}

return M
