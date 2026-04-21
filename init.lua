if vim.fn.has('nvim-0.13') == 0 then
  vim.notify('Unsupported neovim version', vim.log.levels.ERROR)
  return
end

vim.loader.enable()

local attempt = require('util.attempt')

require 'config.opts'
attempt 'config.ui'
attempt 'config.colorscheme'
attempt 'config.pack'
attempt 'config.mason'
attempt 'config.treesitter'
attempt 'config.lsp'
attempt 'config.win'
attempt 'config.editor'
attempt 'config.picker'
attempt 'config.quickfix'
attempt 'config.git'
attempt 'config.statusline'
attempt 'config.sessions'
attempt 'config.spell'
attempt 'config.keymaps'
attempt 'config.kitty'
