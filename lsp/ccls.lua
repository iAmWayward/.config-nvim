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
