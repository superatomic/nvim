pack { 'github:tpope/vim-eunuch', name = 'eunuch.vim' }

-- Fix for <https://github.com/tpope/vim-eunuch/issues/121>.
map('i', '<CR>', '<CR>')

for _, command in ipairs({ 'W', 'Wall' }) do
  vim.api.nvim_del_user_command(command)
end
