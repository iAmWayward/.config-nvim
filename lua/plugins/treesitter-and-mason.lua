
-- return {
--   -- Mason + LSP
-- {
--     "mason-org/mason-lspconfig.nvim",
--     opts = {},
--     dependencies = {
--         { "mason-org/mason.nvim", opts = {} },
--         "neovim/nvim-lspconfig",
--     },
-- },
--   -- Null-LS + Mason
--   {
--     "jay-babu/mason-null-ls.nvim",
--     event = "VeryLazy",
--     dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
--     config = function()
--       require("mason-null-ls").setup({
--         ensure_installed = { "prettierd", "stylua", "shfmt", "fixjson", "yamlfix" },
--         automatic_installation = true,
--       })
--     end,
--   },
--
--   -- Devcontainer
--   {
--     'esensar/nvim-dev-container',
--     cond = not vim.loop.fs_stat("/.dockerenv"),
--     dependencies = {
--       {
--         "nvim-treesitter/nvim-treesitter",
--         build = ":TSUpdate",
--         dependencies = {
--           "nvim-treesitter/nvim-treesitter-textobjects",
--           "rrethy/nvim-treesitter-endwise",
--           "HiPhish/rainbow-delimiters.nvim",
--           "windwp/nvim-autopairs",
--           "numToStr/Comment.nvim",
--           "JoosepAlviste/nvim-ts-context-commentstring",
--           "windwp/nvim-ts-autotag",
--         },
--         config = function()
--           require("nvim-treesitter.configs").setup({
--             ensure_installed = {
--               "c", "cpp", "lua", "python", "json", "jsonc", "html", "css",
--               "rust", "bash", "markdown", "typescript", "javascript", "cmake", "make",
--             },
--             highlight = { enable = true },
--             indent = { enable = true },
--             fold = { enable = true },
--             incremental_selection = {
--               enable = true,
--               keymaps = { init_selection = "<M-w>", scope_incremental = "<CR>", node_incremental = "grn", node_decremental = "grm" },
--             },
--             textobjects = {
--               select = {
--                 enable = true,
--                 lookahead = true,
--                 keymaps = { ["af"] = "@function.outer", ["if"] = "@function.inner", ["ac"] = "@class.outer" },
--               },
--             },
--           })
--         end,
--       },
--     },
--     config = function()
--       require("devcontainer").setup {
--         cache_images = false,
--         autocommands = { init = true, clean = true, update = true },
--         attach_mounts = {
--           neovim_config = { enabled = true, options = { "readonly" } },
--           neovim_data   = { enabled = true, options = {} },
--           neovim_state  = { enabled = true, options = {} },
--         },
--         nvim_install_as_root = true,
--         container_runtime = "devcontainer-cli",
--         backup_runtime = "docker",
--       }
--     end,
--   },
--
--   -- Misc
--   { "jmbuhr/otter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" }, opts = {} },
-- }

-- Devcontainer
return {
{
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
},
  -- Null-LS + Mason
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

  {
  "erichlf/devcontainer-cli.nvim",
  cond = not vim.loop.fs_stat("/.dockerenv"),
  dependencies = {
    "akinsho/toggleterm.nvim",
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "rrethy/nvim-treesitter-endwise",
        "HiPhish/rainbow-delimiters.nvim",
        "windwp/nvim-autopairs",
        "numToStr/Comment.nvim",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "windwp/nvim-ts-autotag",
      },
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "c", "cpp", "lua", "python", "json", "jsonc", "html", "css",
            "rust", "bash", "markdown", "typescript", "javascript", "cmake", "make",
          },
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
        })
      end,
    },
  },
  init = function()
    require("devcontainer-cli").setup({
      interactive = false,
      toplevel = true,
      remove_existing_container = true,
      dotfiles_repository = "https://github.com/iAmWayward/.config-nvim",
      dotfiles_branch = "Exodus",
      -- dotfiles_targetPath = "~/dotfiles",
      -- dotfiles_installCommand = "install.sh",
      shell = "bash",
      nvim_binary = "nvim",
      log_level = "debug",
      console_level = "info",
      keys = {
          {
            "<leader>cdu",
            ":DevcontainerUp<cr>",
            desc = "Up the DevContainer",
          },
          {
            "<leader>cdc",
            ":DevcontainerConnect<cr>",
            desc = "Connect to DevContainer",
          },
        },
    })
  end,
  }
}

