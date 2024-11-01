return
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        require("lualine").setup {
            options = {
                -- ...other options
                theme = "one_monokai"
            }
        }
    end
}
