---@type vim.lsp.Config
return {
  mason = 'fish-lsp',
  cmd = { 'fish-lsp', 'start' },
  filetypes = { 'fish' },
  root_markers = { 'config.fish', '.git' },
}
