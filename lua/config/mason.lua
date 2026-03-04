local mason = require('util.mason')

-- ----------- --
-- Setup Mason --
-- ----------- --

mason.setup {
  ui = {
    check_outdated_packages_on_open = false,
    icons = {
      package_installed = '\u{2713}',
      package_pending = '\u{279c}',
      package_uninstalled = '\u{2717}',
    },
  },
}

-- -------------- --
-- Mason Commands --
-- -------------- --

vim.api.nvim_create_user_command(
  'MasonClean',
  function()
    mason.clean()
  end,
  { desc = 'Delete unused mason packages' }
)
