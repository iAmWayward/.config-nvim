return {
  {
    "starbaser/prism.nvim",
    event = "VeryLazy",
    opts = {
      registrations = {
        { target = "NormalFloat",      opacity = 0.85, priority = 30 },
        { target = "FloatBorder",      opacity = 0.85, priority = 30 },
        { target = "TelescopeNormal",  opacity = 0.85, priority = 20 },
        { target = "NoicePopupmenu",   opacity = 0.85, priority = 20 },

        -- Doxygen comment hover (pretty_hover renders through
        -- vim.lsp.util.open_floating_preview, so its window/border use the
        -- NormalFloat / FloatBorder groups registered above).

        -- Neo-tree sidebar + floating windows (e.g. `Neotree float git_status`)
        { target = "NeoTreeNormal",      opacity = 0.85, priority = 20 },
        { target = "NeoTreeNormalNC",    opacity = 0.85, priority = 20 },
        { target = "NeoTreeFloatNormal", opacity = 0.85, priority = 20 },
        { target = "NeoTreeFloatBorder", opacity = 0.85, priority = 20 },
        { target = "NeoTreeFloatTitle",  opacity = 0.85, priority = 20 },
        { target = "NeoTreeEndOfBuffer", opacity = 0.85, priority = 20 },
      },
      debounce_ms = 50,
    },
  },
}
