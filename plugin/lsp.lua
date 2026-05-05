-- -------------------------------------- --
-- Install Mason packages and Enable LSPs --
-- -------------------------------------- --

require 'util.pack' {
  'nvim:lspconfig',
}

local mason = require('util.mason')

local lsps = {
  bashls = { 'bash-language-server', 'shellcheck', 'shfmt' },
  clangd = { 'clangd' },
  fish_lsp = { 'fish-lsp' },
  jsonls = { 'json-lsp' },
  lua_ls = { 'lua-language-server@3.5.6' },
  pylsp = { 'python-lsp-server' },
  rust_analyzer = { 'rust-analyzer' },
  systemd_lsp = { 'systemd-lsp' },
}

for name, packages in pairs(lsps) do
  mason.add(packages, vim.schedule_wrap(function() vim.lsp.enable(name) end))
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

-- ------- --
-- Keymaps --
-- ------- --

local map = require('util.map')

-- Map `gr` so it behaves only as a prefix
map('n', 'gr', '<Nop>', 'LSP Actions')

-- Goto Definition
map('n', 'grd', vim.lsp.buf.definition, 'vim.lsp.buf.definition()')
