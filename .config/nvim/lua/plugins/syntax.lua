
-- Initialize and return the plugin configuration
return {
    {
        "m4xshen/autoclose.nvim",
        opts = {
            options = {
                disabled_filetypes = { "text" },
                disable_when_touch = true,
                pair_spaces = true,
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "query", "javascript", "html", "python" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "RRethy/vim-illuminate",
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                },
            })

            -- Enable format on save
            vim.cmd([[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePre *.py lua vim.lsp.buf.format({ async = false })
                augroup END
            ]])
        end,
    },

    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {"jose-elias-alvarez/null-ls.nvim", "williamboman/mason.nvim"},
    },

    {
        "kkoomen/vim-doge",
    }
}

