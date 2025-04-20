local M = {}

function M.set_kitty_colors()
	local function get_hl(name)
		local hl = vim.api.nvim_get_hl_by_name(name, true)
		if not hl then
			return {}
		end
		return {
			bg = hl.background and string.format("#%06x", hl.background) or nil,
			fg = hl.foreground and string.format("#%06x", hl.foreground) or nil,
		}
	end

	local colors = {
		normal = get_hl("Normal"),
		comment = get_hl("Comment"),
		cursorline = get_hl("CursorLine"),
		visual = get_hl("Visual"),
		error = get_hl("Error"),
		constant = get_hl("Constant"),
	}

	local kitty_colors = string.format(
		[[
    foreground %s
    background %s
    cursor %s
    cursor_text_color %s
    selection_foreground %s
    selection_background %s
    color0 %s
    color8 %s
    color1 %s
    color9 %s
    color2 %s
    color10 %s
    color3 %s
    color11 %s
    color4 %s
    color12 %s
    color5 %s
    color13 %s
    color6 %s
    color14 %s
    color7 %s
    color15 %s
  ]],
		colors.normal.fg or "#ffffff",
		colors.normal.bg or "#000000",
		colors.visual.fg or "#ffffff",
		colors.normal.bg or "#000000",
		colors.normal.fg or "#ffffff",
		colors.visual.bg or "#333333",
		colors.constant.bg or "#2e3436",
		colors.comment.fg or "#555555",
		colors.error.fg or "#ff0000",
		colors.error.fg or "#ff4444",
		colors.constant.fg or "#00ff00",
		colors.constant.fg or "#44ff44",
		colors.comment.fg or "#ffff00",
		colors.comment.fg or "#ffff44",
		colors.cursorline.bg or "#0000ff",
		colors.cursorline.bg or "#4444ff",
		colors.visual.fg or "#ff00ff",
		colors.visual.fg or "#ff44ff",
		colors.constant.fg or "#00ffff",
		colors.constant.fg or "#44ffff",
		colors.normal.fg or "#ffffff",
		colors.normal.fg or "#ffffff"
	)

	local tempfile = os.tmpname() .. ".conf"
	local f = io.open(tempfile, "w")
	f:write(kitty_colors)
	f:close()

	vim.fn.system("kitty @ --to unix:/tmp/kitty set-colors --all --configured " .. tempfile)
	os.remove(tempfile)
end

return M
