return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
	},
	build = ":TSUpdate",
	branch = 'master',
	config = function()
		require("treesitter-context").setup({
			max_lines = 1,
			multiline_threshold = 2,
		})
		-- vim.api.nvim_set_hl(0, "@variable.parameter.go", { link = "@variable" })

		require("nvim-treesitter.configs").setup({
			modules = {},
			-- A list of parser names, or "all"
			ensure_installed = {
				"vimdoc",
				"javascript",
				"make",
				"c",
				"cpp",
				"go",
				"lua",
				"rust",
				"jsdoc",
				"bash",
			},
			ignore_install = { "json" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
			auto_install = true,

			indent = {
				enable = true,
			},

			additional_vim_regex_highlighting = { "markdown" },

			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				disable = function(_, buf)
					local max_filesize = 3 * 1024 * 1024 -- 10 MB
					local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
					if ok and size and size > max_filesize then
						vim.notify(
							"File larger than 100KB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						return true
					end
				end,
			},
		})

		local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		treesitter_parser_config.templ = {
			install_info = {
				url = "https://github.com/vrischmann/tree-sitter-templ.git",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
		}

		vim.treesitter.language.register("templ", "templ")
	end,
}
