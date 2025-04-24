return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},

	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", function()
			builtin.find_files({ no_ignore = true })
		end, { desc = "find files" })

		vim.keymap.set("n", "<leader>pF", function()
			builtin.find_files({
				search_dirs = { vim.fn.input("Dir > ") },
				no_ignore = true,
			})
		end, { desc = "find files in dir" })

		vim.keymap.set("n", "<leader>Fp", function()
			local dir = vim.fn.input("Dir > ")
			require("telescope.builtin").find_files({
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--glob",
					"!.git/*",
					"--glob",
					"!**/" .. dir .. "/*",
				},
			})
		end, { desc = "Find Files excl dir" })

		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "grep string" })
		vim.keymap.set("n", "<leader>pS", function()
			builtin.live_grep({ glob_pattern = vim.fn.input("FileTypes > ") })
		end, { desc = "grep string in file types" })
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
		require("telescope").load_extension("ui-select")
	end,
}
