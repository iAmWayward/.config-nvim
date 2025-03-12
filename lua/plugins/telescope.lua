return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        -- If you want to lazy load on keys:
        config = function()
            require("telescope").setup()
            vim.api.nvim_create_autocmd("User", {
                pattern = "TelescopeFindPre",
                callback = function()
                    require("config.keymaps").telescope_setup()
                end,
            })
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make", -- correct for lazy.nvim
    },
}
