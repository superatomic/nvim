require('vim._core.ui2').enable {
  enabled = true,
}

-- See <https://github.com/neovim/neovim/pull/37905#issuecomment-3926500155>.
vim.api.nvim_create_autocmd('WinEnter', {
  group = vim.api.nvim_create_augroup('config.ui', {}),
  callback = function()
    local max = math.ceil(vim.o.lines * 0.5)
    if vim.o.filetype == 'pager' and vim.api.nvim_win_get_height(0) > max then
      vim.api.nvim_win_set_height(0, max)
    end
  end,
})
