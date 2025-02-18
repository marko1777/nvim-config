return {
	"saghen/blink.cmp",
	enabled = true,

	-- optional: provides snippets for the snippet source
	dependencies = {
		{ "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip" },
		{ "saghen/blink.compat", verson = false },
	},

	version = "*",

	opts = {
		snippets = { preset = "luasnip" },

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "obsidian", "obsidian_new", "obsidian_tags", "markdown" }, -- , "dadbod" },
			providers = {
				markdown = {
					name = "RenderMarkdown",
					module = "render-markdown.integ.blink",
					fallbacks = { "lsp" },
				},
				obsidian = {
					name = "obsidian",
					module = "blink.compat.source",
				},
				obsidian_new = {
					name = "obsidian_new",
					module = "blink.compat.source",
				},
				obsidian_tags = {
					name = "obsidian_tags",
					module = "blink.compat.source",
				},
			},
			-- 	lsp = {
			-- 		name = "lsp",
			-- 		enabled = true,
			-- 		module = "blink.cmp.sources.lsp",
			-- 		-- kind = "LSP",
			-- 		fallbacks = { "snippets", "luasnip", "buffer" },
			-- 		score_offset = 90, -- the higher the number, the higher the priority
			-- 	},
			-- 	path = {
			-- 		name = "Path",
			-- 		module = "blink.cmp.sources.path",
			-- 		score_offset = 3,
			-- 		-- When typing a path, I would get snippets and text in the
			-- 		-- suggestions, I want those to show only if there are no path
			-- 		-- suggestions
			-- 		fallbacks = { "snippets", "luasnip", "buffer" },
			-- 		opts = {
			-- 			trailing_slash = false,
			-- 			label_trailing_slash = true,
			-- 			get_cwd = function(context)
			-- 				return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
			-- 			end,
			-- 			show_hidden_files_by_default = true,
			-- 		},
			-- 	},
			-- 	buffer = {
			-- 		name = "Buffer",
			-- 		module = "blink.cmp.sources.buffer",
			-- 		min_keyword_length = 2,
			-- 	},
			-- 	-- -- Example on how to configure dadbod found in the main repo
			-- 	-- -- https://github.com/kristijanhusak/vim-dadbod-completion
			-- 	-- dadbod = {
			-- 	-- 	name = "Dadbod",
			-- 	-- 	module = "vim_dadbod_completion.blink",
			-- 	-- 	score_offset = 85, -- the higher the number, the higher the priority
			-- 	-- },
			-- },
		},

		keymap = {
			preset = "default",

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			-- ["<CR>"] = { "select_and_accept" },

			cmdline = { preset = "default" },
		},

		-- completion =
		--
		-- completion = menu.draw.columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
		-- snippets = {
		-- 	preset = "luasnip",
		-- 	-- name = "snippets",
		-- 	-- enabled = true,
		-- 	-- module = "blink.cmp.sources.snippets",
		-- 	-- score_offset = 80, -- the higher the number, the higher the priority
		-- 	-- luasnip = {
		-- 	-- 	name = "luasnip",
		-- 	-- 	enabled = true,
		-- 	-- 	module = "blink.cmp.sources.luasnip",
		-- 	-- 	min_keyword_length = 2,
		-- 	-- 	fallbacks = { "snippets" },
		-- 	-- 	score_offset = 85, -- the higher the number, the higher the priority
		-- 	-- },
		-- },

		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		completion = {
			menu = {
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
			},
			documentation = { auto_show = true, auto_show_delay_ms = 200 },
		},

		-- completion = {
		-- 	menu = { border = "single" },
		-- 	documentation = { window = { border = "single" } },
		-- },
		-- signature = { window = { border = "single" } },
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
