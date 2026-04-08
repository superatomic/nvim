local map = require('util.map')

-- ----------------- --
-- Quickfix Behavior --
-- ----------------- --

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = vim.api.nvim_create_augroup('config.quickfix', {}),
  callback = function(info)
    map[info.buf]('n', '<Esc>', '<Cmd>bd<CR>', 'Close Window')
  end,
})

-- ------- --
-- Keymaps --
-- ------- --

map('n', '<Leader>c', '<Cmd>copen<CR>', 'Open Quickfix Window')
map('n', '<Leader>l', '<Cmd>lopen<CR>', 'Open Location List Window')
