return {
    "numToStr/Comment.nvim",

    config = function()
        local ft = require('Comment.ft')
        require('Comment').setup()

        -- ft({'c', 'cpp', 'h'}, '// %s')
    end,
}
