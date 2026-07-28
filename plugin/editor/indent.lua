-- ------------------- --
-- Indentation Options --
-- ------------------- --

vim.o.expandtab = true
vim.o.shiftwidth = 2

vim.o.tabstop = 4 -- Width of a <Tab> character
vim.o.softtabstop = -1 -- Follow 'shiftwidth'

-- ----------------- --
-- Guess Indentation --
-- ----------------- --

pack 'github:NMAC427/guess-indent.nvim'

require('guess-indent').setup {
  auto_cmd = true,
  override_editorconfig = false,
  on_tab_options = {
    expandtab = false,
    shiftwidth = 0,
    tabstop = vim.go.tabstop,
    softtabstop = vim.go.softtabstop,
  },
  on_space_options = {
    expandtab = true,
    shiftwidth = 'detected',
    tabstop = vim.go.tabstop,
    softtabstop = vim.go.softtabstop,
  },
}
