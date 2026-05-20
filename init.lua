-- --------- --
-- Lua Setup --
-- --------- --

pack = require('util.pack')

-- ------------ --
-- Vim Behavior --
-- ------------ --

vim.o.tildeop = true
vim.o.gdefault = true
vim.o.showmode = false
vim.o.exrc = true
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

if vim.fn.executable('fish') == 1 then
  vim.o.shell = 'fish'
end

-- UI2
local msg_height = 0.5
require('vim._core.ui2').enable {
  enabled = true,
  msg = {
    cmd = { height = msg_height },
    dialog = { height = msg_height },
    msg = { height = msg_height },
    pager = { height = msg_height },
  },
}

-- ---------------- --
-- Buffer (General) --
-- ---------------- --

vim.o.smoothscroll = true
vim.o.undofile = true
vim.o.breakindent = true
vim.opt.breakindentopt:append('list:-1')

-- Use autocommand to override any changes made by ftplugins
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('config.opts', {}),
  command = 'setlocal formatoptions-=o',
})

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

-- -------------------------- --
-- Indentation and Whitespace --
-- -------------------------- --

vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.tabstop = 4 -- Width of a <Tab> character
vim.o.softtabstop = -1 -- Follow 'shiftwidth'

vim.o.list = true
vim.opt.listchars = {
  tab = '> ',
  nbsp = '+',
}

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

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
