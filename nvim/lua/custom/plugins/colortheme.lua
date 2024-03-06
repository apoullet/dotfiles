return {
    -- Color theme
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
    config = function()
        require('kanagawa').setup({
            colors = {
                palette = {
                    -- dragonBlue2 = '#7897c9',
                    -- dragonViolet = '#9A7BB5',
                    -- dragonTeal = '#6CA0A6',
                    dragonBlue2 = '#849abf',
                    dragonViolet = '#9b87ab',
                    dragonTeal = '#7a989a',
                    dragonPink = '#D27E99',
                },
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    },
                }
            }
        })
    end
}
