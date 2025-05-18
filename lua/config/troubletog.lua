-- local M = {}
--
-- local exclude = {
-- 	["neo-tree"] = true,
-- 	["sagaoutline"] = true,
-- 	["Avante"] = true,
-- 	["AvanteSelectedFiles"] = true,
-- 	["AvanteInput"] = true,
-- }
--
-- --- Toggle diagnostics below your "real" code window.
-- function M.toggle_below()
-- 	local cur = vim.api.nvim_get_current_win()
-- 	local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(cur), "filetype")
--
-- 	-- if we’re in an excluded pane, find another window:
-- 	if exclude[ft] then
-- 		for _, w in ipairs(vim.api.nvim_list_wins()) do
-- 			local b = vim.api.nvim_win_get_buf(w)
-- 			local f = vim.api.nvim_buf_get_option(b, "filetype")
-- 			if not exclude[f] then
-- 				cur = w
-- 				break
-- 			end
-- 		end
-- 	end
--
-- 	-- now toggle Trouble diagnostics in a bottom split of `cur`
-- 	require("trouble").toggle({
-- 		mode = "diagnostics",
-- 		win = {
-- 			relative = "win",
-- 			position = "bottom",
-- 			-- point at that window
-- 			win = cur,
-- 		},
-- 		-- don't move focus away from your code
-- 		focus = false,
-- 	})
-- end
--
-- return M
--

local M = {}

local exclude = {
	["neo-tree"] = true,
	["sagaoutline"] = true,
	["Avante"] = true,
	["AvanteSelectedFiles"] = true,
	["AvanteInput"] = true,
}

-- Keep track of last used target window
local function get_target_window()
	local cur = vim.api.nvim_get_current_win()
	local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(cur), "filetype")

	if exclude[ft] then
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			local b = vim.api.nvim_win_get_buf(w)
			local f = vim.api.nvim_buf_get_option(b, "filetype")
			if not exclude[f] then
				return w
			end
		end
	end

	return cur
end

function M.toggle_below()
	local win = get_target_window()

	-- Close toggleterm if visible
	local term = require("toggleterm.terminal").get(1)
	if term and term:is_open() then
		term:close()
	end

	-- Toggle Trouble diagnostics under target win
	require("trouble").toggle({
		mode = "diagnostics",
		win = {
			relative = "win",
			position = "bottom",
			win = win,
		},
		focus = false,
	})
end

function M.toggle_term_below()
	local Terminal = require("toggleterm.terminal").Terminal

	-- Close Trouble if open
	local trouble = require("trouble")
	if trouble.is_open() then
		trouble.close()
	end

	-- Create or get terminal
	local term = Terminal:new({
		direction = "horizontal",
		id = 1,
		on_open = function()
			vim.cmd("startinsert")
		end,
	})

	-- Use win_call to run toggle in correct window
	local target_win = get_target_window()
	vim.api.nvim_win_call(target_win, function()
		term:toggle()
	end)
end

return M
