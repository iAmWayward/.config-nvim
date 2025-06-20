vim.deprecate = function() end -- Shut up about deprecations
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
	pattern = "AvanteLoaded", -- Create a custom event in Avante's setup
	callback = function()
		-- Define your command here
	end,
})
