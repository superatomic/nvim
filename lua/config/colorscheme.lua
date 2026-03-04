require 'util.pack' {
  { 'github:catppuccin/nvim', name = 'catppuccin' },
}

vim.cmd.colorscheme 'catppuccin-macchiato'

vim.api.nvim_set_hl(0, 'VisualCursor', { link = 'MiniStatuslineModeVisual' })
