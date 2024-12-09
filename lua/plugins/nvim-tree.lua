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

    require("neo-tree").setup({
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = false,
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
        mappings = {
          ["<cr>"] = "open", -- Focus the file
          ["<Space>"] = "toggle_preview",--"open_split", --toggle_preview Show file without focusing
          ["l"] = "open",
          ["C"] = "close_node",
        },
      },
      filesystem = {
        follow_current_file = {
		enabled = true,
		leave_dirs_open = true,
	},
        hijack_netrw_behavior = "open_default",
      },
    })

    -- Keybindings
    vim.api.nvim_set_keymap("n", "<leader><Space>", ":Neotree toggle current<cr>", { noremap = true, silent = true }) -- reveal_force_cwd
    vim.api.nvim_set_keymap("n", "|", ":Neotree reveal<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "gd", ":Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>b", ":Neotree toggle show buffers right<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>s", ":Neotree float git_status<cr>", { noremap = true, silent = true })
  end,
}

