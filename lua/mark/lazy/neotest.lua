return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-plenary",
			"alfaix/neotest-gtest",
			"nvim-neotest/nvim-nio",
			{ "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
		},
		config = function()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-golang"),
					require("neotest-gtest").setup({}),
					require("neotest-plenary").setup({
						-- min_init = "./scripts/tests/minimal.vim",
					}),
				},
			})

			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open({ enter = true })
			end, { desc = "Output test" })
			vim.keymap.set("n", "<leader>ts", function()
				neotest.summary.toggle()
			end, { desc = "Toggle test Summary" })
			-- vim.keymap.set("n", "<leader>tw", function()
			-- 	neotest.watch.toggle()
			-- end, {desc = "Watch files"})
			vim.keymap.set("n", "<leader>tc", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>td", function()
				require("neotest").run.run({ suite = false, strategy = "dap" })
			end, { desc = "Debug nearest test" })
		end,
	},
}
