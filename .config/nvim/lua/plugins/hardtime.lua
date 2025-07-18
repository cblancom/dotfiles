return {
	{
		"m4xshen/hardtime.nvim",
		lazy = true,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		-- Esto define un comando para cargar el plugin manualmente
		cmd = { "HardtimeEnable", "HardtimeDisable" },
	},
}
