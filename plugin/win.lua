vim.api.nvim_create_autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('config.window_resize', {}),
  command = 'wincmd =',
})
