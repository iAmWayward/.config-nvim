return {
	-- {
	-- 	"github/copilot.vim",
	-- 	event = "VeryLazy",
	-- },
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			provider = "openai", -- ollama , aihubmix,
			providers = {
				openai = {
					endpoint = "https://api.openai.com/v1",
					model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
					timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
					-- temperature = 0,
					-- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					--reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
				},
			},
			rag_service = {
				enabled = false, -- Enables the RAG service
				host_mount = os.getenv("HOME"), -- Host mount path for the rag service
				provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
				llm_model = "", -- The LLM model to use for RAG service
				embed_model = "", -- The embedding model to use for RAG service
				endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
			},
			-- web_search_engine = {
			-- 	provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
			-- 	proxy = nil,     -- proxy support, e.g., http://127.0.0.1:7890
			-- },
		},
		build = function()
			-- conditionally use the correct build system for the current OS
			if vim.fn.has("win32") == 1 then
				return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
			else
				return "make"
			end
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"MeanderingProgrammer/render-markdown.nvim",
			-- "zbirenbaum/copilot.lua", -- for providers='copilot'
		},
		config = function()
			require("avante").setup({
				-- system_prompt as function ensures LLM always has latest MCP server state
				-- This is evaluated for every message, even in existing chats
				system_prompt = function()
					local hub = require("mcphub").get_hub_instance()
					return hub and hub:get_active_servers_prompt() or ""
				end,
				-- Using function prevents requiring mcphub before it's loaded
				custom_tools = function()
					return {
						require("mcphub.extensions.avante").mcp_tool(),
					}
				end,
			})
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
		config = function()
			require("mcphub").setup()
		end,
	},
}
