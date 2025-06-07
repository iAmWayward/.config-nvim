-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.lsp.enable({
	"ts_ls",
	"clangd",
	"lua_ls",
	"pyright",
	"bashls",
	"tailwindcss",
	"html",
	"eslint",
	"vimls",
	"docker_compose_language_service",
	"dockerls",
	"cssls",
	"css_variables",
	"cssmodules_ls",
	"diagnosticls",
	"helm_ls",
})
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.o.winborder = "rounded"
-- vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true })
-- vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true })
-- vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true })

vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Updated for 0.11

vim.o.signcolumn = "yes"
vim.o.number = true
vim.opt.statuscolumn = [[%=%l %s]]
-- vim.cmd.set = "termguicolors"
vim.opt.termguicolors = true
vim.o.shell = "fish"

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2 -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2 -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2 -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
--
vim.opt.splitbelow = true -- New splits open below
vim.opt.splitright = false
-- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })

vim.diagnostic.config({
	virtual_text = {
		true,
		-- { suffix = " ■" }
	},
	virtual_lines = {
		true,
		-- current_line = true,
	},
	underline = true,
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.o.completeopt = "menu,menuone,noinsert,fuzzy"
vim.g.copilot_no_tab_map = true

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local lsp_maps = require("config.keymaps").lsp_mappings(bufnr)
		require("legendary").keymaps(lsp_maps)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Inlay Hints
		-- if client.server_capabilities.inlayHintProvider then
		-- 	vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		-- end

		-- Completion
		vim.lsp.completion.enable(nil, args.data.client_id, bufnr, { autotrigger = true })

		-- Highlight under cursor (only if the client supports it)
		if client.server_capabilities.documentHighlightProvider then
			local highlight_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })

			-- Highlight references when the cursor is held
			vim.api.nvim_create_autocmd("CursorHold", {
				group = highlight_group,
				buffer = bufnr,
				callback = function()
					-- Silently try to highlight, don't show errors/notifications
					pcall(vim.lsp.buf.document_highlight)
				end,
			})

			-- Clear highlights when the cursor moves
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = highlight_group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end
	end,
})

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "tokyonight" } },
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
