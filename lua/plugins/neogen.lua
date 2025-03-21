return {
  {
    "hat0uma/doxygen-previewer.nvim",
    opts = {},
    dependencies = { "hat0uma/prelive.nvim" },
    update_on_save = true,
    cmd = {
      "DoxygenOpen",
      "DoxygenUpdate",
      "DoxygenStop",
      "DoxygenLog",
      "DoxygenTempDoxyfileOpen"
    },
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        input_after_comment = true,
        --[[     languages = { ]]
        --[[       cpp = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "doxygen" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       c = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "doxygen" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       python = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "google_docstrings" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       lua = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "emmylua" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       javascript = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "JSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       javascriptreact = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "JSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       typescript = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "TSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       typescriptreact = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "TSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       tsx = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "TSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[       jsx = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "JSDoc" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[]]
        --[[       sh = { ]]
        --[[         template = { ]]
        --[[           annotation_convention = "google_bash" ]]
        --[[         } ]]
        --[[       }, ]]
        --[[     } ]]
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  }
}
