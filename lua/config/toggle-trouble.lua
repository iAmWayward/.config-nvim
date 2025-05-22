local M = {}

local exclude = {
	["neo-tree"] = true,
	["sagaoutline"] = true,
	["Avante"] = true,
	["AvanteSelectedFiles"] = true,
	["AvanteInput"] = true,
}

-- Determine the target window to display Trouble below
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

-- General function to toggle Trouble with specified options
local function toggle_trouble(opts)
	local win = get_target_window()
	opts = opts or {}
	opts.win = opts.win or {}
	opts.win.relative = "win"
	opts.win.position = "bottom"
	opts.win.win = win
	opts.focus = false
	require("trouble").toggle(opts)
end

function M.toggle_below()
	-- Close toggleterm if visible
	local term = require("toggleterm.terminal").get(1)
	if term and term:is_open() then
		term:close()
	end

	toggle_trouble({ mode = "diagnostics" })
end

function M.toggle_buffer_diagnostics()
	toggle_trouble({
		mode = "diagnostics",
		filter = { buf = 0 },
	})
end

function M.toggle_symbols()
	toggle_trouble({ mode = "symbols" })
end

function M.toggle_lsp()
	toggle_trouble({ mode = "lsp" })
end

function M.toggle_loclist()
	toggle_trouble({ mode = "loclist" })
end

function M.toggle_implement()
	toggle_trouble({ mode = "lsp_implementations" })
end

function M.toggle_typedef()
	toggle_trouble({ mode = "lsp_type_definitions" })
end

function M.toggle_qflist()
	toggle_trouble({ mode = "qflist" })
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
