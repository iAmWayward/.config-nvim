local M = {}

local exclude = {
	["neo-tree"] = true,
	["sagaoutline"] = true,
}

--- Toggle diagnostics below your "real" code window.
function M.toggle_below()
	local cur = vim.api.nvim_get_current_win()
	local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(cur), "filetype")

	-- if we’re in an excluded pane, find another window:
	if exclude[ft] then
		for _, w in ipairs(vim.api.nvim_list_wins()) do
			local b = vim.api.nvim_win_get_buf(w)
			local f = vim.api.nvim_buf_get_option(b, "filetype")
			if not exclude[f] then
				cur = w
				break
			end
		end
	end

	-- now toggle Trouble diagnostics in a bottom split of `cur`
	require("trouble").toggle({
		mode = "workspace_diagnostics",
		win = {
			relative = "win",
			position = "bottom",
			-- point at that window
			win = cur,
		},
		-- don't move focus away from your code
		focus = false,
	})
end

return M
