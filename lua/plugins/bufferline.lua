return 
{
    {
    'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons',

        diagnostics = "nvim_lsp",
        indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'icon', --| 'underline' | 'none',
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "center",
                separator = true
            }
        },
    }
}


