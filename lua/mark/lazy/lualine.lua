return
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        require("lualine").setup {
            options = {
                theme = "one_monokai"
            },

            sections = {
                lualine_b = {"branch", "diagnostics"},
                lualine_c = {
                    {
                        'filename',
                        file_status = true,     -- Displays file status (readonly status, modified status)
                        newfile_status = false, -- Display new file status (new file means no write after created)
                        path = 4,               -- 0: Just the filename

                        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = '[+]',      -- Text to show when the file is modified.
                            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]',     -- Text to show for newly created file before first write
                        }
                    }
                },
                lualine_x = { "encoding", "filetype"},
                lualine_y = {}
            }
        }
    end
}
