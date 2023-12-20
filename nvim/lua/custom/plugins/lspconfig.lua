return {
    {
        'neovim/nvim-lspconfig',
        event = "BufReadPost",
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
            'folke/neodev.nvim',
        },
        config = function()
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
                lua_ls = {
                    Lua = {
                        telemetry = {
                            enable = true
                        }
                    }
                },
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
    },
    {
        -- Autocompletion
        'hrs7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- Snippet engine & its associated nvim-cmp source
            -- This is required for completion to work properly even if you don't use any snippets
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete {},
                    ['<Tab>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                },
                sources = {
                    { name = 'nvim_lsp' },
                }
            }
        end
    }
}
