return {

	{
		"nvim-lua/plenary.nvim",
		name = "plenary"
	},
	{

		'tpope/vim-obsession',
		name = 'vim-obsession'
	},
	{
		'RishabhRD/nvim-cheat.sh',
		dependencies = {
			'RishabhRD/popfix',
		},
		name = 'nvim-cheat.sh'
	},
	{
		'jmbuhr/otter.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>o", ":lua require'otter'.activate()<CR>")
		end
	},

	-- {
	--     "folke/zen-mode.nvim",
	-- }
	-- "eandrju/cellular-automaton.nvim",
}
