return {
	"okuuva/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			debounce_delay = 500,

			trigger_events = { -- See :h events
				defer_save = { "InsertLeave" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
			},

			condition = function()
				return not vim.g.VM_insert_mode -- Disable if in vim-visual-multi insert mode
			end,
			noautocmd = true,
			vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {}),
			-- debug = true,
			-- log_level = vim.log.levels.DEBUG, -- Enable debug logging
		})
	end,
}
