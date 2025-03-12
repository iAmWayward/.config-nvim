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
                        enabled = true,
                        enable_commands = true
                    }
                end,
            },
        },
        config = function()
            local dap = require("dap")
            require("config.keymaps").debugger_setup(dap)

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
