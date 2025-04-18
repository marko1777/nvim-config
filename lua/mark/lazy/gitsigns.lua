return {
	"lewis6991/gitsigns.nvim",
	-- enabled = false,
	keys = {
		vim.keymap.set("n", "<leader>gb", ":Gitsigns blame<CR>"),
		vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>"),
		vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>"),
	},
	config = function()
		require("gitsigns").setup({ signcolumn = false })

	end,
}
