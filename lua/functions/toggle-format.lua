-- lua/functions/toggle-format.lua
-- Tracks whether format-on-save is enabled globally.
local M = {}

M._enabled = false

function M.is_enabled()
	return M._enabled
end

function M.toggle()
	M._enabled = not M._enabled
	local state = M._enabled and "enabled" or "disabled"
	vim.notify("Format on save " .. state, vim.log.levels.INFO, { title = "Formatting" })
end

return M
