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
        mappings = {
          ["<cr>"] = "open", -- Focus the file
          ["<Space>"] = "toggle_preview", --["<A-j>"] = "toggle_preview",--"open_split", --toggle_preview Show file without focusing
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
vim.keymap.set("n", "<leader><Space>", "<cmd>Neotree toggle current<cr>", {
  desc = "Toggle Neo-tree (current)",
  silent = true,
})

vim.keymap.set("n", "T", "<cmd>Neotree open_tab_drop<cr>", {
  desc = "Open a new tab without focusing it.",
  silent = true,
})

vim.keymap.set("n", "|", "<cmd>Neotree reveal<cr>", {
  desc = "Reveal file in Neo-tree",
  silent = true,
})

vim.keymap.set("n", "gd", "<cmd>Neotree float reveal_file=<cfile> reveal_force_cwd<cr>", {
  desc = "Reveal file in floating Neo-tree (force cwd)",
  silent = true,
})

vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle show buffers right<cr>", {
  desc = "Toggle buffer list in Neo-tree (right)",
  silent = true,
})

vim.keymap.set("n", "<leader>s", "<cmd>Neotree float git_status<cr>", {
  desc = "Open git status in floating Neo-tree",
  silent = true,
})

vim.keymap.set("n", "<leader>o", "<cmd>Neotree toggle<cr>", {
  desc = "Toggle Neo-tree (filesystem)",
  silent = true,
})
end,
}

