require("mark.remap")
require("mark.set")
require("mark.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MarkGroup = augroup("mark", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.o.guifont = "Fira Code:h13"
vim.g.have_nerd_font = true

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

-- autocmd("FileType", {
--     pattern = {"c", "c++", "h"},
--    callback = function()
--         vim.bo.commentsring = "// %s"
--     end,
-- })

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = MarkGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("FileType", {
	pattern = "netrw", -- Only apply to Netrw buffers
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end

		bind("<C-h>", "<C-w>h")
		bind("<C-l>", "<C-w>l")
	end,
})

autocmd("LspAttach", {
	group = MarkGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		-- vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)
	end,
})

vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	pattern = {
		[".*/templates/.*%.tpl"] = "helm",
		[".*/templates/.*%.ya?ml"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
	},
})

vim.g.netrw_browse_split = 0
vim.g.netrw_sort_sequence = "[/]$,*"
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.g.netrw
-- vim.g.netrw_keepdir = 0
vim.opt.scrolloff = 12

vim.api.nvim_set_hl(0, "CurSearch", { bg = "#FFA500", fg = "black", bold = true, underline = true }) -- Orange background, black text, bold, underlined

-- vim.api.nvim_set_keymap("n", "<C-w>|", "<C-w>z", {})

-- vim.keymap.set("i", "<Esc>", function()
--   vim.cmd("update")
--   return "<Esc>"
-- end, { silent = true })

-- vim.api.nvim_create_autocmd({ "TextChanged", "FocusLost", "BufEnter" }, {
--   pattern = "*", -- Apply to all files
--   callback = function()
--     vim.cmd("silent update")
--   end,
-- })

-- vim.keymap.set("i", "<Esc>", function()
--   vim.cmd("update") -- Save the file
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
-- end, { silent = true })
--
local del_qf_item = function()
	local items = vim.fn.getqflist()
	local line = vim.fn.line(".")
	table.remove(items, line)
	vim.fn.setqflist(items, "r")
	vim.api.nvim_win_set_cursor(0, { line, 0 })
end

-- this is super basic. I might improve it at some point, but it's good enough for how little I use
-- the QF list
-- vim.keymap.set("n", "dd", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })
-- vim.keymap.set("v", "D", del_qf_item, { silent = true, buffer = true, desc = "Remove entry from QF" })

-- Remove items from quickfix list.
-- `dd` to delete in Normal
-- `d` to delete Visual selection
local function delete_qf_items()
	local mode = vim.api.nvim_get_mode()["mode"]

	local start_idx
	local count

	if mode == "n" then
		-- Normal mode
		start_idx = vim.fn.line(".")
		count = vim.v.count > 0 and vim.v.count or 1
	else
		-- Visual mode
		local v_start_idx = vim.fn.line("v")
		local v_end_idx = vim.fn.line(".")

		start_idx = math.min(v_start_idx, v_end_idx)
		count = math.abs(v_end_idx - v_start_idx) + 1

		-- Go back to normal
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes(
				"<esc>", -- what to escape
				true, -- Vim leftovers
				false, -- Also replace `<lt>`?
				true -- Replace keycodes (like `<esc>`)?
			),
			"x", -- Mode flag
			false -- Should be false, since we already `nvim_replace_termcodes()`
		)
	end

	local qflist = vim.fn.getqflist()

	for _ = 1, count, 1 do
		table.remove(qflist, start_idx)
	end

	vim.fn.setqflist(qflist, "r")
	vim.fn.cursor(start_idx, 1)
end

local custom_group = vim.api.nvim_create_augroup("custom", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = custom_group,
	pattern = "qf",
	callback = function()
		-- Do not show quickfix in buffer lists.
		vim.api.nvim_buf_set_option(0, "buflisted", false)

		-- -- Escape closes quickfix window.
		-- vim.keymap.set("n", "<ESC>", "<CMD>cclose<CR>", { buffer = true, remap = false, silent = true })

		-- `dd` deletes an item from the list.
		vim.keymap.set("n", "dd", delete_qf_items, { buffer = true })
		vim.keymap.set("x", "d", delete_qf_items, { buffer = true })
	end,
	desc = "Quickfix tweaks",
})
