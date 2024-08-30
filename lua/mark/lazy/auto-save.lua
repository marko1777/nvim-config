return {
    'Pocco81/auto-save.nvim',

    config = function()
        require("auto-save").setup {
            execution_message = {
                message = function() -- message to print on save
                    return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
                end,
                dim = 0.18,              -- dim the color of `message`
                cleaning_interval = 500, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
            },
            debounce_delay = 1500,
            trigger_events = { "InsertLeave" },
        }
    end,
}

