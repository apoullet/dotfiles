return {
	{
		"stevearc/conform.nvim",
		-- event = { "BufReadPost", "BufWritePre", "BufNewFile" },
		event = "VeryLazy",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				--    -- Conform can also run multiple formatters sequentially
				--    -- python = { "isort", "black" },
				--    --
				--    -- You can use a sub-list to tell conform to run *until* a formatter
				--    -- is found.
				--    -- javascript = { { "prettierd", "prettier" } },
				go = { "gofmt" },
				erlang = { "erlfmt" },
				rust = { "rustfmt" },
			},
			formatters = {
				erlfmt = {
					command = "rebar3",
					args = { "fmt", "-" },
					condition = function()
						return next(vim.fs.find("rebar.config", { upward = true, stop = "/home/apoullet" })) ~= nil
					end,
				},
			},
		},
	},
}
