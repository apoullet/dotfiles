-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- [[ Terminal ]]
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '',
    command = 'startinsert'
})

vim.api.nvim_create_autocmd('TermOpen', {
    command = 'set listchars= nonumber norelativenumber nocursorline'
})
