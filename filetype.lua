local group = vim.api.nvim_create_augroup('filetypedetect', { clear = false })

on({ 'BufNewFile', 'BufRead' }, { pattern = '*.log', group = group },
  'setfiletype log'
)
