-- Remap to be able to use the VIM integrated terminal sanely
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Remap to move windows more easily in any mode
vim.keymap.set("t", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("t", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("t", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("t", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h")
vim.keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j")
vim.keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k")
vim.keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l")
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")
vim.keymap.set("n", "<A-l>", "<C-w>l")

-- Sane window closing
vim.keymap.set("t", "<C-t>", "<C-\\><C-N>:q<CR>")

function string.starts_with(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

-- Create or open the terminal window
vim.keymap.set("n", "<C-t>", function()
	local current_handle = vim.api.nvim_get_current_buf()
	local current_buffer_name = vim.api.nvim_buf_get_name(current_handle)
	if string.starts_with(current_buffer_name, "term:") then
		return
	end

	vim.cmd("split")

	for _, handle in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(handle) then
			local buffer_name = vim.api.nvim_buf_get_name(handle)
			if string.starts_with(buffer_name, "term:") then
				vim.api.nvim_set_current_buf(handle)
				vim.api.nvim_feedkeys("i", "n", false)
				return
			end
		end
	end

	vim.cmd("term")
end)
