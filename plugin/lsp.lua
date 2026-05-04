-- ------- --
-- Keymaps --
-- ------- --

local map = require('util.map')

-- Map `gr` so it behaves only as a prefix
map('n', 'gr', '<Nop>', 'LSP Actions')

-- Goto Definition
map('n', 'grd', vim.lsp.buf.definition, 'vim.lsp.buf.definition()')

-- -------------------------------------- --
-- Install Mason packages and Enable LSPs --
-- -------------------------------------- --

require 'util.pack' {
  'nvim:lspconfig',
}

local mason = require('util.mason')

local lsp_servers = {
  bashls = { 'bash-language-server', 'shellcheck', 'shfmt' },
  fish_lsp = { 'fish-lsp' },
  jsonls = { 'json-lsp' },
  lua_ls = { 'lua-language-server@3.5.6' },
  pylsp = { 'python-lsp-server' },
  rust_analyzer = { 'rust-analyzer' },
  systemd_lsp = { 'systemd-lsp' },
}

for name, packages in pairs(lsp_servers) do
  -- Enable the LSP in a callback only after all of the required packages for
  -- it have been installed.
  local installed = 0
  local callback = function()
    installed = installed + 1
    if installed == #packages then
      vim.schedule_wrap(vim.lsp.enable)(name)
    end
  end

  for package in vim.iter(packages) do
    local package_name, package_version = unpack(vim.split(package, '@'))
    mason.add(package_name, { version = package_version }, callback)
  end
end

-- ------ --
-- Config --
-- ------ --

vim.lsp.config('*', {
  exit_timeout = 100,
})

vim.lsp.config('lua_ls', {
  exit_timeout = true,
})

vim.lsp.config('jsonls', {
  -- Server does not respect `json.schemaDownload.enable`,
  -- so just unshare the network (Linux-only workaround; see unshare(1)).
  -- See <https://matrix.to/#/!cylwlNXSwagQmZSkzs:matrix.org/$sHIRlZ453Sopu0OaIE_ZGCOHl2SnUusg21GI3ko4GBk>.
  cmd = { 'unshare', '-n', '-r', 'vscode-json-language-server', '--stdio' },
})
