---@type vim.lsp.Config
return {
  mason = 'systemd-lsp',
  cmd = { 'systemd-lsp' },
  filetypes = { 'systemd' },
  root_markers = { '.git' },
}
