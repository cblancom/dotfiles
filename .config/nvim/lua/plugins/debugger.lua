return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            {"<leader>db", "<cmd>DapToggleBreakpoint<CR>"},
            {"<leader>dpr", function()
                require("dap-python").test_method()
            end},
        },
        ft = "python",
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
}

