local mason = require('util.mason')

mason.ensure_mason() -- Ensure Mason is loaded

vim.api.nvim_create_user_command(
  'MasonClean',
  function()
    mason.clean()
  end,
  { desc = 'Delete unused mason packages' }
)

-- See <https://github.com/mason-org/mason.nvim/issues/2076>
vim.api.nvim_del_user_command('MasonLog')
