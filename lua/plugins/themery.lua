return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes       = {
				{
					name = "Tokyo Night",
					colorscheme = "tokyonight",
					-- Include the specific options for your default theme
					before = [[
                        vim.g.tokyonight_style = "night"
                        vim.g.tokyonight_transparent = true
                        vim.g.tokyonight_transparent_sidebar = true
                    ]],
				},
				{
					name = "gruvbox dark",
					colorscheme = "gruvbox",
				},
				{
					name = "ayu",
					colorscheme = "ayu",
				},
			},       -- list of installed colorschemes.
			livePreview  = true, -- Apply theme while picking.
			globalBefore = [[]],
			globalAfter  = [[]],
		})
	end
}
