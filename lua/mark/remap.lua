vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)


vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<esc>", ':noh<cr><esc>', { silent = true })

_G.toggle_wrap = function()
    local wrap = vim.wo.wrap

    vim.wo.wrap = not wrap
end

vim.keymap.set("n", "<A-z>", ':lua toggle_wrap()<CR>', { silent = true })

-- -- Function to execute macro over visual range
-- _G.execute_macro_over_visual_range = function()
--   local macro_register = vim.fn.getchar()
--   local cmd = string.format("'<,'>normal @%s", vim.fn.nr2char(macro_register))
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-u>", true, false, true), "n", false) -- Clear command line
--   vim.cmd(cmd)
-- end
--
-- -- Key mapping
-- vim.keymap.set("v", "@", function()
--   vim.cmd("call v:lua.execute_macro_over_visual_range()")
-- end, { noremap = true, silent = true })

-- vim.keymap.set("n", "<C-h>", '<C-w>h')
-- To remain on the same occurence
vim.keymap.set("n", "*", '*N')
