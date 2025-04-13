return {
  -- Mason for package management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "Makefile", "package.json", ".svn", ".cproj", "csproj" },
        show_hidden = false,
      })
      require('telescope').load_extension('projects')
    end,
  },
  {
    'https://github.com/adelarsq/neovcs.vim',
    keys = {
      '<leader>v',
    },
    config = function()
      require('neovcs').setup()
    end
  },
  { 'HugoBde/subversigns.nvim' },
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    --[[ ft = "markdown", ]]
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      "BufReadPre /home/george/Documents/Obsidian Vault/*.md",
      "BufNewFile /home/george/Documents/Obsidian Vault/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/Obsidian Vault",
        },
        --[[ { ]]
        --[[   name = "work", ]]
        --[[   path = "~/vaults/work", ]]
        --[[ }, ]]
      },

      -- see below for full list of options 👇
    },
  },
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
    config = function()
      -- require("config.keymaps").dropbar_setup() -- Keymaps
    end

  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          diagnostics = "nvim_lsp",
          indicator = {
            icon = '▎',
            style = 'icon',
          },
          theme = "auto",
          section_separators = { left = '', right = '' },
          -- component_separators = { left = '', right = '' },
          component_separators = { left = "", right = "" },
          --[[ section_separators = { left = "", right = "" }, ]]
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            {
              'mode',
              separator = { left = '' }
            },
            -- right_padding = 4
          },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {},
          lualine_x = { 'filesize', 'encoding', 'fileformat' },
          lualine_y = { 'progress', 'location' },
          lualine_z = {
            {
              'filetype',
              separator = { right = '' }
            },
          },
        },
        inactive_sections = {
          lualine_a = { 'branch', 'diff', 'diagnostics' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end,
  },


  {
    "rcarriga/nvim-notify"
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      }
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason LSP setup
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- Unified on_attach function
      local on_attach = function(client, bufnr)
        -- require("config.keymaps").mason_setup(bufnr)

        -- Skip formatting for C/H files
        local filetype = vim.bo[bufnr].filetype
        if client.supports_method("textDocument/formatting") and filetype ~= "c" and filetype ~= "h" then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
          })
        end
      end

      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = {
          "ts_ls", "clangd", "lua_ls", "pyright", "bashls",
          "tailwindcss", "html", "eslint", "vimls",
        },
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              ["*"] = { format = { enable = true }
              }
            }
          })
        end,

        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
              },
            },
          })
        end,

        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            capabilities = {
              capabilities,
              positionEncodings = { "utf-16", "utf-32" },
            },
            -- Use this instead if you dont need encodings merged for codecompanion.
            --[[ require("lspconfig").clangd.setup({ ]]
            --[[   capabilities = vim.tbl_deep_extend('force', capabilities, { -- Fix merge ]]
            --[[     positionEncodings = { "utf-16", "utf-32" }, ]]
            --[[   }), ]]
            on_attach = on_attach,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--completion-style=detailed",
              -- "--header-insertion=iwyu",
              "--suggest-missing-includes",
              "--offset-encoding=utf-16",
            },
          })
        end,

        ["ts_ls"] = function()
          require("lspconfig").ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
          })
        end,
      })
    end,
  },

  -- None-LS (null-ls) for formatting
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettierd",
          "stylua",
          "ruff",
          "shfmt",
          "fixjson",
          "mdformat",
          "markdownlint",
          "yamlfix",
          "cmake_format",
          "dprint"
        },
        automatic_installation = true,
      })

      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Web
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.dprint,

          null_ls.builtins.formatting.ruff,    -- Python
          null_ls.builtins.formatting.stylua,  -- Lua
          null_ls.builtins.formatting.shfmt,   -- Shell scripts
          null_ls.builtins.formatting.fixjson, -- JSON

          -- Markdown
          null_ls.builtins.formatting.mdformat,
          null_ls.builtins.diagnostics.markdownlint,


          null_ls.builtins.formatting.yamlfix, -- YAML
          null_ls.builtins.diagnostics.tsc,

          -- CMake
          null_ls.builtins.formatting.cmake_format.with({
            command = "cmake_format"
          }),
        },
        -- Make sure there aren't multiple encodings.
        on_init = function(new_client, _)
          new_client.offset_encoding = 'utf-16'
        end,
      })
    end,
  },
  {
    "lewis6991/hover.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("hover").setup({
        init = function(client, bufnr) -- Add parameters here
          require("hover.providers.lsp")
          -- Uncomment any additional providers you want to use:
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          -- require('hover.providers.dap')
          -- require('hover.providers.fold_preview')
          -- require('hover.providers.diagnostic')
          require('hover.providers.man')
          require('hover.providers.dictionary')
          -- require('hover.providers.highlight')
        end,
        preview_opts = {
          border = "single",
        },
        preview_window = false,
        title = true,
        mouse_providers = {
          "LSP",
        },
        --[[ mouse_delay = 1000, ]]
      })

      -- require("config.keymaps").hover_setup() -- Keymaps
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "rrethy/nvim-treesitter-endwise",
      "windwp/nvim-autopairs",
      "abecodes/tabout.nvim",
      {
        "numToStr/Comment.nvim",
        config = function()
          require('Comment').setup()
        end,
      },
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require('ts_context_commentstring').setup({})
          vim.g.skip_ts_context_commentstring_module = true
        end,
      },
      {
        "windwp/nvim-ts-autotag",
        config = function()
          require("nvim-ts-autotag").setup()
        end,
      },
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "git_config", "gitcommit", "gitignore", "git_rebase", "gitattributes",
          "cpp", "c", "make", "python", "lua", "luadoc", "html", "css", "rust",
          "bash", "cmake", "comment", "csv", "desktop", "dockerfile", "doxygen",
          "fish", "editorconfig", "markdown", "markdown_inline", "ssh_config",
          "tsx", "typescript", "javascript", "ini", "vim", "xml", "yaml", "http", "jsdoc"
        },
        ignore_install = {},
        modules = {},
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<M-w>",
            scope_incremental = "<CR>",
            node_incremental = "<Tab>",
            node_decremental = "<S-Tab>",
          },
        },
        matchup = { enable = true },
        endwise = { enable = true },
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
  {
    "windwp/nvim-autopairs",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local ts_conds = require("nvim-autopairs.ts-conds")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          typescript = { "template_string" },
          typescriptreact = { "template_string", "string", "comment" },
          javascriptreact = { "template_string", "string", "comment" },
        }
      })

      -- Add custom rules for JSX/TSX with more complete filetype handling
      npairs.add_rules({
        Rule("<", ">", { "typescriptreact" }),
        Rule("{", "}", { "typescriptreact" }),
        Rule("(", ")", { "typescriptreact" }),
        Rule("[", "]", { "typescriptreact" }),
        Rule("'", "'", { "typescriptreact" }),
        Rule('"', '"', { "typescriptreact" }),
        Rule("`", "`", { "typescriptreact" }),
      })

      -- Treesitter condition-based pairs
      npairs.add_rules({
        Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
        Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" }))
      })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp_status_ok, cmp = pcall(require, 'cmp')
      if cmp_status_ok then
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "abecodes/tabout.nvim",
    opts = {
      tabkey = "<Tab>",
      backwards_tabkey = "<S-Tab>",
      completion = true,
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = { [''] = rainbow_delimiters.strategy.global },
        query = { [''] = 'rainbow-delimiters' }
      }
    end
  },
  {
    "hat0uma/doxygen-previewer.nvim",
    opts = {},
    dependencies = { "hat0uma/prelive.nvim" },
    update_on_save = true,
    cmd = {
      "DoxygenOpen",
      "DoxygenUpdate",
      "DoxygenStop",
      "DoxygenLog",
      "DoxygenTempDoxyfileOpen"
    },
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        input_after_comment = true,
        languages = {
          cpp = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          c = {
            template = {
              annotation_convention = "doxygen"
            }
          },
          python = {
            template = {
              annotation_convention = "google_docstrings"
            }
          },
          lua = {
            template = {
              annotation_convention = "emmylua"
            }
          },
          javascript = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          typescriptreact = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          tsx = {
            template = {
              annotation_convention = "tsdoc"
            }
          },
          jsx = {
            template = {
              annotation_convention = "jsdoc"
            }
          },
          sh = {
            template = {
              annotation_convention = "google_bash"
            }
          },
        }
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
    },
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      -- Main cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Enter>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources(
          {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "codecompanion" },
            {
              name = "lazydev",
              group_index = 0, -- set group index to 0 to skip loading LuaLS completions
            }
          },
          {
            { name = "buffer" },
            { name = "path" },
          }
        ),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            show_labeldetails = true,
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Cmdline setup for search ('/')
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" }
        }
      })

      -- Cmdline setup for command line (':')
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        )
      })

      -- Load snippets
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  -- Core DAP Plugin
  {
    "mfussenegger/nvim-dap",
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
      local keymaps = require("config.keymaps")
      require('legendary').keymaps(keymaps.dap_mappings(dap))

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
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        -- Custom configuration
        symbol_in_winbar = {
          enable = true,
          separator = '   ',
        },
        ui = {
          title = true,
          border = 'rounded',
          actionfix = '',
          expand = '',
          collapse = '',
          code_action = '💡',
          diagnostic = '🐞',
          colors = {
            normal_bg = '#022746',
          },
        },
        lightbulb = {
          enable = true,
          sign = true,
          virtual_text = false,
        },
        diagnostic = {
          show_code_action = true,
          show_source = true,
          jump_num_shortcut = true,
          keys = {
            exec_action = 'o',
            quit = 'q',
          },
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
      'folke/trouble.nvim',
    }
  },
  {
    "tpope/vim-sleuth", -- Automatically detects which indents should be used in the current buffer
    {
      "Davidyz/VectorCode",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "VectorCode", -- if you're lazy-loading VectorCode
    },
  },


  {
    "amitds1997/remote-nvim.nvim",
    version = "*",                     -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim",         -- For standard functions
      "MunifTanjim/nui.nvim",          -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
    -- Offline mode configuration. For more details, see the "Offline mode" section below.
    --[[ offline_mode = { ]]
    --[[   -- Should offline mode be enabled? ]]
    --[[   enabled = false, ]]
    --[[   -- Do not connect to GitHub at all. Not even to get release information. ]]
    --[[   no_github = false, ]]
    --[[   -- What path should be looked at to find locally available releases ]]
    --[[   cache_dir = utils.path_join(utils.is_windows, vim.fn.stdpath("cache"), constants.PLUGIN_NAME, "version_cache"), ]]
    --[[ }, ]]
  },






  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
}
