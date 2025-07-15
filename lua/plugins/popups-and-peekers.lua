return {
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      ---@param bufnr integer
      ---@param filetype string
      ---@param buftype string
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      -- close_fold_kinds_for_ft
      -- close_fold_kinds = { "imports" },
      close_fold_kinds_for_ft = {
        description = [[After the buffer is displayed (opened for the first time), close the
                    folds whose range with `kind` field is included in this option. For now,
                    'lsp' provider's standardized kinds are 'comment', 'imports' and 'region',
                    and the 'treesitter' provider exposes the underlying node types.
                    This option is a table with filetype as key and fold kinds as value. Use a
                    default value if value of filetype is absent.
                    Run `UfoInspect` for details if your provider has extended the kinds.]],
        default = { default = {} },
      },
    },
  },

}
