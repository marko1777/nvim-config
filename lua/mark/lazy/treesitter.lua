local function install_and_start()
	-- Auto-install and start treesitter parser for any buffer with a registered filetype
	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		callback = function(event)
			local bufnr = event.buf
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

			-- Skip if no filetype
			if filetype == "" then
				return
			end

			-- Get parser name based on filetype
			local parser_name = vim.treesitter.language.get_lang(filetype) -- WARNING: might return filetype (not helpful)
			if not parser_name then
				-- vim.notify(
				--   "Filetype " .. vim.inspect(filetype) .. " has no parser registered",
				--   vim.log.levels.WARN,
				--   { title = "core/treesitter" }
				-- )
				return
			end

			-- vim.notify(
			--   vim.inspect("Successfully got parser " .. parser_name .. " for filetype " .. filetype),
			--   vim.log.levels.DEBUG,
			--   { title = "core/treesitter" }
			-- )

			-- Check if parser_name is available in parser configs
			local parser_configs = require("nvim-treesitter.parsers")
			local parser_can_be_used = nil
			if branch == "master" then
				parser_can_be_used = parser_configs.list[parser_name]
			elseif branch == "main" then
				parser_can_be_used = parser_configs[parser_name]
			end
			if not parser_can_be_used then
				-- vim.notify(
				--   "Parser config does not have parser " .. vim.inspect(parser_name) .. ", skipping",
				--   vim.log.levels.WARN,
				--   { title = "core/treesitter" }
				-- )
				return -- Parser not ailable, skip silently
			end

			local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

			-- If not installed, install parser synchronously
			if not parser_installed then
				require("nvim-treesitter").install({ parser_name }):wait(30000) -- main branch syntax
			end

			-- Check so tree-sitter can see the newly installed parser
			parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)
			if not parser_installed then
				vim.notify(
					"Failed to get parser for " .. parser_name .. " after installation",
					vim.log.levels.WARN,
					{ title = "core/treesitter" }
				)
				return
			end

			-- Start treesitter for this buffer
			vim.treesitter.start(bufnr, parser_name)
		end,
	})
end
return {
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",
	branch = "main",
	config = function()
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

			install_and_start(),
		})

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
				-- vim.bo[bufnr].syntax = "on" -- Use regex based syntax-highlighting as fallback as some plugins might need it
				-- vim.wo.foldlevel = 99
				-- vim.wo.foldmethod = "expr"
				-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folds
				-- vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Use treesitter for indentation
			end,
		})

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" })
			end,
		})

		-- Set immediately as well
		vim.api.nvim_set_hl(0, "@variable.parameter", { link = "@variable" })

		-- Main branch uses ensure_installed as a separate call
		vim.treesitter.language.register("bash", "sh")

		-- vim.defer_fn(function()
		-- 	require("nvim-treesitter").install(ensure_installed)
		-- end, 1000)
		require("nvim-treesitter").update()
		--- Install and start parsers for nvim-treesitter.
	end,
}
