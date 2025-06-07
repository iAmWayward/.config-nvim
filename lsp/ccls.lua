-- local lspconfig = require("lspconfig")
-- lspconfig.ccls.setup({
-- 	init_options = {
-- 		clang = {
-- 			-- Example: exclude certain GCC-specific flags that clang cannot parse
-- 			excludeArgs = { "-frounding-math" },
-- 			-- You can also add default flags here with `extraArgs` if needed (see below)
-- 		},
-- 	},
-- 	on_attach = on_attach, -- (Attach function to enable keybindings, etc., if defined elsewhere)
-- 	capabilities = capabilities, -- (Capabilities like snippet support, if defined)
-- })

return {
	init_options = {
		compilationDatabaseDirectory = "build", -- Look for compile_commands.json in the "build" dir (if present)
		cache = { directory = ".ccls-cache" }, -- Enable on-disk caching of indexed symbols
		index = { threads = 0 }, -- Use all CPU cores for indexing (0 = auto-detect)
		highlight = { lsRanges = true }, -- Enable semantic highlighting (if your colorscheme supports it)
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
}
