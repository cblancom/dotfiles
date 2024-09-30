return {
    {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin",
    --    priority = 1000,
    --     config = function()
    --         vim.cmd([[colorscheme catppuccin]])
    --     end, 
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme kanagawa-wave]])
        end
    }
}
