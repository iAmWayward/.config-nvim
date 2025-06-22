return {
  -- cmake-tools.nvim
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "mrjones2014/legendary.nvim",
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          -- Setup dapui
          dapui.setup()

          -- Open/Close dapui automatically on debugging events
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      -- DAP Virtual Text Plugin
      {
        "theHamsta/nvim-dap-virtual-text",
        -- event = "VeryLazy",
        opts = {
          commented = true, -- Add comments for better readability
          enabled = true,
          enable_commands = true,
        },
      },
    },
    config = function()
      local dap = require("dap")
      local keymaps = require("config.keymaps")
      require("legendary").keymaps(keymaps.dap_mappings(dap))

      -- Example Adapter for gdb (adjust for embedded development)
      dap.adapters.gdb = {
        type = "executable",
        command = "arm-none-eabi-gdb", -- Replace with your gdb executable
        name = "gdb",
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = "${workspaceFolder}/build/your_binary.elf", -- Replace with your ELF path
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = false,
          setupCommands = {
            {
              text = "-enable-pretty-printing", -- Pretty-printing for better debugging output
              description = "Enable pretty printing",
              ignoreFailures = false,
            },
          },
        },
      }

      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c
    end,
  },
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",      -- For standard functions
      "MunifTanjim/nui.nvim",       -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
    offline_mode = {
      enabled = true,
      no_github = false,
    },
    -- Offline mode configuration. For more details, see the "Offline mode" section below.
    --[[   -- What path should be looked at to find locally available releases ]]
    --[[   cache_dir = utils.path_join(utils.is_windows, vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"), ]]
  },
  {
    "mrjones2014/legendary.nvim",
    keys = {
      { "<C-p>", "<cmd>Legendary<cr>", desc = "Open Command Palette" },
    },
    lazy = true,
    dependencies = {
      "kkharji/sqlite.lua",
      "folke/which-key.nvim",
    },
    config = function()
      require("legendary").setup({
        include_builtin = true,
        include_legendary_cmds = true,
        extensions = {
          which_key = {
            -- auto_register = {
            -- 	neotree = true,
            -- 	neo_tree = true,
            -- 	["neo-tree"] = true,
            -- },
            auto_register = true,
            do_binding = false,
            use_groups = true,
          },
        },
      })

      -- Load all regular keymaps
      local keymaps = require("config.keymaps")
      require("legendary").keymaps(keymaps.items)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "neo-tree",
        callback = function()
          require("legendary").keymaps(require("config.keymaps").items, {
            buffer = true,
            filetype = "neo-tree",
          })
        end,
      })
    end,
  },
}
