-- init.lua
vim.deprecate = function() end

require("config.lazy")
require("config.lsp")

-- Load LSP configs dynamically

require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/snippets" })

