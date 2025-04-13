local M = {}
local wk = require("which-key")

-- Note: <leader> is spacebar, M is alt, C is ctrl.
-- Therefore, <leader>o translates to "hit space, then o"
-- Bindings are case-sensitive. gg and GG evoke different behavior of the same kind -- try it out.
local opts = { noremap = true, silent = true }
-- Set up base keybinds
function M.set_base()
  vim.keymap.set("n", "<leader>T", "<cmd>Themery<cr>", {
    desc = "Change theme",
    silent = true,
  })

  -- Copy/paste from system clipboard
  vim.keymap.set({ 'n', 'x' }, '<leader>cp', '"+y', { desc = "Copy to system clipboard", })
  vim.keymap.set({ 'n', 'x' }, '<leader>cv', '"+p', { desc = "Paste from system clipboard", })

  -- NoNeckPain Plugin Bindings --
  vim.keymap.set("n", "<leader>nnp", "<cmd>NoNeckPain<cr>", {
    desc = "Toggle No Neck Pain",
    silent = true,
  })

  vim.keymap.set("n", "<leader>nwu", "<cmd>NoNeckPainWidthUp<cr>", {
    desc = "Increase No Neck Pain Width",
    silent = true,
  })

  vim.keymap.set("n", "<leader>nwd", "<cmd>NoNeckPainWidthDown<cr>", {
    desc = "Decrease No Neck Pain Width",
    silent = true,
  })

  vim.keymap.set("n", "<leader>nns", "<cmd>NoNeckPainScratchPad<cr>", {
    desc = "Toggle No Neck Pain Scratchpad",
    silent = true,
  })

  vim.keymap.set("n", "<Leader>nf", function()
    require("neogen").generate({ type = "func" })
  end, { noremap = true, silent = true, desc = "Generate function doc" })

  vim.keymap.set("n", "<Leader>nc", function()
    require("neogen").generate({ type = "class" })
  end, { noremap = true, silent = true, desc = "Generate class doc" })

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
  vim.keymap.set({ 'n', 'i' }, '<M-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
  vim.keymap.set({ 'n', 'i' }, '<M-PageDown>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
  vim.keymap.set('n', '<leader>q', '<cmd>bp|bd #<CR>', { desc = 'Close current buffer', silent = true })
  vim.api.nvim_set_keymap("n", "<Leader>ng", ":lua require('neogen').generate()<CR>", opts)
end

function M.telescope_setup()
  wk.register({
    -- nvim Telescope Keybinds (file/text finder)
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" }),
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" }),
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find Buffers" }),
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })
  })
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
  wk.register({
    -- Use the passed dap instance instead of requiring it
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" }),
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" }),
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" }),
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" }),
    vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" }),
    vim.keymap.set("n", "<Leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Conditional Breakpoint" }),
    vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" }),
    vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" }),
  })
end

function M.hover_setup()
  wk.register({
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" }),
    vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" }),
    vim.keymap.set("n", "<C-p>", function()
      require("hover").hover_switch("previous")
    end, { desc = "hover.nvim (previous source)" }),

    vim.keymap.set("n", "<C-n>", function()
      require("hover").hover_switch("previous")
    end, { desc = "hover.nvim (next source)" }),

    -- Mouse support
    --[[   vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" }) ]]
    --[[   vim.o.mousemoveevent = true ]]
  })
end

-- Dropbar Plugin --
function M.dropbar_setup()
  local dropbar_api = require('dropbar.api')
  vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
  vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
  vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
end

-- Special setup required for LSP bindings.
function M.mason_setup(bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- LSP keymaps (buffer-local)
  if bufnr then
    -- Enhanced LSP Saga keymaps
    map('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', 'LSP Finder')
    map('n', 'K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
    map('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
    map('n', 'gD', '<cmd>vim.lsp.buf.definition<CR>', 'Go to Definition')
    map('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code Action')
    map('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', 'Rename Symbol')
    map('n', '<leader>O', '<cmd>Lspsaga outline<CR>', 'Toggle Outline')

    -- Preserved native LSP functionality
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
    map('n', 'gr', vim.lsp.buf.references, 'Find References')
    map('n', '<leader>sh', vim.lsp.buf.signature_help, 'Signature Help')

    -- Enhanced diagnostics with Saga
    map('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', 'Previous Diagnostic')
    map('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', 'Next Diagnostic')
    map('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', 'Show Line Diagnostic')

    -- Optional: Native fallbacks
    map('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, 'Format Code')
    map('n', '<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace Symbol')
  end
end

return M
