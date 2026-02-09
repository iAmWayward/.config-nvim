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
  "https://codeberg.org/esensar/nvim-dev-container",
    config = function()
      require("devcontainer").setup {
        -- config_search_start = function()
        --   -- By default this function uses vim.loop.cwd()
        --   -- This is used to find a starting point for .devcontainer.json file search
        --   -- Since by default, it is searched for recursively
        --   -- That behavior can also be disabled
        -- end,
        -- workspace_folder_provider = function()
        --   -- By default this function uses first workspace folder for integrated lsp if available and vim.loop.cwd() as a fallback
        --   -- This is used to replace `${localWorkspaceFolder}` in devcontainer.json
        --   -- Also used for creating default .devcontainer.json file
        -- end,
        -- terminal_handler = function(command)
        --   -- By default this function creates a terminal in a new tab using :terminal command
        --   -- It also removes statusline when that tab is active, to prevent double statusline
        --   -- It can be overridden to provide custom terminal handling
        -- end,
        -- nvim_installation_commands_provider = function(path_binaries, version_string)
        --   -- Returns table - list of commands to run when adding neovim to container
        --   -- Each command can either be a string or a table (list of command parts)
        --   -- Takes binaries available in path on current container and version_string passed to the command or current version of neovim
        -- end,
        -- Can be set to true to install neovim as root in container
        -- Usually not required, but could help if permission errors occur during install
        nvim_install_as_root = false,
        devcontainer_json_template = function()
          -- Returns table - list of lines to set when creating new devcontainer.json files
          -- As a template
          -- Used only when using functions from commands module or created commands
        end,
        -- Can be set to false to prevent generating default commands
        -- Default commands are listed below
        generate_commands = true,
        -- By default no autocommands are generated
        -- This option can be used to configure automatic starting and cleaning of containers
        autocommands = {
          -- can be set to true to automatically start containers when devcontainer.json is available
          init = false,
          -- can be set to true to automatically remove any started containers and any built images when exiting vim
          clean = false,
          -- can be set to true to automatically restart containers when devcontainer.json file is updated
          update = false,
        },
        -- can be changed to increase or decrease logging from library
        log_level = "info",
        -- can be set to true to disable recursive search
        -- in that case only .devcontainer.json and .devcontainer/devcontainer.json files will be checked relative
        -- to the directory provided by config_search_start
        disable_recursive_config_search = false,
        -- can be set to false to disable image caching when adding neovim
        -- by default it is set to true to make attaching to containers faster after first time
        cache_images = true,
        -- By default all mounts are added (config, data and state)
        -- This can be changed to disable mounts or change their options
        -- This can be useful to mount local configuration
        -- And any other mounts when attaching to containers with this plugin
        attach_mounts = {
          neovim_config = {
            -- enables mounting local config to /root/.config/nvim in container
            enabled = false,
            -- makes mount readonly in container
            options = { "readonly" }
          },
          neovim_data = {
            -- enables mounting local data to /root/.local/share/nvim in container
            enabled = false,
            -- no options by default
            options = {}
          },
          -- Only useful if using neovim 0.8.0+
          neovim_state = {
            -- enables mounting local state to /root/.local/state/nvim in container
            enabled = false,
            -- no options by default
            options = {}
          },
        },
        -- This takes a list of mounts (strings) that should always be added to every run container
        -- This is passed directly as --mount option to docker command
        -- Or multiple --mount options if there are multiple values
        always_mount = {},
        -- This takes a string (usually either "podman" or "docker") representing container runtime - "devcontainer-cli" is also partially supported
        -- That is the command that will be invoked for container operations
        -- If it is nil, plugin will use whatever is available (trying "podman" first)
        -- container_runtime = nil,
        container_runtime = nil, -- "docker-compose",
        -- Similar to container runtime, but will be used if main runtime does not support an action - useful for "devcontainer-cli"
        -- backup_runtime = podman,
        -- This takes a string (usually either "podman-compose" or "docker-compose") representing compose command - "devcontainer-cli" is also partially supported
        -- That is the command that will be invoked for compose operations
        -- If it is nil, plugin will use whatever is available (trying "podman-compose" first)
        compose_command = nil,
        -- Similar to compose command, but will be used if main command does not support an action - useful for "devcontainer-cli"
        backup_compose_command = nil,
      }
    end,
  -- cond = not vim.loop.fs_stat("/.dockerenv"),
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
  -- init = function()
  --   require("devcontainer-cli").setup({
  --     interactive = false,
  --     toplevel = true,
  --     remove_existing_container = true,
  --     dotfiles_repository = "https://github.com/iAmWayward/.config-nvim",
  --     dotfiles_branch = "Exodus",
  --     -- dotfiles_targetPath = "~/dotfiles",
  --     -- dotfiles_installCommand = "install.sh",
  --     shell = "bash",
  --     nvim_binary = "nvim",
  --     log_level = "debug",
  --     console_level = "info",
  --     keys = {
  --         {
  --           "<leader>cdu",
  --           ":DevcontainerUp<cr>",
  --           desc = "Up the DevContainer",
  --         },
  --         {
  --           "<leader>cdc",
  --           ":DevcontainerConnect<cr>",
  --           desc = "Connect to DevContainer",
  --         },
  --       },
  --   })
  -- end,
  }
}

