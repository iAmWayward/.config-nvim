-- lua/functions/on_attach.lua
-- Called from LspAttach autocmd for every attaching client.
-- Registers format-on-save for supported filetypes (skips C/C++ and Markdown).
return function(client, bufnr)
	local ft = vim.bo[bufnr].filetype
	-- if ft == "c" or ft == "h" or ft == "md" then
	-- return
	-- end
	if not client.supports_method("textDocument/formatting") then
		return
	end

	local group = vim.api.nvim_create_augroup("LspAutoFormat_" .. bufnr, { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = group,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({
				bufnr = bufnr,
				filter = function(lsp_client)
					-- Prefer none-ls (null-ls) when it is attached to this buffer
					local null_ls_clients = vim.lsp.get_clients({ name = "null-ls", bufnr = bufnr })
					if #null_ls_clients > 0 then
						return lsp_client.name == "null-ls"
					end
					return true
				end,
			})
		end,
	})
end
