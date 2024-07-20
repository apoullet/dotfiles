return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
						n = {

							["j"] = false,
							["k"] = false,
							["<C-N>"] = "move_selection_next",
							["<C-P>"] = "move_selection_previous",
						},
					},
				},
			})

			-- Enable telesope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>?", builtin.oldfiles)
			vim.keymap.set("n", "<leader>gf", builtin.git_files)
			vim.keymap.set("n", "<C-h>", builtin.find_files)

			vim.keymap.set("n", "<leader>sg", builtin.live_grep)
			vim.keymap.set("v", "<leader>sg", builtin.grep_string)

			-- Shortcut for searching your neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
}
