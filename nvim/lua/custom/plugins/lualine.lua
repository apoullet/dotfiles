return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fileformat = {
			"fileformat",
			fmt = string.upper,
			icons_enabled = false,
		}

		local getlsp = function()
			local msg = "No Active Lsp"
			local buf_ft = vim.filetype.match({ buf = 0 })
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end

		local lsp = {
			getlsp,
			icon = "  LSP:",
		}

		require("lualine").setup({
			options = {
				theme = "moonfly",
				section_separators = { left = "", right = "" },
				component_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", lsp },
				lualine_x = { "diagnostics", "encoding", fileformat },
				lualine_y = {},
				lualine_z = { "location" },
			},
		})
	end,
}
