return {
	"HiPhish/rainbow-delimiters.nvim",

	config = function()
		local rainbow_delimiters = require("rainbow-delimiters.setup")

		rainbow_delimiters.setup({
			strategy = {
				-- [''] = rainbow_delimiters.strategy['global'],
				-- vim = rainbow_delimiters.strategy['local'],
			},
			condition = function(buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
				if ok and size and size > max_filesize then
					vim.notify(
						"File larger than 100KB rainbow_delimiters disabled for performance",
						vim.log.levels.WARN,
						{ title = "Rainbow Delimiters" }
					)
					return false
				end
				return true
			end,

			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		})
	end,
}
