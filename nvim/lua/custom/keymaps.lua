-- [[ Basic Keymaps ]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'kj', '<esc>')
vim.keymap.set('n', '<leader>wb', '<cmd>w<cr>', { desc = '[W]rite [b]uffer', silent = true })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>', { desc = 'Save and quit' })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap to be able to use the VIM integrated terminal sanely
vim.keymap.set('t', 'kj', '<C-\\><C-n>')
