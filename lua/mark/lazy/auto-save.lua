return {
    'okuuva/auto-save.nvim',

    config = function()
        local group = vim.api.nvim_create_augroup('autosave', {})
        vim.api.nvim_create_autocmd('User', {
            pattern = 'AutoSaveWritePost',
            group = group,
            callback = function(opts)
                if opts.data.saved_buffer ~= nil then
                    local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                    print("AutoSave: saved " .. filename .. ' at ' .. vim.fn.strftime("%H:%M:%S"))
                end
            end,
        })

        require("auto-save").setup {
            debounce_delay = 500,

            trigger_events = {                  -- See :h events
                defer_save = { "InsertLeave" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
            },

            condition = function()
                return not vim.g.VM_insert_mode -- Disable if in vim-visual-multi insert mode
            end,
            noautocmd = false,
            -- debug = true,
            -- log_level = vim.log.levels.DEBUG, -- Enable debug logging
        }
    end,
}
