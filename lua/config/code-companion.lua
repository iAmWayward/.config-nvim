return {
	adapters = {
		deepseek = function()
			return require("codecompanion.adapters").extend("deepseek", {
				env = {
					api_key = "cmd:op read op://personal/DeepSeek_API/credential --no-newline",
				},
			})
		end,
		ollama = function()
			return require("codecompanion.adapters").extend("ollama", {
				schema = {
					num_ctx = {
						default = 50000,
					},
				},
			})
		end,
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = "cmd:op read op://personal/OpenAI_API/credential --no-newline",
				},
				schema = {
					model = {
						default = function()
							return "gpt-4.1-nano"
						end,
					},
				},
			})
		end,
		-- anthropic = function()
		--   return require("codecompanion.adapters").extend("anthropic", {
		--     env = {
		--       api_key = "cmd:op read op://personal/Anthropic_API/credential --no-newline",
		--     },
		--   })
		-- end,
		-- copilot = function()
		--   return require("codecompanion.adapters").extend("copilot", {
		--     schema = {
		--       model = {
		--         default = "gpt-4o",
		--       },
		--     },
		--   })
		-- end,
		--[[ gemini = function() ]]
		--[[   return require("codecompanion.adapters").extend("gemini", { ]]
		--[[     env = { ]]
		--[[       api_key = "cmd:op read op://personal/Gemini_API/credential --no-newline", ]]
		--[[     }, ]]
		--[[   }) ]]
		--[[ end, ]]
	},
	prompt_library = {
		["NextJS Expert"] = {
			strategy = "chat",
			description = "Write typesafe NextJS 15.2 React code.",
			opts = {
				index = 11,
				is_slash_cmd = false,
				auto_submit = false,
				short_name = "docs",
			},
			references = {
				{
					type = "file",
					path = {
						"next.config.ts",
						--[[ "doc/.vitepress/config.mjs", ]]
						--[[ "lua/codecompanion/config.lua", ]]
						"README.md",
					},
				},
			},
			prompts = {
				{
					role = "user",
					content = [[I'm rewriting the documentation for my plugin CodeCompanion.nvim, as I'm moving to a vitepress website. Can you help me rewrite it?

I'm sharing my vitepress config file so you have the context of how the documentation website is structured in the `sidebar` section of that file.

I'm also sharing my `config.lua` file which I'm mapping to the `configuration` section of the sidebar.
]],
				},
			},
		},
		["Test workflow"] = {
			strategy = "workflow",
			description = "Use a workflow to test the plugin",
			opts = {
				index = 4,
			},
			prompts = {
				{
					{
						role = "user",
						content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
						opts = {
							auto_submit = false,
						},
					},
				},
				{
					{
						role = "user",
						content = "Write unit tests for the library class you just created",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Write a recursive algorithm to balance a binary search tree in Java",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Create a Rust struct and implementation for a thread-safe message queue",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Create SQL queries for a complex database schema with joins across 4 tables",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
						opts = {
							auto_submit = true,
						},
					},
				},
				{
					{
						role = "user",
						content = "Generate documentation in JSDoc format for a complex JavaScript API client",
						opts = {
							auto_submit = true,
						},
					},
				},
			},
		},
		-- },
		strategies = {
			chat = {
				adapter = "openai",
				roles = {
					user = "Wayward",
				},
				keymaps = {
					send = {
						modes = {
							i = { "<C-CR>", "<C-s>" },
						},
					},
					completion = {
						modes = {
							i = "<C-x>",
						},
					},
				},
				slash_commands = {
					["buffer"] = {
						opts = {
							--[[ provider = "snacks", ]]
							keymaps = {
								modes = {
									i = "<C-b>",
								},
							},
						},
					},
					["help"] = {
						opts = {
							--[[ provider = "snacks", ]]
							max_lines = 1000,
						},
					},
					["file"] = {
						opts = {
							--[[ provider = "snacks", ]]
						},
					},
					--[[ ["symbols"] = { ]]
					--[[   opts = { ]]
					--[[     provider = "snacks", ]]
					--[[   }, ]]
				},
			},
			tools = {
				vectorcode = {
					description = "Run VectorCode to retrieve the project context.",
					callback = function()
						return require("vectorcode.integrations").codecompanion.chat.make_tool()
					end,
				},
			},
		},
		inline = { adapter = "openai" }, -- { adapter = "ollama" },
	},
	display = {
		action_palette = {
			provider = "telescope", -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
			opts = {
				show_default_actions = true, -- Show the default actions in the action palette?
				show_default_prompt_library = true, -- Show the default prompt library in the action palette?
			},
		},
		chat = {
			adapter = "deepseek",
			-- show_references = true,
			show_header_separator = true,
			-- show_settings = false,
		},
		diff = {
			enabled = true,
			provider = "default", --"mini_diff",
		},

		-- Options to customize the UI of the chat buffer
		window = {
			layout = "vertical", -- float|vertical|horizontal|buffer
			position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
			border = "single",
			height = 0.8,
			width = 0.45,
			relative = "editor",
			full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
			opts = {
				breakindent = true,
				cursorcolumn = false,
				cursorline = false,
				foldcolumn = "0",
				linebreak = true,
				list = false,
				numberwidth = 1,
				signcolumn = "no",
				spell = false,
				wrap = true,
			},
		},
	},
	opts = {
		send_code = false,
		log_level = "DEBUG",
	},
}
