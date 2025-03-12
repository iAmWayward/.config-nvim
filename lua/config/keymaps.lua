local M = {}

-- Note: <leader> is spacebar, M is alt, C is ctrl.
-- Therefore, <leader>o translates to "hit space, then o"
-- Bindings are case-sensitive. gg and GG evoke different behavior of the same kind -- try it out.

-- Set up base keybinds
function M.set_base()
    -- nvim Telescope Keybinds (file/text finder)
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find Buffers" })
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })

    -- File Tree Keybindings
    vim.keymap.set("n", "<leader>o", ":Neotree toggle current reveal_force_cwd<CR>", { desc = "Open NvimTree" })

    vim.keymap.set("n", "<leader><Space>", "<cmd>Neotree toggle current<cr>", {
        desc = "Toggle Neo-tree (current)",
        silent = true,
    })


    vim.keymap.set("n", "|", "<cmd>Neotree reveal<cr>", {
        desc = "Reveal file in Neo-tree",
        silent = true,
    })

    vim.keymap.set("n", "rf", "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", {
        desc = "Reveal file in floating Neo-tree (force cwd)",
        silent = true,
    })

    vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle show buffers right<cr>", {
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
    --[[ vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer', silent = true }) ]]
end

function M.telescope_setup()
    -- nvim Telescope Keybinds (file/text finder)
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Find Files" })
    vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Live Grep" })
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Find Buffers" })
    vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = "Help Tags" })
end

function M.tree_setup(bufnr)
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- Define Neo-tree specific mappings
    map("n", "<CR>", "open", "Open File")
    map("n", "<Space>", "toggle_preview", "Toggle Preview")
    map("n", "l", "open", "Expand Folder")
    map("n", "C", "close_node", "Close Folder")
    map("n", "t", "open_tab_drop", "Open in Tab (Drop)")
    map("n", "T", "open_tab_stay", "Open in Tab (Stay)")
end

function M.debugger_setup()
    vim.keymap.set('n', '<M-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
    vim.keymap.set('n', '<M-PageDown>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
    vim.keymap.set('n', '<leader>q', '<cmd>bp|bd #<CR>', { desc = 'Close current buffer', silent = true })
    --[[ vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer', silent = true }) ]]
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
