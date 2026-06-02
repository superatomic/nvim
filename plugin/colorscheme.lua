pack { 'github:catppuccin/nvim', name = 'catppuccin' }

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'termguicolors',
  group = vim.api.nvim_create_augroup('config.colorscheme', {}),
  callback = function()
    if vim.o.termguicolors then
      vim.cmd.colorscheme 'catppuccin-macchiato'
      vim.api.nvim_set_hl(0, 'VisualCursor', { link = 'MiniStatuslineModeVisual' })
    else
      vim.cmd.colorscheme 'default'
    end
  end,
})
