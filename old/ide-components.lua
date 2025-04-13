return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- If you want to lazy load on keys:
    config = function()
      require("telescope").setup()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TelescopeFindPre",
        callback = function()
          -- require("config.keymaps").telescope_setup()
        end,
      })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make", -- correct for lazy.nvim
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      local function get_bufferline_highlights()
        local colorscheme = vim.g.colors_name or ""
        if colorscheme:find("catppuccin") then
          return require("catppuccin.groups.integrations.bufferline").get()
        end
        -- Fallback styling
        return {
          background = { bg = "NONE" },
          buffer_selected = { bold = true, italic = false },
          buffer_visible = { bg = "NONE" },
          fill = { bg = "NONE" },
          separator = { bg = "NONE" },
          separator_selected = { bg = "NONE" },
          separator_visible = { bg = "NONE" },
          indicator_selected = { bg = "NONE" },
          modified = { bg = "NONE" },
          modified_selected = { bg = "NONE" },
          modified_visible = { bg = "NONE" },
        }
      end

      -- Initial setup with highlights at the top level
      require("bufferline").setup({
        highlights = get_bufferline_highlights(), -- Top-level key
        options = {
          themable = true,
          separator_style = "thin",
          diagnostics = "nvim_lsp",
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              separator = true
            }
          },
          color_icons = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
          },
          sort_by = 'relative_directory',
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "(" .. count .. ")"
          end,
          -- name_formatter = function(buf)  -- buf contains:
          -- name               -- | str        | the basename of the active file
          -- path               -- | str        | the full path of the active file
          -- bufnr               | int        | the number of the active buffer
          -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
          -- end,
        }
      })

      --[[ -- Autocmd outside the setup to handle colorscheme changes ]]
      --[[ vim.api.nvim_create_autocmd("ColorScheme", { ]]
      --[[   callback = function() ]]
      --[[     require("bufferline").setup({ highlights = get_bufferline_highlights() }) ]]
      --[[   end, ]]
      --[[ }) ]]
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      --[[ "3rd/image.nvim", ]]
      opts = {},

      {
        's1n7ax/nvim-window-picker',
        version = '*',
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
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

      -- Don't call tree_setup here, it will be called in the event handler
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        shared_tree_across_tabs = true,
        default_component_configs = {
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "*",
            folder_empty_open = "󰝰",
          },
          git_status = {
            symbols = {
              added = "✚",
              modified = "",
              deleted = "✖",
              renamed = "󰁕",
            },
          },
        },
        window = {
          -- mappings = require("config.keymaps").get_tree_mappings(),
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = true,
          },
          hijack_netrw_behavior = "open_default",
        },
        commands = {
          open_tab_stay = function()
            require("neo-tree.sources.filesystem.commands").open_tabnew()
            vim.cmd("wincmd p") -- Return to previous window
          end,
        },
      })
    end,
  }
}
