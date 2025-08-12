vim.deprecate = function() end -- Shut up about deprecations
require("config.lazy")

-- Load all LSP configs from lua/lsp/
local lsp_dir = vim.fn.stdpath("config") .. "/lua/lsp"

for _, file in ipairs(vim.fn.readdir(lsp_dir, [[v:val =~ '\.lua$']])) do
  local mod = file:gsub("%.lua$", "")
  local ok, err = pcall(require, "lsp." .. mod)
  if not ok then
    vim.notify("Error loading LSP config " .. mod .. ": " .. err, vim.log.levels.ERROR)
  end
end
