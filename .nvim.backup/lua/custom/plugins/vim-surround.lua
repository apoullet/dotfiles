return {
	{
		"tpope/vim-surround",
		keys = {
			"cs",
			"ds",
		},
		dependencies = {
			"tpope/vim-repeat",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
