---@type vim.lsp.Config
return {
  mason = 'json-lsp',
  -- Server does not respect `json.schemaDownload.enable`,
  -- so just unshare the network (Linux-only workaround; see unshare(1)).
  -- See <https://matrix.to/#/!cylwlNXSwagQmZSkzs:matrix.org/$sHIRlZ453Sopu0OaIE_ZGCOHl2SnUusg21GI3ko4GBk>.
  cmd = { 'unshare', '-n', '-r', 'vscode-json-language-server', '--stdio' },
  enabled = vim.fn.executable('unshare') == 1,
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
