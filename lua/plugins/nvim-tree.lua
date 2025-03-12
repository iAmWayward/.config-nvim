return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- Optional but recommended for icons
        "MunifTanjim/nui.nvim",
        {
            's1n7ax/nvim-window-picker',
            version = '2.*',
            config = function()
                require 'window-picker'.setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        bo = {
                            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                })
            end,
        },
    },
    config = function()
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
        local keymaps = require("config.keymaps")

        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = false,
            shared_tree_across_tabs = true,
            default_component_configs = {
                indent = {
                    indent_size = 2,
                    with_markers = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    default = "*",
                },
                git_status = {
                    symbols = {
                        added = "✚",
                        modified = "",
                        deleted = "✖",
                        renamed = "󰁕",
                    },
                },
            },
            window = {
                mappings = {},
            },
            filesystem = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                hijack_netrw_behavior = "open_default",
            },
            commands = {
                open_tab_stay = function(state)
                    require("neo-tree.sources.filesystem.commands").open_tabnew(state)
                    vim.cmd("wincmd p") -- Return to previous window
                end,
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(args)
                        keymaps.tree_setup(args.buf) -- Apply keymaps when Neo-tree opens
                    end
                }
            }
        })
    end,
}
