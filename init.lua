-- --------- --
-- Lua Setup --
-- --------- --

map = require('util.map')
on = require('util.on')
pack = require('util.pack')

-- ------------ --
-- Vim Behavior --
-- ------------ --

vim.o.tildeop = true
vim.o.gdefault = true
vim.o.showmode = false
vim.o.exrc = false
vim.opt.shortmess:append('I')
vim.opt.display:append('uhex')
vim.opt.guicursor:append('v:VisualCursor')
vim.opt.fillchars:append {
  eob = ' ',
  fold = ' ',
  msgsep = '\u{2500}',
}
vim.o.title = true
vim.o.splitbelow = false
vim.o.splitright = true
vim.o.wrapscan = true
vim.o.timeout = false
vim.o.updatetime = 250

if vim.fn.executable('fish') == 1 then
  vim.o.shell = 'fish'
end

-- UI2
require('vim._core.ui2').enable()
vim.o.messagesopt = {
  ['hit-enter'] = true,
  history = 500,
  progress = 'c',
  maxheight = 50,
  -- TODO: set pager height to 50% once option becomes available
}

-- ---------------- --
-- Buffer (General) --
-- ---------------- --

vim.o.smoothscroll = true
vim.o.undofile = true
vim.o.breakindent = true
vim.opt.breakindentopt:append { list = '-1' }

-- Display whitespace
vim.o.list = true
vim.o.listchars = {
  tab = '> ',
  nbsp = '+',
}

-- Use autocommand to override any changes made by ftplugins
on('FileType', {}, 'setlocal formatoptions-=o')

-- ------------- --
-- Status Column --
-- ------------- --

vim.o.statuscolumn = '%s%C %l '

-- Line number column
vim.o.number = true
vim.o.relativenumber = true

-- Fold column
vim.o.foldcolumn = '1'
vim.opt.fillchars:append {
  foldopen = '\u{f47c}',
  foldclose = '\u{f460}',
  foldsep = ' ',
  foldinner = ' ',
}

-- Sign column
vim.o.signcolumn = 'auto:1-9'

-- ----- --
-- Mouse --
-- ----- --

vim.o.mouse = 'nvi'
vim.o.mousescroll = 'ver:1,hor:2'

vim.cmd.aunmenu 'PopUp.How-to\\ disable\\ mouse'
vim.cmd.aunmenu 'PopUp.-2-'

-- ------ --
-- Leader --
-- ------ --

local k = vim.keycode
vim.g.mapleader = k'<Space>'
vim.g.maplocalleader = k'<Bslash>'

-- ------- --
-- Plugins --
-- ------- --

on('VimEnter', {}, 'DoMatchParen')

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
