require("one_monokai").setup({
    -- your options
})

function ColorMyPencils(color)
	color = color or "one_monokai"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

ColorMyPencils('one_monokai')
-- ColorMyPencils()
