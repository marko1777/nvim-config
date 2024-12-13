return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "rust_analyzer",
				"gopls",
				"pyright",
				"clangd",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				["clangd"] = function()
					require("lspconfig").clangd.setup({
						cmd = {
							"clangd",
							-- "--background-index",
							-- "--clang-tidy",
							-- "--header-insertion=iwyu",
							-- "--sync=c++20"
						},
						-- settings = {
						-- 	clangd = {
						-- 		arguments = { "-I/usr/include/" },
						-- 	},
						-- },
					})
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					-- lspconfig.sqlfluff.setup({})

					lspconfig.htmx.setup({})

					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})
		local html_capabilities = vim.lsp.protocol.make_client_capabilities()
		html_capabilities.textDocument.completion.completionItem.snippetSupport = true

		require("lspconfig").html.setup({
			capabilities = html_capabilities,
		})
		require("lspconfig").ts_ls.setup({
			-- filetypes = table.insert(require 'lspconfig'.ts_ls.filetypes, "html")
			filetypes = { "html" },
		})

		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"jq",
				"goimports",
				"golines",
				"clang-format",
				-- "prettier",
				"black",
			},
		})

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.black.with({
					filetypes = { "python" },
				}),
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer", keyword_length = 5 },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				-- severity = vim.diagnostic.severity.ERROR,
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
		-- -- Set the undercurl (underline) only for errors
		vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })

		-- Customize the highlight groups to remove the undercurl for warnings and hints
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = "#FFFF00" }) -- Yellow color for warnings
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = "#90ee90" }) -- Green color for hints
		vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = "#90ee90" }) -- Green color for info
	end,
}
