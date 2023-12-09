return {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- Adds LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        -- Snippet engine & its associated nvim-cmp source
        -- This is required for completion to work properly even if you don't use any snippets
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
}
