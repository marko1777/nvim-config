return {
	"nvim-treesitter/nvim-treesitter",
	-- dependencies = {
	-- 	"nvim-treesitter/nvim-treesitter-context",
	-- },
	build = ":TSUpdate",
	branch = "main",
	config = function()
		-- require("treesitter-context").setup({
		-- 	max_lines = 1,
		-- 	multiline_threshold = 2,
		-- })
		-- vim.api.nvim_set_hl(0, "@variable.parameter.go", { link = "@variable" })

		require("nvim-treesitter").setup({
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			-- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
			auto_install = true,

			indent = {
				enable = true,
			},

			highlight = {
				-- `false` will disable the whole extension
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
				disable = function(_, buf)
					local max_filesize = 3 * 1024 * 1024 -- 3 MB
					local ok, size = pcall(vim.fn.getfsize, vim.api.nvim_buf_get_name(buf))
					if ok and size and size > max_filesize then
						vim.notify(
							"File larger than 3MB treesitter disabled for performance",
							vim.log.levels.WARN,
							{ title = "Treesitter" }
						)
						return true
					end
				end,
			},

			vim.api.nvim_create_autocmd("FileType", {
				desc = "User: enable treesitter highlighting",
				callback = function(ctx)
					-- highlights
					local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

					-- indent
					local noIndent = {}
					if hasStarted and not vim.list_contains(noIndent, ctx.match) then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			}),

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" })
				end,
			}),

			-- Set immediately as well
			vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" }),
		})

		-- Main branch uses ensure_installed as a separate call
		vim.treesitter.language.register("bash", "sh")

		local parsers = {
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
		}

		vim.cmd("TSInstall " .. table.concat(parsers, " "))
	end,
}
