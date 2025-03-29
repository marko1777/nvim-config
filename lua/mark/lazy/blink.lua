return {
	"saghen/blink.cmp",
	enabled = true,

	dependencies = {
		{ "rafamadriz/friendly-snippets" },
	},

	version = "*",

	opts = {
		snippets = { preset = "luasnip" },

		fuzzy = { implementation = "prefer_rust_with_warning" },

		sources = {
            -- default = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer", "markdown" }, -- , "dadbod" },
			-- default = { "lsp", "path", "snippets", "buffer", "obsidian", "obsidian_new", "obsidian_tags", "markdown" }, -- , "dadbod" },
			-- default = { "lsp", "path", "snippets", "buffer", "obsidian", "markdown" }, -- , "dadbod" },
			default = { "lsp", "path", "snippets", "buffer" }, -- , "dadbod" },
			providers = {
				markdown = {
					name = "RenderMarkdown",
					module = "render-markdown.integ.blink",
					fallbacks = { "lsp" },
				},
				-- obsidian = {
				-- 	name = "obsidian",
				-- 	module = "blink.compat.source",
				-- },
				-- obsidian_new = {
				-- 	name = "obsidian_new",
				-- 	module = "blink.compat.source",
				-- },
				-- obsidian_tags = {
				-- 	name = "obsidian_tags",
				-- 	module = "blink.compat.source",
				-- },
			},
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
		},

		cmdline = { keymap = { preset = "cmdline" } },

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

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
