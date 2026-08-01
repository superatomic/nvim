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

vim.o.formatexpr = require('conform').formatexpr
