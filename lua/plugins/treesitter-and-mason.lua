return {
  -- Mason LSP bridge
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "basedpyright" },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  -- Formatters via none-ls + Mason
  {
    "jay-babu/mason-null-ls.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = { "prettierd", "stylua", "shfmt", "fixjson", "yamlfix" },
        automatic_installation = true,
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "rrethy/nvim-treesitter-endwise",
      {
        "HiPhish/rainbow-delimiters.nvim",
        config = function()
          require("rainbow-delimiters.setup").setup({
            condition = function(buf)
              local ok, parser = pcall(vim.treesitter.get_parser, buf)
              return ok and parser ~= nil
            end,
          })
        end,
      },
      "windwp/nvim-autopairs",
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        opts = { enable_autocmd = false },
      },
      {
        "numToStr/Comment.nvim",
        config = function()
          require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
          })
        end,
      },
      "windwp/nvim-ts-autotag",
    },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      fold = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-w>",
          scope_incremental = "<CR>",
          node_incremental = "grn",
          node_decremental = "grm",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
          },
        },
      },
    },
  },

  -- Dev containers
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = { "akinsho/toggleterm.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("devcontainer").setup({
        nvim_install_as_root = false,
        generate_commands = true,
        autocommands = { init = false, clean = false, update = false },
        log_level = "info",
        disable_recursive_config_search = false,
        cache_images = true,
        attach_mounts = {
          neovim_config = { enabled = false, options = { "readonly" } },
          neovim_data    = { enabled = false, options = {} },
          neovim_state   = { enabled = false, options = {} },
        },
        always_mount = {},
        container_runtime = nil,
        compose_command = nil,
        backup_compose_command = nil,
      })
    end,
  },
}
