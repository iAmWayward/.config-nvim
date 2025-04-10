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
    mode = {'n', 'x'},
    key = 'cp',
    cmd = '"+y',
    desc = 'Copy to system clipboard'
  },
  {
    mode = {'n', 'x'},
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

-- Telescope keymaps
M.telescope_keymaps = {
  {
    mode = 'n',
    key = '<leader>ff',
    function = require('telescope.builtin').find_files,
    desc = 'Find Files'
  },
  {
    mode = 'n',
    key = '<leader>fg',
    function = require('telescope.builtin').live_grep,
    desc = 'Live Grep'
  },
  -- ... other Telescope keymaps ...
}

-- Debugger keymaps (dap)
M.debugger_keymaps = {
  {
    mode = 'n',
    key = '<F5>',
    function = function()
      require('dap').continue()
    end,
    desc = 'Start/Continue Debugging'
  },
  {
    mode = 'n',
    key = '<F10>',
    function = function()
      require('dap').step_over()
    end,
    desc = 'Step Over'
  },
  -- ... other debugger keymaps ...
}

-- LSP keymaps (buffer-local)
M.lsp_keymaps = function(bufnr)
  local maps = {
    {
      mode = 'n',
      key = 'gd',
      function = vim.lsp.buf.definition,
      desc = 'Go to Definition',
      opts = { buffer = bufnr }
    },
    {
      mode = 'n',
      key = 'K',
      function = vim.lsp.buf.hover,
      desc = 'Hover Documentation',
      opts = { buffer = bufnr }
    },
    -- ... other LSP keymaps ...
  }
  return maps
end

return M
