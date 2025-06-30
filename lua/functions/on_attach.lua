-- lua/config/lsp/on_attach.lua
return function(client, bufnr)
	-- Buffer-local mappings here, eg. require("config.keymaps").lsp_mappings(bufnr)
	-- Inlay hints, etc.

	if
		vim.bo[bufnr].filetype ~= "c"
		and vim.bo[bufnr].filetype ~= "h"
		and vim.bo[bufnr].filetype ~= "md"
		and client.supports_method("textDocument/formatting")
	then
		local group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = false })
		vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(lsp_client)
						if package.loaded["null-ls"] and lsp_client.name == "null-ls" then
							return true
						end
						return lsp_client.name ~= "null-ls"
					end,
				})
			end,
		})
	end
end
