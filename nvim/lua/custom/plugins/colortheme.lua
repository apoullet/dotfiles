return {
  -- Color theme
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000,
  config = function()
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'rose-pine'
  end
}
