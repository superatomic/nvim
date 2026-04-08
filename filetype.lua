local group = vim.api.nvim_create_augroup('filetypedetect', { clear = false })

vim.api.nvim_create_autocmd({ 'BufNewFile' , 'BufRead' }, {
  group = group,
  pattern = '*.log',
  command = 'setfiletype log',
})
