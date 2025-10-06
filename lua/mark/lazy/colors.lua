function ColorMyPencils(color)
	-- color = color or "rose-pine-moon"
	-- color = color or "one_monokai"
	color = color or "catppuccin-frappe"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
	{
		"cpea2506/one_monokai.nvim",
		name = "one_monokai",
		enabled = false,
		config = function()
			require("one_monokai").setup({
				transparent = true, -- enable transparent window
				colors = {
					lmao = "#ffffff", -- add new color
					pink = "#ec6075", -- replace default color
				},
				themes = function(colors)
					-- change highlight of some groups,
					-- the key and value will be passed respectively to "nvim_set_hl"
					return {
						Normal = { bg = colors.lmao },
						DiffChange = { fg = colors.white:darken(0.3) },
						ErrorMsg = { fg = colors.pink, standout = true },
						["@lsp.type.keyword"] = { link = "@keyword" },
					}
				end,
				italics = false, -- disable italics
			})
			-- vim.cmd("colorscheme one_monokai")

			ColorMyPencils()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				-- auto_integrations = true,
				transparent_background = true, -- disables setting the background color.
				custom_highlights = function(colors)
					return {
						["@variable.member"] = { fg = colors.text }, -- Change to desired color
						["@property"] = { fg = "#f5bde6" }, -- Alternative capture group
					}
				end,
				blink_cmp = {
					style = "bordered",
				},
				styles = {
					comments = { "italic" },
				},
				color_overrides = {
					all = {
						text = "#ffffff",
					},
					latte = {
						base = "#ff0000",
						mantle = "#242424",
						crust = "#474748",
					},
					frappe = {},
					macchiato = {},
					mocha = {},
				},
				default_integrations = false,
			})

			ColorMyPencils()
		end,
	},
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		require("rose-pine").setup({
	-- 			-- disable_background = true,
	-- 			dim_inactive_windows = false,
	-- 			styles = {
	-- 				italic = false,
	-- 			},
	-- 		})
	--
	-- 		-- vim.cmd("colorscheme rose-pine")
	-- 		-- vim.cmd("colorscheme rose-pine-moon")
	-- 		--
	-- 		ColorMyPencils()
	-- 	end,
	-- },
}
