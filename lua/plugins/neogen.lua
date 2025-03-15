return {
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
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
              annotation_convention = "JSDoc"
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "JSDoc"
            }
          },
          typescript = {
            template = {
              annotation_convention = "TSDoc"
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
  }
}
