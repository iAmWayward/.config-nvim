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

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
