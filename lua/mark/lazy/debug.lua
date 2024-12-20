-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    -- 'mfussenegger/nvim-dap',
    -- -- NOTE: And you can specify dependencies as well
    -- dependencies = {
    --     -- Creates a beautiful debugger UI
    --     'rcarriga/nvim-dap-ui',
    --
    --     -- Required dependency for nvim-dap-ui
    --     'nvim-neotest/nvim-nio',
    --
    --     -- Installs the debug adapters for you
    --     'williamboman/mason.nvim',
    --     'jay-babu/mason-nvim-dap.nvim',
    --
    --     -- Add your own debuggers here
    --     'leoluz/nvim-dap-go',
    --     'sakhnik/nvim-gdb',
    -- },
    -- config = function()
    --     local dap = require 'dap'
    --     local dapui = require 'dapui'
    --
    --     require('mason-nvim-dap').setup {
    --         -- Makes a best effort to setup the various debuggers with
    --         -- reasonable debug configurations
    --         automatic_installation = true,
    --
    --         -- You can provide additional configuration to the handlers,
    --         -- see mason-nvim-dap README for more information
    --         handlers = {},
    --
    --         -- You'll need to check that you have the required things installed
    --         -- online, please don't ask me how to install them :)
    --         ensure_installed = {
    --             -- Update this to ensure that you have the debuggers for the langs you want
    --             'delve',
    --         },
    --     }
    --
    --     -- Basic debugging keymaps, feel free to change to your liking!
    --     vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    --     vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    --     vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    --     vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
    --     vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    --     vim.keymap.set('n', '<leader>B', function()
    --         dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    --     end, { desc = 'Debug: Set Breakpoint' })
    --
    --     -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    --     vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    --
    --     dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    --     dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    --     dap.listeners.before.event_exited['dapui_config'] = dapui.close
    --
    --     -- Install golang specific config
    --     require('dap-go').setup {
    --         delve = {
    --             -- On Windows delve must be run attached or it crashes.
    --             -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --             detached = vim.fn.has 'win32' == 0,
    --         },
    --     }
    --     -- -- Setup nvim-gdb
    --     -- require('gdb').setup({
    --     --     set_tkeymaps = false, -- Disable default keymaps to avoid conflicts
    --     --     -- ... other nvim-gdb configuration options ...
    --     -- })
    --     -- Configure the GDB adapter
    --     dap.adapters.gdb = {
    --         type = 'executable',
    --         command = 'gdb',
    --         args = { '--interpreter=mi3' }, -- Use MI interface (version 3) for better compatibility
    --     }
    --
    --     -- Set up configurations for C/C++ debugging (adjust as needed)
    --     dap.configurations.cpp = {
    --         {
    --             name = "Launch",
    --             type = "gdb",
    --             request = "launch",
    --             program = function()
    --                 return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --             end,
    --             cwd = "${workspaceFolder}",
    --             stopOnEntry = false,
    --         },
    --         {
    --             name = "Attach",
    --             type = "gdb",
    --             request = "attach",
    --             processId = require 'dap.utils'.pick_process,
    --             cwd = "${workspaceFolder}",
    --         },
    --     }
    -- end,
}
