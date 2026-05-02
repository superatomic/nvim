if vim.fn.has('nvim-0.13') == 0 then
  vim.notify('Unsupported neovim version', vim.log.levels.ERROR)
  return
end

vim.loader.enable()

require 'opts'
