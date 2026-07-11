-- ----------------- --
-- Quickfix Behavior --
-- ----------------- --

on('FileType', { pattern = 'qf', group = 'config.quickfix' }, function(info)
  map[info.buf]('n', '<Esc>', '<Cmd>bd<CR>', 'Close Window')
end)

-- ------- --
-- Keymaps --
-- ------- --

map('n', '<Leader>c', '<Cmd>copen<CR>', 'Open Quickfix Window')
map('n', '<Leader>l', '<Cmd>lopen<CR>', 'Open Location List Window')
