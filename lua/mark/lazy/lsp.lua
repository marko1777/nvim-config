return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
		-- "hrsh7th/cmp-nvim-lua",
		-- "hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
		-- "hrsh7th/nvim-cmp",
		"saghen/blink.cmp",
		{ "rafamadriz/friendly-snippets" },
		-- "L3MON4D3/LuaSnip",
		-- "saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls.nvim",
	},
	lazy = { true },
	event = { "BufReadPost", "BufNewFile" },

	config = function()
		-- local cmp = require("cmp")
		-- local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		-- local capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	{},
		-- 	vim.lsp.protocol.make_client_capabilities(),
		-- 	blink_lsp.capabilities
		-- 	-- cmp_lsp.default_capabilities()
		-- )
		-- local capabilities = cmp_lsp.default_capabilities()

		local servers = {
			clangd = {
				-- cmd = {
				-- 	"clangd",
				-- },
			},
			gopls = {
				settings = {
					gopls = {
						buildFlags = { "-tags=e2e" },
					},
				},
			},

			-- pyright = {},
			-- rust_analyzer = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			--
			-- But for many setups, the LSP (`ts_ls`) will work just fine
			-- ts_ls = {},
			--

			lua_ls = {
				-- cmd = { ... },
				-- filetypes = { ... },
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						-- diagnostics = { disable = { 'missing-fields' } },
					},
				},
			},
		}

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = false,
			ensure_installed = {
				"lua_ls",
				-- "rust_analyzer",
				"gopls",
				"pyright",
				"clangd",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					local server = servers[server_name] or {}

					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
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
			automatic_installation = false,
			ensure_installed = {
				"stylua",
				"jq",
				"goimports",
				"gotest",
				"golines",
				"clang-format",
				-- "prettier",
				"black",
			},
		})

		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				-- null_ls.builtins.completion.spell,

				null_ls.builtins.formatting.black.with({
					filetypes = { "python" },
				}),
			},
		})

		-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
		--
		-- cmp.setup({
		-- 	snippet = {
		-- 		expand = function(args)
		-- 			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		-- 		end,
		-- 	},
		-- 	mapping = cmp.mapping.preset.insert({
		-- 		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		-- 		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		-- 		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		-- 		["<C-Space>"] = cmp.mapping.complete(),
		-- 		["<CR>"] = cmp.mapping.confirm({
		-- 			behavior = cmp.ConfirmBehavior.Replace,
		-- 			select = true,
		-- 		}),
		-- 		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 		-- 	local luasnip = require("luasnip")
		-- 		-- 	if luasnip.expand_or_jumpable() then
		-- 		-- 		luasnip.expand_or_jump()
		-- 		-- 	else
		-- 		-- 		fallback()
		-- 		-- 	end
		-- 		-- end, { "i", "s" }),
		-- 	}),
		--
		-- 	sources = cmp.config.sources({
		-- 		{ name = "nvim_lsp" },
		-- 		{ name = "nvim_lua" },
		-- 		-- { name = "path" },
		-- 		{ name = "luasnip" }, -- For luasnip users.
		-- 	}, {
		-- 		{ name = "buffer", keyword_length = 5 },
		-- 	}),
		-- })
		--
		-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline({ "/", "?" }, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = {
		-- 		{ name = "buffer" },
		-- 	},
		-- })
		--
		-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(":", {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = cmp.config.sources({
		-- 		{ name = "path" },
		-- 	}, {
		-- 		{ name = "cmdline" },
		-- 	}),
		-- 	matching = { disallow_symbol_nonprefix_matching = false },
		-- })
		--
		vim.diagnostic.config({
			virtual_text = true,
			-- virtual_lines = true,
		})
		-- 	-- update_in_insert = true,
		-- 	float = {
		-- 		-- severity = vim.diagnostic.severity.ERROR,
		-- 		focusable = false,
		-- 		style = "minimal",
		-- 		border = "rounded",
		-- 		source = "always",
		-- 		header = "",
		-- 		prefix = "",
		-- 	},
		-- })
		--
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
