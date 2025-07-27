return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "hiphish/rainbow-delimiters.nvim",
    },  
    build = ":TSUpdate",
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true }, 
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      require('rainbow-delimiters.setup').setup()
    end,
  },
}

