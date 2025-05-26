return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = true,
	keys = {
		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("telescope").extensions.refactoring.refactors()
		end, { desc = "Refactor option" }),

		-- Extract function supports only visual mode
		vim.keymap.set("x", "<leader>re", function()
			require("refactoring").refactor("Extract Function")
		end, { desc = "Extract function" }),
		vim.keymap.set("x", "<leader>rfe", function()
			require("refactoring").refactor("Extract Function To File")
		end, { desc = "Extract function to file" }),

		-- Extract variable supports only visual mode
		vim.keymap.set("x", "<leader>rv", function()
			require("refactoring").refactor("Extract Variable")
		end, { desc = "Extract variable" }),

		-- Inline func supports only normal
		vim.keymap.set("n", "<leader>rI", function()
			require("refactoring").refactor("Inline Function")
		end, { desc = "Inline function" }),

		-- Inline var supports both normal and visual mode
		vim.keymap.set({ "n", "x" }, "<leader>ri", function()
			require("refactoring").refactor("Inline Variable")
		end, { desc = "Inline Variable" }),

		-- Extract block supports only normal mode
		vim.keymap.set("n", "<leader>rb", function()
			require("refactoring").refactor("Extract Block")
		end, { desc = "Extract Block" }),

		vim.keymap.set("n", "<leader>rfb", function()
			require("refactoring").refactor("Extract Block To File")
		end, { desc = "Extract Block To File" }),
	},
	config = function()
		require("refactoring").setup({
			prompt_func_return_type = {
				go = true,
				cpp = true,
				h = true,
				hpp = true,
				cxx = true,
			},
			prompt_func_param_type = {
				go = true,
				cpp = true,
				h = true,
				hpp = true,
				cxx = true,
			},
			show_success_message = true,

			-- load refactoring Telescope extension
			require("telescope").load_extension("refactoring"),
		})
	end,
}
