return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",
        "windwp/nvim-autopairs",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- Initialize autopairs FIRST
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        require("nvim-autopairs").setup({})
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        -- Main cmp setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Enter>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "codecompanion" }
                },
                {
                    { name = "buffer" },
                    { name = "path" },
                }
            ),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    show_labeldetails = true,
                }),
            },
            experimental = {
                ghost_text = true,
            },
        })

        -- Cmdline setup for search ('/') 
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" }
            }
        })

        -- Cmdline setup for command line (':')
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                { { name = "path" } },
                { { name = "cmdline" } }
            )
        })

        -- Load snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
