require("mark.remap")
require("mark.set")
require("mark.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MarkGroup = augroup('mark', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

vim.o.guifont = "Fira Code:h13"


function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

-- autocmd("FileType", {
--     pattern = {"c", "c++", "h"},
--    callback = function()
--         vim.bo.commentsring = "// %s"
--     end,
-- })

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = MarkGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw", -- Only apply to Netrw buffers
    callback = function()
        local bind = function(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { remap = true, buffer = true })
        end

        bind("<C-h>", "<C-w>h")
        bind("<C-l>", "<C-w>l")
    end
})

-- vim.api.nvim_create_autocmd("BufWriteCmd", {
--     group = vim.api.nvim_create_augroup("GoFormat", { clear = true }),
--     pattern = "*.go",
--     callback = function()
--         local current_file = vim.fn.expand("%:p") -- Get the full file path
--         local formatted_code = vim.fn.system(string.format("goimports %s | golines --max-len=80", current_file))
--         if formatted_code ~= nil then -- If there were no errors (formatted_code is not nil)
--           vim.api.nvim_buf_set_lines(0, 0, -1, -1, vim.split(formatted_code, "\n")) -- Replace buffer content
--           vim.cmd("write") -- Save the file
--         end
--     end
-- })

-- autocmd("BufWritePre", {
--   pattern = { "*.go" },  -- Only for Go find_files
--   command = ":w !goimports % | golines --max-len=80 > %", -- Combine both commands
--   -- callback = function()
--   --   vim.lsp.buf.format { async = false, filter = function(client) return client.name == "gopls" end }
--   --   vim.cmd("execute '!golines --max-len=80'")
--   -- end,
--   group = vim.api.nvim_create_augroup("GoImportsOnSave", { clear = true }), -- Group for easier management
-- })

autocmd('LspAttach', {
    group = MarkGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.g.netrw_keepdir = 0
vim.opt.scrolloff = 12

vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})
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
--

