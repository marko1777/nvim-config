return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local custom_catppuccin = require("lualine.themes.catppuccin")
		custom_catppuccin.normal.c.fg = "#bfbfbf"
		require("lualine").setup({
			options = {
				theme = custom_catppuccin,
			},

			sections = {
				lualine_b = {
					{
						"branch",
						fmt = function(str)
							return string.sub(str, 1, 8)
						end,
					},
					"diagnostics",
				},
				lualine_c = {
					{
						"filename",
						file_status = true, -- Displays file status (readonly status, modified status)
						newfile_status = true, -- Display new file status (new file means no write after created)
						path = 1,

						shorting_target = 30, -- Shortens path to leave 40 spaces in the window
						-- for other components. (terrible name, any suggestions?)
						symbols = {
							modified = "[+]", -- Text to show when the file is modified.
							readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
							unnamed = "[No Name]", -- Text to show for unnamed buffers.
							newfile = "[New]", -- Text to show for newly created file before first write
						},
					},
				},
				lualine_x = { "encoding", "filetype" },
				lualine_y = {},
			},
		})
	end,
}
