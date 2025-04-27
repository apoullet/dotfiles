return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "janet_simple" },
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
