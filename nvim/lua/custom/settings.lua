-- [[ Setting options ]]
-- See `:help vim.o`

-- Color theme
vim.o.background = "dark"
vim.cmd.colorscheme("habamax")

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
