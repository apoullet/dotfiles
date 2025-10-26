vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(e)
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		local opts = { buffer = e.buf }
		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "gd", telescope.lsp_definitions, opts)
		vim.keymap.set("n", "gD", function()
			telescope.lsp_definitions({ jump_type = "split" })
		end, opts)
		vim.keymap.set("n", "gr", telescope.lsp_references, opts)
		vim.keymap.set("n", "gi", telescope.lsp_implementations, opts)
		vim.keymap.set("n", "<C-l>", telescope.lsp_document_symbols, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "<leader><leader>", vim.lsp.buf.code_action, opts)

		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			signs = false,
		})

		vim.keymap.set("n", "<C-k>", function()
			vim.diagnostic.open_float(nil, { focus = false })
		end, opts)

		if not client.server_capabilities.documentFormattingProvider then
			return
		end
	end,
})

vim.lsp.enable({ "luals", "ocamllsp", "rust-analyzer", "janet-lsp", "nixd", "pylsp" })

require("fidget").setup({})
