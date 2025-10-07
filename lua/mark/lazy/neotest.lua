return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			{
				"nvim-treesitter/nvim-treesitter",
				branch = "main",
				-- commit = "5a70b1eb8cbdf6c7f0a59dfb7356ad198421b620",
				build = function()
					vim.cmd(":TSUpdate go")
				end,
			},
			"marilari88/neotest-vitest",
			"nvim-neotest/neotest-plenary",
			-- "alfaix/neotest-gtest",
			"nvim-neotest/nvim-nio",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				dependencies = {
					"andythigpen/nvim-coverage", -- Added dependency
				},
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait() -- Optional, but recommended
				end,
			},
		},
		config = function()
			local neotest_golang_opts = { -- Specify configuration
				runner = "go",
				go_test_args = {
					"-v",
					"-race",
					"-count=1",
					"-timeout=30s",
					"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
				},
			}

			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-vitest"),
					require("neotest-golang")(neotest_golang_opts),
					-- require("neotest-gtest").setup({}),
					require("neotest-plenary").setup({
						-- min_init = "./scripts/tests/minimal.vim",
					}),
				},
			})
		end,
		keys = {
			{
				"<leader>tm",
				function()
					require("neotest").run.stop()
				end,
				desc = "[t]est ter[m]inate",
			},

			{
				"<leader>to",
				function()
					require("neotest").output.open({ enter = true })
				end,
				desc = "Output test",
			},
			{
				"<leader>tO",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "[t]est [O]utput panel",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test Summary",
			},
			-- vim.keymap.set("n", "<leader>tw", function()
			-- 	require("neotest").watch.toggle()
			-- end, {desc = "Watch files"})
			{
				"<leader>tc",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>td",
				function()
					require("neotest").run.run({ suite = false, strategy = "dap" })
				end,
				desc = "Debug nearest test",
			},
		},
	},
}
