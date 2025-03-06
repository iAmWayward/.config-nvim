return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = {  -- Note: options table, not opts
                diagnostics = "nvim_lsp",
                indicator = {
                    icon = '▎',
                    style = 'icon',
                },
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true
                    }
                },
            }
        })
        vim.keymap.set('n', '<C-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
        vim.keymap.set('n', '<C-PageDown>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
        vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer', silent = true })
    end,
}
