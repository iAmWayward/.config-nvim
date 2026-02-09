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

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
-- vim.lsp.completion.enable(nil, args.data.client_id, bufnr, { autotrigger = true })
