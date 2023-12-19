return {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = "VeryLazy",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(client, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rr', vim.lsp.buf.rename, '[R]e[n]ame')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('<C-l>', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            if not client.server_capabilities.documentFormattingProvider then
                return
            end

            local format_is_enabled = true
            vim.api.nvim_create_user_command('FormatToggle', function()
                format_is_enabled = not format_is_enabled
                print('Setting autoformatting to: ' .. tostring(format_is_enabled))
            end, {})

            local _augroups = {}
            local get_augroup = function(client)
                if not _augroups[client.id] then
                    local group_name = 'lsp-format-' .. client.name
                    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
                    _augroups[client.id] = id
                end

                return _augroups[client.id]
            end
            -- tsserver usually works poorly. Sorry you work with bad languages
            -- You can remove this line if you know what you're doing :)
            if client.name == 'tsserver' then
                return
            end

            vim.api.nvim_create_autocmd('BufWritePre', {
                group = get_augroup(client),
                buffer = bufnr,
                callback = function()
                    if not format_is_enabled then
                        return
                    end

                    vim.lsp.buf.format {
                        async = false,
                        filter = function(c)
                            return c.id == client.id
                        end,
                    }
                end,
            })
        end

        -- Setup Neovim lua configuration
        require('neodev').setup()

        -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local servers = {
            lua_ls = {},
        }

        require('mason-lspconfig').setup { ensure_installed = vim.tbl_keys(servers) }
        require('mason-lspconfig').setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                }
            end
        }
    end
}
