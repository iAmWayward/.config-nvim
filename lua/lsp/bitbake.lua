-- Yocto: sudo npm install -g language-server-bitbake

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

-- Register the BitBake LS if it hasn't been registered yet
if not configs.bitbake_ls then
  configs.bitbake_ls = {
    default_config = {
      cmd = { "language-server-bitbake", "--stdio" },
      filetypes = { "bitbake", "bb", "bbappend", "bbclass" },
      root_dir = lspconfig.util.root_pattern("conf", "conf/bblayers.conf", ".git"),
      settings = {},
    },
  }
end

-- Now we can safely call setup()
lspconfig.bitbake_ls.setup({})
