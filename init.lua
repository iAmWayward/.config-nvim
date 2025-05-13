require("config.lazy")
--
vim.o.cmdheight = 0
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.signcolumn = "yes"
vim.o.number = true
vim.opt.statuscolumn = [[%=%l %s]]
vim.cmd.set = "termguicolors"
-- vim.o.shell = "/usr/bin/fish"

-- vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2     -- Number of spaces a TAB displays as
vim.opt.shiftwidth = 2  -- Number of spaces for auto-indent and >>/<< operations
vim.opt.softtabstop = 2 -- Number of spaces for <Tab> key in insert mode

vim.opt.linebreak = true
--
vim.opt.splitbelow = true -- New splits open below
vim.opt.splitright = false

-- If the current system shell or the `shell` option is set to /usr/bin/fish then revert to sh
if os.getenv("SHELL") == "/usr/bin/fish" or vim.opt.shell == "/usr/bin/fish" then
	vim.opt.shell = "/bin/sh"
else
	-- Else default to the system current shell.
	vim.opt.shell = os.getenv("SHELL")
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "sagaoutline",
	callback = function(args)
		vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "sagaoutline",
-- 	callback = function(args)
-- 		-- Prevent the window from being automatically resized
-- 		vim.wo[args.win].winfixheight = true
-- 		vim.wo[args.win].winfixwidth = true
-- 		-- Optional: Try setting nobuflisted here as well or instead of BufWinEnter
-- 		vim.bo[args.buf].buflisted = false
-- 		-- Optional: Make the buffer delete itself when hidden (use with caution)
-- 		-- vim.bo[args.buf].bufhidden = 'wipe'
-- 	end,
-- 	desc = "Set window options for Lspsaga Outline",
-- })
--
-- function is_plugin_buffer(ft)
-- 	local plugin_filetypes = {
-- 		"neo-tree", -- Neo-tree filetype
-- 		"Trouble", -- Trouble.nvim filetype
-- 		"lspsagaoutline", -- Lspsaga outline (adjust if different)
-- 		-- Add other plugin filetypes as needed
-- 	}
-- 	return vim.tbl_contain(plugin_filetypes, ft)
-- end
--
-- vim.api.nvim_create_autocmd("BufDelete", {
-- 	desc = "Return to code window after closing plugin buffers",
-- 	callback = function(args)
-- 		local buf = args.buf
-- 		local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
--
-- 		if is_plugin_buffer(buf_ft) then
-- 			-- Iterate through all windows to find a non-plugin window
-- 			for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 				local win_buf = vim.api.nvim_win_get_buf(win)
-- 				local win_ft = vim.api.nvim_buf_get_option(win_buf, "filetype")
--
-- 				if not is_plugin_buffer(win_ft) then
-- 					vim.api.nvim_set_current_win(win) -- Switch to the code window
-- 					return
-- 				end
-- 			end
-- 		end
-- 	end,
-- })
