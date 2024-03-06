return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
        config = function()
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
            }

            -- Enable telesope fzf native, if installed
            pcall(require('telescope').load_extension, 'fzf')

            local nmap = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { desc = desc })
            end

            -- See `:help telescope.builtin`
            local builtin = require('telescope.builtin')

            nmap('<leader>?', builtin.oldfiles,
                { desc = '[?] Find recently opened files' })
            nmap('<leader><space>', builtin.buffers,
                { desc = '[ ] Find existing buffers' })
            nmap('<leader>/', function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                    winblend = 10,
                    previewer = false,
                })
            end, { desc = '[/] Fuzzily search in current buffer' })

            nmap('<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
            nmap('<C-h>', builtin.find_files, { desc = '[S]earch [F]iles' })
            nmap('<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
            nmap('<leader>fg', builtin.grep_string,
                { desc = '[S]earch current [W]ord' })
            nmap('<leader>ff', builtin.live_grep, { desc = '[S]earch by [G]rep' })
            nmap('<leader>fd', builtin.diagnostics,
                { desc = '[S]earch [D]iagnostics' })

            -- Diagnostic keymaps
            nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
            nmap(']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
            nmap('<leader>of', vim.diagnostic.open_float,
                { desc = '[O]pen [f]loating diagnostic message' })
            nmap('<leader>od', vim.diagnostic.setloclist, { desc = '[O]pen [d]iagnostics list' })

            -- Shortcut for searching your neovim configuration files
            nmap('<leader>sn', function()
                builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end, { desc = '[S]earch [N]eovim files' })
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    }
}
