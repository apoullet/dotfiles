return {
  -- Color theme
  'pappasam/papercolor-theme-slim',
  priority = 1000,
  config = function()
    vim.o.background = 'light'
    vim.cmd.colorscheme 'PaperColorSlim'
  end,
}
