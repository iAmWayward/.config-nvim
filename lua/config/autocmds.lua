-- lua/config/autocmds.lua
-- Project scratch view on `nvim .` now lives in the scratchview.nvim plugin.

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		-- Buffer-local LSP keymaps
		require("config.keymaps").lsp_mappings(bufnr)

		-- Auto-format on save (skips C/C++ and Markdown; handled in on_attach.lua)
		require("functions.on_attach")(client, bufnr)

		-- Document highlight on cursor hold (only if the server supports it)
		if client.server_capabilities.documentHighlightProvider then
			local group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
			vim.api.nvim_create_autocmd("CursorHold", {
				group = group,
				buffer = bufnr,
				callback = function()
					pcall(vim.lsp.buf.document_highlight)
				end,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				group = group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end
	end,
})
