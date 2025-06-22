return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()         -- load VSCode-style snippets (friendly-snippets)
      require("luasnip.loaders.from_lua").lazy_load()            -- load any custom LuaSnip snippet files
      -- Extend filetypes to include doc-comment snippets from friendly-snippets:
      require("luasnip").filetype_extend("cpp", { "cppdoc" })    -- Doxygen for C++
      require("luasnip").filetype_extend("c", { "cdoc" })        -- Doxygen for C
      require("luasnip").filetype_extend("sh", { "shelldoc" })   -- Shell script docs
      require("luasnip").filetype_extend("python", { "pydoc" })  -- Google-style pydoc
      require("luasnip").filetype_extend("javascript", { "jsdoc" }) -- JSDoc for JS
      require("luasnip").filetype_extend("typescript", { "tsdoc" }) -- TSDoc for TS
    end,
  },
}
