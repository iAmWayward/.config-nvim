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
    end,
}
