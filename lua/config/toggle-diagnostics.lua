local M = {}

-- States: 1 = virtual_text, 2 = virtual_lines, 3 = neither
local states = {
	{ virtual_text = true, virtual_lines = false, desc = "Diagnostics: Inline" },
	{ virtual_text = false, virtual_lines = true, desc = "Diagnostics: Virtual Lines" },
	{ virtual_text = false, virtual_lines = false, desc = "Diagnostics: Off" },
}

local current = 1

function M.cycle()
	current = current % #states + 1
	vim.diagnostic.config({
		virtual_text = states[current].virtual_text,
		virtual_lines = states[current].virtual_lines,
	})
	vim.notify(states[current].desc, vim.log.levels.INFO, { title = "Diagnostics" })
end

return M
