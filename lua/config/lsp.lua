-- lua/config/lsp.lua
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  -- any other options, e.g., capabilities, settings
  -- root_dir = function()
  --   return "/workspace"
  -- end,
}

vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
}

local ignored_py_codes = { E501 = true, W293 = true }

vim.lsp.config.basedpyright = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      if result and result.diagnostics then
        result.diagnostics = vim.tbl_filter(function(d)
          return not ignored_py_codes[d.code]
        end, result.diagnostics)
      end
      vim.lsp.handlers["textDocument/publishDiagnostics"](err, result, ctx, config)
    end,
  },
}

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")
