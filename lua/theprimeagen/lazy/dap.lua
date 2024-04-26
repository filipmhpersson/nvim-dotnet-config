return {
    {
        "mfussenegger/nvim-dap",
		dependencies = {
			"jay-babu/mason-nvim-dap.nvim",
		},
        config = function()
            local dap = require('dap')
            local ph_status, dotnet_ph = pcall(require, 'utilities.path_finder')
            dap.adapters.coleclr = {
                type = 'executable',
                command = dotnet_ph.GetNetCoreDbgPath(),
                args = { '--interpreter=vscode' },
                options = {
                    detached = false, -- Will put the output in the REPL. #CloseEnough
                    cwd = dotnet_ph.GetDebugCwd(),
                }
            }
            if (not ph_status) then
                print("path_finder not loaded")
                return
            end
            dap.configurations.cs = {
                {
                    type = "coleclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    console = "integratedTerminal",
                    program = dotnet_ph.GetDllPath,
                },
            }
            vim.keymap.set("n", "<F5>", function() dap:continue() end)

            vim.keymap.set("n", "<F10>", function() dap.step_over() end)
            vim.keymap.set("n", "<F11>", function() dap.step_into() end)
            vim.keymap.set("n", "<F12>", function() dap.step_out() end)
            vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end)
            vim.keymap.set("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
            vim.keymap.set("n", "<leader>lp", function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
            vim.keymap.set("n", "<leader>dl", function() dap.run_last() end)
            vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end)
        end
    },
    {
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		opts = {
			ensure_installed = { "python", "coreclr", "node2", "js", "chrome" }
		},
	},
}
