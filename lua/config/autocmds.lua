-- lua/config/autocmds.lua

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local argv = vim.fn.argv()
		if #argv ~= 1 or vim.fn.isdirectory(argv[1]) == 0 then
			return
		end
		local dir = vim.fn.fnamemodify(argv[1], ":p")

		vim.schedule(function()
			local toplevel = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })[1]
			if vim.v.shell_error ~= 0 or not toplevel or toplevel == "" then
				return
			end

			local target_win
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
				local name = vim.api.nvim_buf_get_name(buf)
				if ft ~= "neo-tree" and name == "" then
					target_win = win
					break
				end
			end
			if not target_win then
				return
			end

			local log_lines = vim.fn.systemlist({
				"git",
				"-C",
				toplevel,
				"log",
				"--oneline",
				"--graph",
				"--decorate",
				"--all",
				"-n",
				"200",
			})
			if vim.v.shell_error ~= 0 then
				return
			end

			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, log_lines)
			vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
			vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
			vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
			vim.api.nvim_set_option_value("filetype", "git", { buf = buf })
			vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
			vim.api.nvim_buf_set_name(buf, "Project Git Log")
			vim.api.nvim_win_set_buf(target_win, buf)
		end)
	end,
})

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
