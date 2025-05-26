return {
	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({})
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		name = "plenary",
	},
	{

		"tpope/vim-obsession",
		name = "vim-obsession",
	},
	{
		"RishabhRD/nvim-cheat.sh",
		dependencies = {
			"RishabhRD/popfix",
		},
		name = "nvim-cheat.sh",
	},
	{
		"jmbuhr/otter.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
		keys = {
			vim.keymap.set("n", "<leader>o", ":lua require'otter'.activate()<CR>"),
		},
		config = function() end,
	},
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	name = "indent-blankline.nvim",
	-- 	config = function()
	-- 		require("ibl").setup({
	-- 			scope = { enabled = false },
	-- 		})
	-- 	end,
	-- },
	-- install with yarn or npm
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		--@module 'render-markdown'
		--@type render.md.UserConfig
		config = function()
			require("render-markdown").setup({
				latex = { enabled = false },
				-- preset = 'none',
				-- code = {
				-- 	disable_background = {}
				-- },
			})
		end,
	},
	{
		"tpope/vim-sleuth",
		-- config = function()
		-- 	require("vim-sleuth").setup({})
		-- end,
	},
	{
		"fei6409/log-highlight.nvim",
		config = function()
			require("log-highlight").setup({})
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"nvim-pack/nvim-spectre",
		key = {
			vim.keymap.set("n", "<leader>Ss", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			}),
			vim.keymap.set("n", "<leader>Sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			}),
			vim.keymap.set("v", "<leader>Sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			}),
			vim.keymap.set("n", "<leader>Sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			}),
		},
	},
}
