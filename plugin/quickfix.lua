-- ----------------- --
-- Quickfix Behavior --
-- ----------------- --

on('FileType', { pattern = 'qf' }, function(ev)
  map[ev.buf]('n', '<Esc>', '<Cmd>bd<CR>', 'Close Window')
end)

-- ------- --
-- Keymaps --
-- ------- --

map('n', '<Leader>c', '<Cmd>copen<CR>', 'Open Quickfix Window')
map('n', '<Leader>l', '<Cmd>lopen<CR>', 'Open Location List Window')
