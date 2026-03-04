---@type vim.lsp.Config
return {
  mason = 'systemd-language-server',
  cmd = { 'systemd-language-server' },
  filetypes = { 'systemd' },
  root_markers = { '.git' },
}
