-- config/keymaps.lua
local M = {}

M.items = {
  -- Base keymaps
  {
    mode = 'n',
    '<leader>hd',
    function()
      local cursor_highlight = vim.fn.synIDattr(vim.fn.synID(vim.fn.line("."), vim.fn.col("."), 1), "name")
      print("Highlight group under cursor: " .. cursor_highlight)
    end,
    description = 'Show highlight group under cursor'
  },
  { mode = 'n',          '<leader>T',    '<cmd>Themery<cr>',                                            description = 'Change theme' },
  { mode = { 'n', 'x' }, '<leader>cp',   '"+y',                                                         description = 'Copy to system clipboard' },
  { mode = { 'n', 'x' }, '<leader>cv',   '"+p',                                                         description = 'Paste from system clipboard' },

  -- NoNeckPain
  { mode = 'n',          '<leader>nnp',  '<cmd>NoNeckPain<cr>',                                         description = 'Toggle No Neck Pain' },
  { mode = 'n',          '<leader>nwu',  '<cmd>NoNeckPainWidthUp<cr>',                                  description = 'Increase width' },
  { mode = 'n',          '<leader>nwd',  '<cmd>NoNeckPainWidthDown<cr>',                                description = 'Decrease width' },
  { mode = 'n',          '<leader>nns',  '<cmd>NoNeckPainScratchPad<cr>',                               description = 'Toggle scratchpad' },

  -- Neogen
  { mode = 'n',          '<leader>ng',   function() require('neogen').generate() end,                   description = 'Generate docs' },
  { mode = 'n',          '<leader>nf',   function() require('neogen').generate({ type = 'func' }) end,  description = 'Function doc' },
  { mode = 'n',          '<leader>nc',   function() require('neogen').generate({ type = 'class' }) end, description = 'Class doc' },

  -- Neo-tree
  { mode = 'n',          '|',            '<cmd>Neotree reveal<cr>',                                     description = 'Reveal file in Neo-tree' },
  { mode = 'n',          'rf',           '<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>', description = 'Reveal in float' },
  { mode = 'n',          '<leader>B',    '<cmd>Neotree toggle show buffers right<cr>',                  description = 'Buffer list' },
  { mode = 'n',          '<leader>s',    '<cmd>Neotree float git_status<cr>',                           description = 'Git status' },
  { mode = 'n',          '<leader>o',    '<cmd>Neotree toggle<cr>',                                     description = 'Toggle Neo-tree' },

  -- Bufferline
  { mode = { 'n', 'i' }, '<M-PageUp>',   '<cmd>BufferLineCyclePrev<CR>',                                description = 'Previous buffer' },
  { mode = { 'n', 'i' }, '<M-PageDown>', '<cmd>BufferLineCycleNext<CR>',                                description = 'Next buffer' },
  { mode = 'n',          '<leader>q',    '<cmd>bp|bd #<CR>',                                            description = 'Close buffer' },

  -- Telescope
  { mode = 'n',          '<leader>ff',   require('telescope.builtin').find_files,                       description = 'Find Files' },
  { mode = 'n',          '<leader>fg',   require('telescope.builtin').live_grep,                        description = 'Live Grep' },
  { mode = 'n',          '<leader>fb',   require('telescope.builtin').buffers,                          description = 'Find Buffers' },
  { mode = 'n',          '<leader>fh',   require('telescope.builtin').help_tags,                        description = 'Help Tags' },
}

M.lsp_mappings = function(bufnr)
  return {
    { mode = 'n', 'gh',         '<cmd>Lspsaga lsp_finder<CR>',                      description = 'LSP Finder',           buffer = bufnr },
    { mode = 'n', 'K',          '<cmd>Lspsaga hover_doc<CR>',                       description = 'Hover Documentation',  buffer = bufnr },
    { mode = 'n', 'gd',         '<cmd>Lspsaga peek_definition<CR>',                 description = 'Peek Definition',      buffer = bufnr },
    { mode = 'n', 'gD',         vim.lsp.buf.definition,                             description = 'Go to Definition',     buffer = bufnr },
    { mode = 'n', '<leader>ca', '<cmd>Lspsaga code_action<CR>',                     description = 'Code Action',          buffer = bufnr },
    { mode = 'n', '<leader>rn', '<cmd>Lspsaga rename<CR>',                          description = 'Rename Symbol',        buffer = bufnr },
    { mode = 'n', '<leader>O',  '<cmd>Lspsaga outline<CR>',                         description = 'Toggle Outline',       buffer = bufnr },
    { mode = 'n', 'gi',         vim.lsp.buf.implementation,                         description = 'Go to Implementation', buffer = bufnr },
    { mode = 'n', 'gr',         vim.lsp.buf.references,                             description = 'Find References',      buffer = bufnr },
    { mode = 'n', '<leader>sh', vim.lsp.buf.signature_help,                         description = 'Signature Help',       buffer = bufnr },
    { mode = 'n', '[d',         '<cmd>Lspsaga diagnostic_jump_prev<CR>',            description = 'Previous Diagnostic',  buffer = bufnr },
    { mode = 'n', ']d',         '<cmd>Lspsaga diagnostic_jump_next<CR>',            description = 'Next Diagnostic',      buffer = bufnr },
    { mode = 'n', '<leader>e',  '<cmd>Lspsaga show_line_diagnostics<CR>',           description = 'Show Line Diagnostic', buffer = bufnr },
    { mode = 'n', '<leader>F',  function() vim.lsp.buf.format { async = true } end, description = 'Format Code',          buffer = bufnr },
    { mode = 'n', '<leader>ws', vim.lsp.buf.workspace_symbol,                       description = 'Workspace Symbol',     buffer = bufnr },
  }
end
M.dap_mappings = function(dap)
  return {
    { mode = 'n', '<F5>',      dap.continue,          description = 'Start/Continue Debugging' },
    { mode = 'n', '<F10>',     dap.step_over,         description = 'Step Over' },
    { mode = 'n', '<F11>',     dap.step_into,         description = 'Step Into' },
    { mode = 'n', '<F12>',     dap.step_out,          description = 'Step Out' },
    { mode = 'n', '<Leader>b', dap.toggle_breakpoint, description = 'Toggle Breakpoint' },
    {
      mode = 'n',
      '<Leader>cb',
      function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      description = 'Conditional Breakpoint'
    },
    { mode = 'n', '<Leader>dr', dap.repl.open, description = 'Open REPL' },
    { mode = 'n', '<Leader>dl', dap.run_last,  description = 'Run Last Session' },
  }
end

return M
