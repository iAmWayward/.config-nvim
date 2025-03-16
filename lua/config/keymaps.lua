local M = {}

-- Note: <leader> is spacebar, M is alt, C is ctrl.
-- Therefore, <leader>o translates to "hit space, then o"
-- Bindings are case-sensitive. gg and GG evoke different behavior of the same kind -- try it out.
local opts = { noremap = true, silent = true }
-- Set up base keybinds
function M.set_base()
  vim.keymap.set("n", "<leader>T", "<cmd>Themery<cr>", {
    desc = "Reveal file in Neo-tree",
    silent = true,
  })

  vim.keymap.set("n", "<Leader>nf", function()
    require("neogen").generate({ type = "func" })
  end, { noremap = true, silent = true, desc = "Generate function doc" })

  -- nvim Telescope Keybinds (file/text finder)
  vim.keymap.set("n", "|", "<cmd>Neotree reveal<cr>", {
    desc = "Reveal file in Neo-tree",
    silent = true,
  })

  vim.keymap.set("n", "rf", "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", {
    desc = "Reveal file in floating Neo-tree (force cwd)",
    silent = true,
  })

  vim.keymap.set("n", "<leader>B", "<cmd>Neotree toggle show buffers right<cr>", {
    desc = "Toggle buffer list in Neo-tree (right)",
    silent = true,
  })

  vim.keymap.set("n", "<leader>s", "<cmd>Neotree float git_status<cr>", {
    desc = "Open git status in floating Neo-tree",
    silent = true,
  })

  vim.keymap.set("n", "<leader>o", "<cmd>Neotree toggle<cr>", {
    desc = "Toggle Neo-tree (filesystem)",
    silent = true,
  })

  --[[ Instead of tabs, this nvim config is setup to open "buffers" by default. So this is how you change vim tabs. ]]
  --[[ bufferline plugin keybinds ]]
  vim.keymap.set('n', '<M-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
  vim.keymap.set('n', '<M-PageDown>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
  vim.keymap.set('n', '<leader>q', '<cmd>bp|bd #<CR>', { desc = 'Close current buffer', silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
  --[[ vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer', silent = true }) ]]
  --[[ vim.keymap.set("n", "<leader>", "toggle_preview", { desc = "test one" }) ]]
end

function M.telescope_setup()
  -- nvim Telescope Keybinds (file/text finder)
  vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })
  vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
  vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find Buffers" })
  vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })
end

function M.get_tree_mappings()
  return {
    ["<CR>"] = "open",
    ["p"] = "toggle_preview",
    ["<leader><space>"] = "toggle_preview",
    ["l"] = "open",
    ["C"] = "close_node",
    ["t"] = "open_tab_drop",
    ["T"] = "open_tab_stay",
  }
end

function M.debugger_setup(dap)
  -- Use the passed dap instance instead of requiring it
  vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
  vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
  vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
  vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
  vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<Leader>B", function()
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
  end, { desc = "Set Conditional Breakpoint" })
  vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
  vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
end

-- Special setup required for LSP bindings.
function M.mason_setup(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps (buffer-local)
  if bufnr then
    map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
    map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    map('n', 'gr', vim.lsp.buf.references, 'Find References')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
    map('n', '<leader>sh', vim.lsp.buf.signature_help, 'Signature Help')
    map('n', '[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Next Diagnostic')
    map('n', '<leader>e', vim.diagnostic.open_float, 'Show Diagnostic')
    map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format Code')
  end
end

return M
