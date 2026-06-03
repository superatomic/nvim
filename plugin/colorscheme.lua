pack { 'github:catppuccin/nvim', name = 'catppuccin' }

on('OptionSet', { pattern = 'termguicolors', once = true }, function()
  if vim.o.termguicolors then
    vim.cmd.colorscheme 'catppuccin-macchiato'
    vim.api.nvim_set_hl(0, 'VisualCursor', { link = 'MiniStatuslineModeVisual' })
    if vim.fn.exists(':Catppuccin') == 2 then
      vim.api.nvim_del_user_command('Catppuccin')
      vim.api.nvim_del_user_command('CatppuccinCompile')
    end
  end
end)
