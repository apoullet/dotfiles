return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = true,
            component_separators = '',
            section_separators = '',
        },
    },
}
