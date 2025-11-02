vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("custom.plugins", {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"spellfile",
			},
		},
	},
})

-- [[ Basic Keymaps ]]

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "[W]rite [b]uffer", silent = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set("n", "<leader>od", vim.diagnostic.setloclist)

-- [[ VIM terminal setup ]]

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

-- [[ Setting options ]]

-- See `:help vim.o`

-- Color theme
vim.o.background = "dark"
-- vim.cmd.colorscheme("habamax")
vim.cmd.colorscheme("kanagawa-dragon")

-- Settings to emulate Casey Muratori's scheme in Handmade Hero
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#BFAD9C", bg = "#130D07" })
-- vim.api.nvim_set_hl(0, "Identifier", { fg = "#BFAD9C" })
-- vim.api.nvim_set_hl(0, "Function", { fg = "#BFAD9C" })

-- vim.o.cursorline = true
-- vim.api.nvim_set_hl(0, "CursorLine", { fg = "#BFAD9C", bg = "#000088" })

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Change cursor behavior in different modes
vim.o.guicursor = "a:block-blinkon0,i-r:hor20"
-- vim.o.guicursor = "a:block-blinkon0"

-- Sane splitting behaviour
vim.o.splitbelow = true
vim.o.splitright = true

-- Tabbing behaviour
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Show EOL char
vim.o.list = true
-- vim.o.listchars = "tab:  ,eol:↲"
vim.o.listchars = "tab:  "

-- Use rounded borders on all floating windows
-- vim.o.winborder = "rounded"

-- Update the file automatically if it's been externally updated e.g. when doing inline snapshot testing
vim.o.autoread = true

-- [[ Autocmds ]]

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "",
	command = "startinsert",
})

vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal listchars= nonumber norelativenumber nocursorline",
})

vim.api.nvim_create_autocmd("CursorHold", {
	command = "checktime",
})

-- [[ LSP config ]]

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
