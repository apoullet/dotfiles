return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
		},
		config = function()
			local on_attach = function(client, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				local builtin = require("telescope.builtin")

				nmap("gd", builtin.lsp_definitions)
				nmap("gD", function()
					builtin.lsp_definitions({ jump_type = "split" })
				end)
				nmap("gr", builtin.lsp_references)
				nmap("gi", builtin.lsp_implementations)
				nmap("<C-l>", builtin.lsp_document_symbols)

				nmap("K", vim.lsp.buf.hover)

				vim.diagnostic.config({
					virtual_text = false,
				})
				nmap("<C-k>", function()
					vim.diagnostic.open_float(nil, { focus = false })
				end)

				if not client.server_capabilities.documentFormattingProvider then
					return
				end
			end

			-- Setup Neovim lua configuration
			require("neodev").setup()

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local lspconfig = require("lspconfig")
			lspconfig["zls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					zls = {
						path = "/usr/bin/zig",
						zls = {
							path = "/usr/bin/zls",
						},
					},
				},
			})

			local mason_servers = {
				lua_ls = {
					Lua = {
						telemetry = {
							enable = true,
						},
					},
				},
			}
			require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(mason_servers) })
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = mason_servers[server_name],
						filetypes = (mason_servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},
	{
		-- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			-- Snippet engine & its associated nvim-cmp source
			-- This is required for completion to work properly even if you don't use any snippets
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-y>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = {
					{ name = "nvim_lsp" },
				},
				completion = {
					autocomplete = false,
				},
			})
		end,
	},
}
