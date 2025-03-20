-- Remap to be able to use the VIM integrated terminal sanely
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Remap to move windows more easily in any mode
vim.keymap.set({ "t", "i", "n" }, "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set({ "t", "i", "n" }, "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set({ "t", "i", "n" }, "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set({ "t", "i", "n" }, "<A-l>", "<C-\\><C-N><C-w>l")

local state = {
	buf = -1,
	win = -1,
}

local toggle_terminal = function()
	-- Get the dimensions of the current window
	local screen_width = vim.o.columns -- Total width of the screen
	local screen_height = vim.o.lines -- Total height of the screen

	-- Calculate the dimensions of the floating window (75% of the screen)
	local width = math.floor(screen_width * 0.8)
	local height = math.floor(screen_height * 0.7)

	-- Calculate the position to center the window
	local row = math.floor((screen_height - height - 4) / 2)
	local col = math.floor((screen_width - width) / 2)

	if not vim.api.nvim_buf_is_valid(state.buf) then
		state.buf = vim.api.nvim_create_buf(false, true)
	end

	if not vim.api.nvim_win_is_valid(state.win) then
		state.win = vim.api.nvim_open_win(state.buf, true, {
			relative = "editor",
			row = row,
			col = col,
			width = width,
			height = height,
			style = "minimal",
			border = "rounded",
		})

		vim.api.nvim_set_option_value(
			"winhl",
			"Normal:TelescopeNormal,FloatBorder:TelescopeBorder",
			{ win = state.win }
		)

		if vim.api.nvim_get_option_value("buftype", { buf = state.buf }) ~= "terminal" then
			vim.cmd.terminal()
		else
			vim.cmd.startinsert()
		end
	else
		vim.api.nvim_win_hide(state.win)
	end
end

-- Sane terminal handling
vim.keymap.set({ "t", "i", "n" }, "<C-t>", toggle_terminal)
