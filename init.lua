-- init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Compatibility shims for plugins using deprecated Neovim APIs
rawset(vim, 'highlight', vim.hl)

local _validate = vim.validate
do
  local type_aliases = {
    b = "boolean", c = "callable", f = "function",
    n = "number", s = "string", t = "table",
  }

  local function expand_type(t)
    if type(t) == "string" then
      return type_aliases[t] or t
    elseif type(t) == "table" then
      local expanded = {}
      for i, v in ipairs(t) do
        expanded[i] = type_aliases[v] or v
      end
      return expanded
    end
    return t
  end

  vim.validate = function(name, ...)
    if type(name) == "table" then
      for k, v in pairs(name) do
        _validate(k, v[1], expand_type(v[2]), v[3])
      end
    else
      _validate(name, ...)
    end
  end
end

require("config.lazy")
require("config.autocmds")
require("config.lsp")
