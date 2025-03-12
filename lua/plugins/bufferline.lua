return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
        require("bufferline").setup({
            options = { -- Note: options table, not opts
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
                highlights = {
                    background = {
                        bg = "NONE", -- This removes the background
                    },
                    buffer_selected = {
                        bold = true,
                        italic = false,
                    },
                    buffer_visible = {
                        bg = "NONE", -- This removes background for visible but not selected buffers
                    },
                    fill = {
                        bg = "NONE"
                    },
                    separator = {
                        bg = "NONE",
                    },
                    separator_selected = {
                        bg = "NONE",
                    },
                    separator_visible = {
                        bg = "NONE",
                    },
                    indicator_selected = {
                        bg = "NONE",
                    },
                    modified = {
                        bg = "NONE",
                    },
                    modified_selected = {
                        bg = "NONE",
                    },
                    modified_visible = {
                        bg = "NONE",
                    },
                },
            },
        })
        vim.keymap.set('n', '<M-PageUp>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer', silent = true })
        vim.keymap.set('n', '<M-PageDown>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer', silent = true })
        vim.keymap.set('n', '<leader>q', '<cmd>bp|bd #<CR>', { desc = 'Close current buffer', silent = true })
        --[[ vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>', { desc = 'Close current buffer', silent = true }) ]]
    end,
}
