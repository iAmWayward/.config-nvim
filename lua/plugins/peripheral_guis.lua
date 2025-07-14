return {
  -- Bufferline and Dropbar are the tabs and breadcrumbs at the top of the editor
  -- {
  --   "petertriho/nvim-scrollbar",
  -- },
  {
    "akinsho/bufferline.nvim",
    -- lazy = false,
    -- event = "VeryLazy",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",

    },
    opts = {
      -- highlights = get_bufferline_highlights(),
      options = {
        themable = true,
        numbers = "none",         -- | "ordinal" | "buffer_id" | "both" |
        separator_style = "thin", -- slant, padded_slant, slope, thick, thin
        diagnostics = "nvim_lsp",
        indicator = {
          icon = "▎",
          style = "icon",
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            -- raw = " %{%v:lua.__get_selector()%} ",
            highlight = { sep = { link = "WinSeparator" } },
            separator = true,
          },
        },
        color_icons = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "relative_directory",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        -- name_formatter = function(buf)  -- buf contains:
        -- name               -- | str        | the basename of the active file
        -- path               -- | str        | the full path of the active file
        -- bufnr               | int        | the number of the active buffer
        -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        -- end,
      },
    },
  },

  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },

    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    event = "VeryLazy",
    version = "*",
    blend = 0.1,
    skipEnteringNoNeckPainBuffer = true,
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    opts = {
      ---@param bufnr integer
      ---@param filetype string
      ---@param buftype string
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      -- close_fold_kinds_for_ft
      -- close_fold_kinds = { "imports" },
      close_fold_kinds_for_ft = {
        description = [[After the buffer is displayed (opened for the first time), close the
                    folds whose range with `kind` field is included in this option. For now,
                    'lsp' provider's standardized kinds are 'comment', 'imports' and 'region',
                    and the 'treesitter' provider exposes the underlying node types.
                    This option is a table with filetype as key and fold kinds as value. Use a
                    default value if value of filetype is absent.
                    Run `UfoInspect` for details if your provider has extended the kinds.]],
        default = { default = {} },
      },
    },
  },

  -- Popup terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      direction = "float",      --horizontal", -- Opens at the bottom
      open_mapping = [[<c-\>]], -- Toggle with Ctrl+\ (default)
      autochdir = true,
      size = 15,                -- Height of the terminal split
      persist_size = true,
      shade_terminals = false,
      insert_mappings = false, -- Disable default insert mode mappings
      close_on_exit = true,
      border = "curved",
      shell = "fish",
    },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    -- lazy = false,
    -- event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        extensions = { "avante", "neo-tree", "trouble", "toggleterm" },
        indicator = {
          icon = "▎",
          style = "icon",
        },
        theme = "auto",
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        --[[ section_separators = { left = "", right = "" }, ]]
        disabled_filetypes = { "dashboard", "neo-tree", "lazy", "sagaoutline" },
        ignore_focus = {
          "neo-tree",
          "lspsaga",
          "sagaoutline",
          "trouble",
          "terminal",
          "toggleterm",
          "Avante",
          "AvanteSelectedFiles",
          "AvanteInput",
          "themery",
          "TelescopePrompt",
          "lazy",
        },
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = {
          {
            "mode",
            separator = { right = "", left = "" },
          },
          -- right_padding = 4
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = { "filesize", "encoding", "fileformat" },
        lualine_y = { "progress", "location" },
        lualine_z = {
          {
            "filetype",
            separator = { right = "", left = "" },
          },
        },
      },
      -- inactive_sections = {
      -- 	lualine_a = { "branch", "diff", "diagnostics" },
      -- 	lualine_b = {},
      -- 	lualine_c = {},
      -- 	lualine_x = {},
      -- 	lualine_y = {},
      -- 	lualine_z = {},
      -- },
    },
  },

  -- Hover under cursor
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {
      wrap = true,
      max_width = nil,
      max_height = nil,
      multi_server = true,
      border = "rounded",
    },
    dependencies = {},
  },
  {
    "lewis6991/hover.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("hover").setup({
        init = function()
          -- Load the LSP provider first
          require("hover.providers.lsp")

          -- Then override vim.lsp.handlers to use pretty_hover
          local pretty_hover = require("pretty_hover")
          local original_handler = vim.lsp.handlers["textDocument/hover"]

          vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
            if err or not result or not result.contents then
              return original_handler(err, result, ctx, config)
            end

            -- Use pretty_hover to display the hover content
            local contents = result.contents
            if type(contents) == "string" then
              contents = { contents }
            elseif contents.kind == "markdown" then
              contents = { contents.value }
            elseif contents.kind == "plaintext" then
              contents = { contents.value }
            end

            pretty_hover.open(contents, {
              wrap = true,
              max_width = nil,
              max_height = nil,
              border = "rounded",
            })
          end

          -- Load other providers
          require("hover.providers.gh")
          require("hover.providers.gh_user")
          require("hover.providers.jira")
          require("hover.providers.dap")
          require("hover.providers.fold_preview")
          require("hover.providers.diagnostic")
          require("hover.providers.man")
          require("hover.providers.dictionary")
        end,
        preview_opts = {
          border = "rounded",
        },
        preview_window = false,
        title = true,
      })
    end,
  },
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  },
}
