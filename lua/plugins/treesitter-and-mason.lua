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

  -- Treesitter (main branch)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()

      local ensure_installed = {
        "bash", "c", "cpp", "cmake", "comment", "css", "diff", "dockerfile",
        "fish", "go", "html", "http", "ini", "java", "javascript", "jsdoc",
        "json", "jsonc", "lua", "luadoc", "make", "markdown", "markdown_inline",
        "python", "query", "regex", "ruby", "rust", "toml", "tsx", "typescript",
        "vim", "vimdoc", "xml", "yaml",
      }

      local function parser_installed(lang)
        return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0
      end

      local missing = vim.tbl_filter(function(lang)
        return not parser_installed(lang)
      end, ensure_installed)
      if #missing > 0 then
        require("nvim-treesitter").install(missing)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          if not pcall(vim.treesitter.start, buf) then
            return
          end
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Treesitter textobjects (main branch)
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer", "textobjects")
      end, { desc = "select function (outer)" })
      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner", "textobjects")
      end, { desc = "select function (inner)" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer", "textobjects")
      end, { desc = "select class (outer)" })
    end,
  },

  -- Rainbow delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      require("rainbow-delimiters.setup").setup({
        condition = function(buf)
          local ok, parser = pcall(vim.treesitter.get_parser, buf)
          return ok and parser ~= nil
        end,
      })
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Context-aware commentstring
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
    opts = { enable_autocmd = false },
  },

  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
  },

  -- Auto-close/rename HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
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
