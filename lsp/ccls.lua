-- return {
-- 	init_options = {
-- 		compilationDatabaseDirectory = "build", -- Look for compile_commands.json in the "build" dir (if present)
-- 		cache = { directory = ".ccls-cache" }, -- Enable on-disk caching of indexed symbols
-- 		highlight = { lsRanges = true }, -- Enable semantic highlighting (if your colorscheme supports it)
-- 		clang = {
-- 			excludeArgs = { "-frounding-math" },
-- 		},
--
-- 		index = {
-- 			threads = 0, -- Auto-detect CPU cores
-- 			comments = 2, -- Index comments for better search
-- 			trackDependency = 1, -- Track header dependencies
-- 			multiVersion = 0, -- Don't index multiple versions of same file
-- 			multiVersionBlacklist = { "^/usr/include/" },
-- 			initialBlacklist = { "^/usr/include/" }, -- Skip system headers initially
-- 			initialWhitelist = {},
-- 			onChange = true, -- Re-index on file changes
-- 			onSave = true, -- Re-index on file save
-- 			maxInitializerLines = 30, -- Limit initializer indexing
-- 		},
-- 	},
-- }
--

-- Helper function to detect project type and toolchain
local function detect_project_config()
	local cwd = vim.fn.getcwd()
	local config = {
		target = nil,
		sysroot = nil,
		extra_args = {},
		resource_dir = nil,
	}

	-- Check for project-specific configuration files
	local config_files = {
		".ccls",
		".ccls-root",
		"compile_flags.txt",
		".clang_complete",
	}

	for _, file in ipairs(config_files) do
		if vim.fn.filereadable(cwd .. "/" .. file) == 1 then
			-- Project has specific ccls config, let it handle everything
			return nil
		end
	end

	-- Auto-detect based on common patterns
	local makefile_content = ""
	if vim.fn.filereadable(cwd .. "/Makefile") == 1 then
		makefile_content = table.concat(vim.fn.readfile(cwd .. "/Makefile"), "\n")
	end

	local cmake_content = ""
	if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
		cmake_content = table.concat(vim.fn.readfile(cwd .. "/CMakeLists.txt"), "\n")
	end

	-- Check for ARM toolchains
	if makefile_content:match("arm%-linux%-gnueabihf") or cmake_content:match("arm%-linux%-gnueabihf") then
		config.target = "arm-linux-gnueabihf"
		config.extra_args = {
			"-target",
			"arm-linux-gnueabihf",
			"-march=armv7-a",
			"-mfpu=neon",
			"-mfloat-abi=hard",
		}
	elseif
		makefile_content:match("arm%-none%-eabi")
		or cmake_content:match("arm%-none%-eabi")
		or vim.fn.isdirectory(cwd .. "/CMSIS") == 1
	then
		config.target = "arm-none-eabi"
		config.extra_args = {
			"-target",
			"arm-none-eabi",
			"-mthumb",
			"-mcpu=cortex-m4",
			"-mfloat-abi=hard",
			"-mfpu=fpv4-sp-d16",
			"-fno-exceptions",
			"-fno-rtti",
			"-fno-threadsafe-statics",
		}
	elseif makefile_content:match("aarch64") or cmake_content:match("aarch64") then
		config.target = "aarch64-linux-gnu"
		config.extra_args = {
			"-target",
			"aarch64-linux-gnu",
		}
	end

	-- Check for musl
	if makefile_content:match("musl") or cmake_content:match("musl") or vim.fn.isdirectory("/usr/lib/musl") == 1 then
		-- Add musl-specific flags
		table.insert(config.extra_args, "-D_GNU_SOURCE")
		table.insert(config.extra_args, "-D__MUSL__")

		-- Try to find musl sysroot
		local musl_paths = {
			"/usr/lib/musl",
			"/opt/musl",
			cwd .. "/sysroot",
			cwd .. "/toolchain/sysroot",
		}

		for _, path in ipairs(musl_paths) do
			if vim.fn.isdirectory(path) == 1 then
				config.sysroot = path
				break
			end
		end
	end

	-- Check for embedded/bare metal
	if
		makefile_content:match("%-nostdlib")
		or makefile_content:match("%-ffreestanding")
		or cmake_content:match("BARE_METAL")
	then
		vim.list_extend(config.extra_args, {
			"-nostdlib",
			"-ffreestanding",
			"-fno-builtin",
		})
	end

	return config
end

-- Helper to find compilation database
local function find_compile_commands()
	local cwd = vim.fn.getcwd()
	local locations = {
		"build/compile_commands.json",
		"compile_commands.json",
		"build/debug/compile_commands.json",
		"build/release/compile_commands.json",
		".ccls/compile_commands.json",
		"out/compile_commands.json",
	}

	for _, location in ipairs(locations) do
		local full_path = cwd .. "/" .. location
		if vim.fn.filereadable(full_path) == 1 then
			return vim.fn.fnamemodify(full_path, ":h")
		end
	end

	return "build" -- default fallback
