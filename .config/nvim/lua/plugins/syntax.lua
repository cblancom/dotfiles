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
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
	},
}
