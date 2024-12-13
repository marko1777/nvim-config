return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },

				javascript = { "prettierd", "prettier", stop_after_first = true },

				html = { "prettierd", "prettier", stop_after_first = true },

				cpp = { "clang_format" },

				go = { "goimports", "gofmt", "golines" },

				sql = { "sql-formatter" },
			},
		})
		require("conform").formatters.golines = {
			append_args = { "-m", "80" },
		}
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	pattern = "*.go",
		-- 	callback = function(args)
		-- 		require("conform").format({ bufnr = args.buf })
		-- 	end,
		-- })
	end,
}
