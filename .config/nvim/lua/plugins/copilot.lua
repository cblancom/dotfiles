return {
	-- Copilot principal (ya lo tienes)
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<C-l>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				panel = { enabled = false },
			})
		end,
	},

	-- Integración con cmp (ya lo tienes)
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		-- priority = 1000,
		lazy = false,
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- estás usando esta variante
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Solo en Mac o Linux
		opts = {
			mappings = {
				submit_prompt = {
					normal = "<Leader>cs",
					insert = "<C-s>",
				},
				show_diff = {
					full_diff = true,
				},
			},
			prompts = {
				CustomExplain = {
					prompt = "Explícame cómo funciona este código.",
					system_prompt = "Eres un tutor amigable y claro.",
					mapping = "<leader>cex",
					description = "Explicación personalizada del código",
				},
			},
		},
		cmd = {
			"CopilotChat",
			"CopilotChatOpen",
			"CopilotChatClose",
			"CopilotChatToggle",
			"CopilotChatStop",
			"CopilotChatReset",
			"CopilotChatSave",
			"CopilotChatLoad",
			"CopilotChatPrompts",
			"CopilotChatModels",
			"CopilotChatAgents",
		},
	},
}
