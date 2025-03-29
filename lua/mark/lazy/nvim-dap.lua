return {
	"mfussenegger/nvim-dap",
	-- lazy = true,

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"nvim-neotest/nvim-nio",

		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	keys = {
		vim.keymap.set("n", "<F5>", function()
			require("dap").continue()
		end, { desc = "Debug: Start/Continue" }),
		vim.keymap.set("n", "<F1>", function()
			require("dap").step_over()
		end, { desc = "Debug: Step Over" }),
		vim.keymap.set("n", "<F2>", function()
			require("dap").step_into()
		end, { desc = "Debug: Step Into" }),
		vim.keymap.set("n", "<F3>", function()
			require("dap").step_out()
		end, { desc = "Debug: Step Out" }),
		vim.keymap.set("n", "<leader>db", function()
			require("dap").toggle_breakpoint()
		end, { desc = "DAP: Toggle breackpoint" }),
		vim.keymap.set("n", "<leader>dB", function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DAP: Set breakpoint" }),
		vim.keymap.set("n", "<leader>dN", function()
			require("dap").step_back()
		end, { desc = "DAP: Step back" }),
		vim.keymap.set("n", "<leader>dr", function()
			require("dap").repl.toggle()
		end, { desc = "DAP: Toggle REPL" }),
		vim.keymap.set("n", "<leader>d.", function()
			require("dap").goto_()
		end, { desc = "DAP: Go to" }),
		vim.keymap.set("n", "<leader>dh", function()
			require("dap").run_to_cursor()
		end, { desc = "DAP: Run to cursor" }),
		vim.keymap.set("n", "<leader>de", function()
			require("dap").set_exception_breakpoints()
		end, { desc = "DAP: Set exception breakpoints" }),
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,

			handlers = {},

			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"delve",
				"gdb",
			},
		})

		require("dap-go").setup()
		dapui.setup()

		require("nvim-dap-virtual-text").setup({})

		vim.keymap.set({ "n", "x" }, "<leader>dx", function()
			dapui.eval()
		end, { desc = "DAP-UI: Eval" })

		vim.keymap.set("n", "<leader>dX", function()
			dapui.eval(vim.fn.input("expression: "), {})
		end, { desc = "DAP-UI: Eval expression" })

		-- map("n", "<leader>dv", function()
		--     require("telescope").extensions.dap.variables()
		-- end, { desc = "DAP-Telescope: Variables" })
		-- map("n", "<leader>dc", function()
		--     require("telescope").extensions.dap.commands()
		-- end, { desc = "DAP-Telescope: Commands" })

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui"] = function()
			dapui.open({})
			-- require("nvim-dap-virtual-text").refresh()
		end
		dap.listeners.after.event_terminated["dapui"] = function()
			dapui.close({})
			-- require("nvim-dap-virtual-text").refresh()
			-- vim.cmd("silent! bd! \\[dap-repl]")
		end
		dap.listeners.before.event_exited["dapui"] = function()
			dapui.close({})
			-- require("nvim-dap-virtual-text").refresh()
			-- vim.cmd("silent! bd! \\[dap-repl]")
		end

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					-- Use a default executable path if it exists, otherwise prompt
					local default_executable = vim.fn.expand("%:p:h") .. "a.out" -- Adjust the path as needed
					print(default_executable)
					if vim.fn.filereadable(default_executable) == 1 then
						return default_executable
					else
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end
					-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				-- runInTerminal = true,
				terminal = "integrated",
				-- stopAtBeginningOfMainSubprogram = false,
			},
			{
				name = "Select and attach to process",
				type = "gdb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				pid = function()
					local name = vim.fn.input("Executable name (filter): ")
					return require("dap.utils").pick_process({ filter = name })
				end,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach to gdbserver :1234",
				type = "gdb",
				request = "attach",
				target = "localhost:1234",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
			},
		}
		dap.configurations.c = dap.configurations.cpp

		-- dap.configurations.python = dap.configurations.python or {}
		-- table.insert(dap.configurations.python, {
		--     type = "python",
		--     request = "attach",
		--     name = "attach PID",
		--     processId = "${command:pickProcess}",
		--     console = "integratedTerminal",
		-- })
		-- table.insert(dap.configurations.python, {
		--     type = "python",
		--     request = "attach",
		--     name = "Attach remote jMC=false",
		--     host = function()
		--         return fn.input("Host [127.0.0.1]: ", "127.0.0.1")
		--     end,
		--     port = function()
		--         return tonumber(fn.input("Port [5678]: ", "5678"))
		--     end,
		--     justMyCode = false,
		--     console = "integratedTerminal",
		-- })
		-- table.insert(dap.configurations.python, {
		--     type = "python",
		--     request = "launch",
		--     name = "launch with options",
		--     program = "${file}",
		--     -- python = function() end,
		--     pythonPath = function()
		--         local path
		--         for _, server in ipairs(vim.lsp.buf_get_clients()) do
		--             path = vim.tbl_get(server, "config", "settings", "python", "pythonPath")
		--             if path then
		--                 break
		--             end
		--         end
		--         path = fn.input("Python path: ", path or "", "file")
		--         return path ~= "" and fn.expand(path) or nil
		--     end,
		--     args = function()
		--         local args = {}
		--         local i = 1
		--         while true do
		--             local arg = fn.input("Argument [" .. i .. "]: ")
		--             if arg == "" then
		--                 break
		--             end
		--             args[i] = arg
		--             i = i + 1
		--         end
		--         return args
		--     end,
		--     justMyCode = function()
		--         return fn.input("justMyCode? [y/n]: ") == "y"
		--     end,
		--     stopOnEntry = function()
		--         return fn.input("stopOnEntry? [y/n]: ") == "y"
		--     end,
		--     console = "integratedTerminal",
		-- })
	end,
}
