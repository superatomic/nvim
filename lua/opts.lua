-- ------------ --
-- Vim Behavior --
-- ------------ --

vim.opt.tildeop = true
vim.opt.gdefault = true
vim.opt.showmode = false
vim.opt.exrc = true
vim.opt.shortmess:append('I')
vim.opt.display:append('uhex')
vim.opt.guicursor:append('v:VisualCursor')
vim.opt.fillchars:append {
  eob = ' ',
  fold = ' ',
  msgsep = '\u{2500}',
}
vim.opt.title = true
vim.opt.splitbelow = false
vim.opt.splitright = true
vim.opt.wrapscan = true
vim.opt.timeout = false

if vim.fn.executable('fish') == 1 then
  vim.opt.shell = 'fish'
end

-- ---------------- --
-- Buffer (General) --
-- ---------------- --

vim.opt.smoothscroll = true
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.breakindentopt:append('list:-1')

-- Use autocommand to override any changes made by ftplugins
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('config.opts', {}),
  command = 'setlocal formatoptions-=o',
})

-- ------------- --
-- Status Column --
-- ------------- --

vim.opt.statuscolumn = '%s%C %l '

-- Line number column
vim.opt.number = true
vim.opt.relativenumber = true

-- Fold column
vim.opt.foldcolumn = '1'
vim.opt.fillchars:append {
  foldopen = '\u{f47c}',
  foldclose = '\u{f460}',
  foldsep = ' ',
  foldinner = ' ',
}

-- Sign column
vim.opt.signcolumn = 'auto:1-9'

-- -------------------------- --
-- Indentation and Whitespace --
-- -------------------------- --

vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.opt.tabstop = 4 -- Width of a <Tab> character
vim.opt.softtabstop = -1 -- Follow 'shiftwidth'

vim.opt.list = true
vim.opt.listchars = {
  tab = '> ',
  nbsp = '+',
}

-- ----- --
-- Mouse --
-- ----- --

vim.opt.mouse = 'nvi'
vim.opt.mousescroll = 'ver:1,hor:2'

vim.cmd.aunmenu 'PopUp.How-to\\ disable\\ mouse'
vim.cmd.aunmenu 'PopUp.-2-'

-- ------ --
-- Leader --
-- ------ --

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- ------- --
-- Plugins --
-- ------- --

vim.g.netrw_banner = false
