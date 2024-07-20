return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "j-hui/fidget.nvim", tag = "legacy", opts = {} },
			"folke/neodev.nvim",
			"ionide/Ionide-vim",
		},
		config = function()
			local on_attach = function(client, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>rr", vim.lsp.buf.rename, "[R]e[n]ame")

				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<C-l>", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				nmap("K", vim.lsp.buf.hover, "Hover Documentation")

				vim.diagnostic.config({
					virtual_text = false,
				})
				nmap("<C-k>", function()
					vim.diagnostic.open_float(nil, { focus = false })
				end, "Hover Diagnostics")

				if not client.server_capabilities.documentFormattingProvider then
					return
				end
			end

			-- Setup Neovim lua configuration
			require("neodev").setup()

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			local servers = {
				lua_ls = {
					Lua = {
						telemetry = {
							enable = true,
						},
					},
				},
			}

			require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},
	{
		-- Autocompletion
		"hrs7th/nvim-cmp",
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
			})
		end,
	},
}
