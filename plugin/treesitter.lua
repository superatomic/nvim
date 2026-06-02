pack 'github:nvim-treesitter/nvim-treesitter'

local treesitter = require('nvim-treesitter')

-- ----------- --
-- Install CLI --
-- ----------- --

require('util.mason').add('tree-sitter-cli')

-- ------------------------------- --
-- Update parsers on plugin update --
-- ------------------------------- --

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('config.pack.treesitter', {}),
  callback = function(info)
    local data = info.data
    if
      data.spec.name == 'nvim-treesitter'
      and data.kind == 'update'
      and data.active
    then
      treesitter.update(nil, { summary = true })
    end
  end,
})

-- --------------- --
-- Install Parsers --
-- --------------- --

local parsers = {}
vim.list_extend(parsers, treesitter.get_available(1))
vim.list_extend(parsers, treesitter.get_available(2))
treesitter.install(parsers)

-- ------------- --
-- User Commands --
-- ------------- --

vim.api.nvim_create_user_command(
  'TSUninstallAll',
  function()
    treesitter.uninstall(treesitter.get_installed())
  end,
  {
    desc = 'Uninstall all treesitter parsers',
  }
)
