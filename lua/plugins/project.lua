return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      manual_mode = false,
      detection_methods = { "pattern", "lsp" },
      patterns = { ".git", "Makefile", "package.json", ".svn" },
      show_hidden = false,
    })
    require('telescope').load_extension('projects')
  end,
}
