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
        languages = {
          cpp = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          c = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          },
          lua = {
            template = {
              annotation_convention = "emmylua"
            }
          },
          javascript = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          typescriptreact = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          tsx = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          jsx = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          sh = {
            template = {
              annotation_convention = "google_bash"
            }
          },
        }
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<Leader>ng", "<cmd>Neogen<CR>", desc = "Generate documentation" },
      { "<Leader>ngc", "<cmd>Neogen<CR>", desc = "Generate documentation" },
    },
  }
}
