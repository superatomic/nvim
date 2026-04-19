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

require 'util.pack' {
  'github:stevearc/conform.nvim',
}

local conform = require('conform')

conform.setup {
  default_format_opts = {
    lsp_format = 'fallback',
  },
  notify_on_error = true,
}

vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

-- ----------- --
-- Completions --
-- ----------- --

require 'util.pack' {
  { 'github:saghen/blink.cmp', version = vim.version.range('1.*') },
  'github:rafamadriz/friendly-snippets',
}

require('blink.cmp').setup {
  keymap = {
    preset = 'none',

    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<Up>'] = { 'select_prev', 'fallback' },
    ['<Down>'] = { 'select_next', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },

    ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<C-s>'] = { 'show_signature', 'hide_signature', 'fallback' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    documentation = { auto_show = true },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets' },
    providers = {
      snippets = {
        score_offset = -3,
      },
    },
  },
  cmdline = {
    enabled = false,
  },
}

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

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('config.whitespace', {}),
  callback = function()
    if vim.bo.modified then
      local pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd [[keeppatterns %s/\s\+$//e]]
      vim.api.nvim_win_set_cursor(0, pos)
    end
  end,
})

-- ------------------------------ --
-- Todo Comments and Highlighting --
-- ------------------------------ --

require 'util.pack' {
  'mini:hipatterns',
}

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

-- ----------- --
-- Indentation --
-- ----------- --

require 'util.pack' {
  'github:NMAC427/guess-indent.nvim',
}

require('guess-indent').setup {
  auto_cmd = true,
  override_editorconfig = false,
  on_tab_options = {
    expandtab = false,
    shiftwidth = 0,
  },
  on_space_options = {
    expandtab = true,
    shiftwidth = 'detected',
  },
}