end

-- Main configuration
return {
	init_options = {
		-- Dynamic compilation database
		compilationDatabaseDirectory = find_compile_commands(),

		-- Caching
		cache = {
			directory = ".ccls-cache",
			format = "json",
			hierarchicalPath = false,
			retainInMemory = true,
		},

		-- Indexing optimized for cross-compilation
		index = {
			threads = 0,
			comments = 2,
			trackDependency = 1,
			multiVersion = 0,
			-- Exclude system headers that might not match target
			multiVersionBlacklist = {
				"^/usr/include/",
				"^/usr/lib/gcc/",
				"^/usr/local/include/",
			},
			initialBlacklist = {
				"^/usr/include/",
				"^/usr/lib/gcc/",
				"^/usr/local/include/",
			},
			onChange = true,
			onSave = true,
			maxInitializerLines = 30,
		},

		highlight = { lsRanges = true },

		-- Dynamic clang configuration
		clang = (function()
			local project_config = detect_project_config()
			if not project_config then
				-- Let project-specific config handle everything
				return {
					excludeArgs = { "-frounding-math" },
				}
			end

			local clang_config = {
				excludeArgs = {
					"-frounding-math",
					"-fno-var-tracking-assignments",
					"-mno-fused-madd",
					-- Exclude host-specific flags that might break cross-compilation
					"-march=native",
					"-mtune=native",
				},
				extraArgs = {
					"-fdiagnostics-color=always",
					"-fdiagnostics-show-template-tree",
					-- Add project-detected flags
				},
			}

			-- Add detected target-specific arguments
			vim.list_extend(clang_config.extraArgs, project_config.extra_args)

			-- Add sysroot if detected
			if project_config.sysroot then
				table.insert(clang_config.extraArgs, "--sysroot=" .. project_config.sysroot)
			end

			return clang_config
		end)(),

		-- Other settings remain the same but simplified
		completion = {
			detailedLabel = true,
			maxNum = 100,
			dropOldRequests = true,
		},

		diagnostics = {
			onChange = 1000,
			spellChecking = true,
		},

		xref = {
			container = true,
			includeDeclaration = true,
			maxNum = 2000,
		},
	},

	capabilities = (function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		capabilities.textDocument.completion.completionItem.resolveSupport = {
			properties = { "documentation", "detail", "additionalTextEdits" },
		}
		return capabilities
	end)(),

	-- Enhanced root detection for embedded/cross-compilation projects
	root_dir = function(fname)
		local util = require("lspconfig.util")
		return util.root_pattern(
			-- ccls-specific files (highest priority)
			".ccls",
			".ccls-root",
			"compile_commands.json",
			"compile_flags.txt",
			-- Build system files
			"CMakeLists.txt",
			"Makefile",
			"meson.build",
			"BUILD.gn",
			"SConstruct",
			-- Embedded/ARM specific
			"platformio.ini",
			"mbed_app.json",
			"zephyr/CMakeLists.txt",
			"CMSIS",
			-- Version control
			".git",
			".svn",
			-- Fallback patterns from project.nvim
			".cproj",
			"csproj",
			"package.json"
		)(fname) or util.path.dirname(fname)
	end,

	-- Project-aware initialization
	on_init = function(client, initialize_result)
		local cwd = vim.fn.getcwd()

		-- Print detected configuration for debugging
		vim.schedule(function()
			local config = detect_project_config()
			if config and config.target then
				vim.notify("ccls: Detected target " .. config.target, vim.log.levels.INFO)
			end
		end)

		-- Try to find and suggest creating compile_commands.json if missing
		local has_compile_db = false
		local search_dirs = { "build", ".", "out", "build/debug", "build/release" }

		for _, dir in ipairs(search_dirs) do
			if vim.fn.filereadable(cwd .. "/" .. dir .. "/compile_commands.json") == 1 then
				has_compile_db = true
				break
			end
		end

		if not has_compile_db and vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
			vim.schedule(function()
				vim.notify(
					"ccls: No compile_commands.json found. Run: cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build",
					vim.log.levels.WARN
				)
			end)
		end
	end,

	-- ccls-specific keymaps
	on_attach = function(client, bufnr)
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- ccls navigation commands
		vim.keymap.set("n", "<leader>ch", "<cmd>CclsCallHierarchy<cr>", opts)
		vim.keymap.set("n", "<leader>ci", "<cmd>CclsInheritanceHierarchy<cr>", opts)
		vim.keymap.set("n", "<leader>cm", "<cmd>CclsMemberHierarchy<cr>", opts)
		vim.keymap.set("n", "gb", "<cmd>CclsBase<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>CclsDerived<cr>", opts)
		vim.keymap.set("n", "gc", "<cmd>CclsCallers<cr>", opts)
		vim.keymap.set("n", "gC", "<cmd>CclsCallees<cr>", opts)
	end,
}
