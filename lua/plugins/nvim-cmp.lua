return {
  {
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

      -- Rest of your cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "codecompanion" }
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
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

      -- Cmdline setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
        {
          "declancm/cinnamon.nvim",
          version = "*", -- use latest release
          opts = {
            keymaps = {
              basic = true,
              extra = true,
            },

            -- Only scroll the window
            options = {
              mode = "window",
              easing = "linear",
              duration_multiplier = .75,
            },
          },
          -- change default options here
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
