-- ----------- --
-- Diagnostics --
-- ----------- --

vim.diagnostic.config {
  virtual_text = {
    current_line = false,
    spacing = 1,
  },
  virtual_lines = {
    current_line = true,
  },
  underline = true,
  signs = false,
}

-- ---------- --
-- Formatting --
-- ---------- --

pack 'github:stevearc/conform.nvim'

local conform = require('conform')

conform.setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    rust = { 'rustfmt' },
  },
  log_level = vim.log.levels.WARN,
  notify_on_error = true,
}

vim.o.formatexpr = [[v:lua.require('conform').formatexpr()]]

-- ------- --
-- Folding --
-- ------- --

local function foldtext_default()
  local fold_start = vim.fn.getline(vim.v.foldstart)
  local fold_end = vim.fn.getline(vim.v.foldend)

  local dedented = vim.text.indent(0, fold_start .. '\n' .. fold_end)
  local dedented_end = vim.split(dedented, '\n')[2]

  -- Don't do anything smart if the start of the fold looks like an INI section
  local is_ini = fold_start:match('^%s*%[.+%]%s*$')

  if vim.v.foldstart == vim.v.foldend
      or dedented_end:match('^%s')
      or is_ini then
    return fold_start
  else
    return fold_start .. ' ... ' .. dedented_end
  end
end

local function foldtext_marker()
  local fold_end = vim.split(vim.wo.foldmarker, ',')[2]
  return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. fold_end
end

function vim.g.foldtext()
  if vim.wo.foldmethod == 'marker' then
    return foldtext_marker()
  end
  return foldtext_default()
end

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = 'g:foldtext()'
vim.o.foldlevelstart = 99

-- ------------------- --
-- Trailing Whitespace --
-- ------------------- --

on('BufWritePre', { group = 'config.whitespace' }, function()
  if vim.bo.modified then
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, pos)
  end
end)

-- ------------------------------ --
-- Todo Comments and Highlighting --
-- ------------------------------ --

pack 'mini:hipatterns'

local hi_patterns = require('mini.hipatterns')

hi_patterns.setup {
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = hi_patterns.gen_highlighter.hex_color(),
  },
}

-- ------ --
-- Eunuch --
-- ------ --

pack { 'github:tpope/vim-eunuch', name = 'eunuch.vim' }

-- Fix for https://github.com/tpope/vim-eunuch/issues/121
map('i', '<CR>', '<CR>')

for _, command in ipairs({ 'Unlink', 'W', 'Wall' }) do
  vim.api.nvim_del_user_command(command)
end
