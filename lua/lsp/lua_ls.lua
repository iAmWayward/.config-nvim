return {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          commitCharactersSupport = false,
          deprecatedSupport = true,
          documentationFormat = { "markdown", "plaintext" },
          insertReplaceSupport = true,
          insertTextModeSupport = {
            valueSet = { 0 }
          },
          labelDetailsSupport = true,
          preselectSupport = false,
          resolveSupport = {
            properties = { "documentation", "detail", "additionalTextEdits", "command", "data" }
          },
          snippetSupport = true,
          tagSupport = {
            valueSet = { 1 }
          }
        },
        completionList = {
          itemDefaults = { "commitCharacters", "editRange", "insertTextFormat", "insertTextMode", "data" }
        },
        contextSupport = true,
        insertTextMode = 1
      }
    }
  },
  cmd = { "lua-language-server" },
  filetypes = "lua",
  root_markers = ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".git",
}
