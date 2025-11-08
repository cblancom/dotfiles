return {
	{
		"neovim/nvim-lspconfig",
		lazy = false, -- o event = "BufReadPre"
	},
	-- Plugin para instalar LSPs, formatters, etc.
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},

	-- Auto-instalación de herramientas como lua-language-server, stylua, etc.
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({

				ensure_installed = {
					"stylua",
					"ruff",
					"prettier",
					"shfmt",
					"shellcheck",
					"eslint_d",
					"hadolint",
					"markdownlint",
				},
			})
		end,
	},

	-- Capabilities para cmp
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},

	-- Indicadores de progreso de LSP
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		opts = {},
	},

	-- Configuración principal de LSP con nueva API
	{
		"nvim-lua/plenary.nvim", -- requerido por muchos plugins
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			--- Definición de servidores
			local servers = {
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
							},
							diagnostics = { disable = { "missing-fields" } },
							format = {
								enable = false,
							},
						},
					},
				},

				pyright = {
					settings = {
						python = {
							pythonPath = vim.fn.exepath("python"),
						},
						analysis = {
							autoSearchPaths = true, -- Buscar automáticamente rutas de módulos
							diagnosticMode = "workspace",
							reportMissingImports = true, -- Detectar importaciones faltantes
							reportMissingModuleSource = true, -- Detectar cuando un módulo no está en el entorno
						},
					},
				},

				ruff = {},
				html = { filetypes = { "html", "twig", "hbs" } },
				cssls = {},
				tailwindcss = {},
				dockerls = {},
				sqlls = {},
				terraformls = {},
				jsonls = {},
				yamlls = {},
			}

			-- Configura cada servidor con `vim.lsp.config()` y activa con `vim.lsp.enable()`

			-- local lspconfig = require("lspconfig")
			--
			-- for name, config in pairs(servers) do
			-- 	config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
			-- 	lspconfig[name].setup(config)
			-- end

			for name, config in pairs(servers) do
				config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
				vim.lsp.config(name, config) -- define la configuración
				vim.lsp.enable(name) -- habilita el servidor
			end

			-- Auto-mapeos al conectar LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
					map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
					map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
					map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})
		end,
	},

	-- Formateador moderno
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true, -- Usa LSP si no hay formateador externo
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "ruff_format" },
					javascript = { "prettier" },
					typescript = { "prettier" },
					json = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					sh = { "shfmt" },
				},
			})
		end,
	},

	-- Linter moderno
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				python = { "ruff" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				sh = { "shellcheck" },
				dockerfile = { "hadolint" },
				markdown = { "markdownlint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
