-- Set spelling options
vim.o.spell = true
vim.o.spelllang = 'en'
vim.o.spelloptions = 'camel'
vim.o.spellsuggest = 'best'
vim.o.spellcapcheck = ''

-- Regenerate outdated vim spell lists
for file in vim.iter(vim.api.nvim_get_runtime_file('spell/*.add', true)) do
  if vim.fn.getftime(file) > vim.fn.getftime(file .. '.spl') then
    vim.cmd.mkspell { file, bang = true, mods = { silent = true } }
  end
end

-- Configure spellfile.lua plugin
require('nvim.spellfile').config {
  confirm = false,
}

-- Set `nospell` in non-normal buffers
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'buftype',
  group = vim.api.nvim_create_augroup('config.spell', {}),
  callback = function()
    if vim.bo.buftype ~= '' then
      vim.wo[0][0].spell = false
    end
  end,
})
