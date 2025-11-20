vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    -- "--path-mappings=/workspace=" .. vim.fn.getcwd(),
  },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
}

vim.lsp.enable("clangd")
vim.lsp.enable("lua_ls")
-- vim.lsp.completion.enable(nil, args.data.client_id, bufnr, { autotrigger = true })
