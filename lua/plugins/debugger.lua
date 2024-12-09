return {
  -- Core DAP Plugin
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- DAP UI Plugin
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio", -- Add nvim-nio as a dependency
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
        config = function()
          require("nvim-dap-virtual-text").setup {
            commented = true, -- Add comments for better readability
          }
        end,
      },
    },
    config = function()
      local dap = require("dap")

      -- Keybindings for DAP
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Set Conditional Breakpoint" })
      vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
      vim.keymap.set("n", "<Leader>dl", dap.run_last, { desc = "Run Last Debug Session" })

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
}

