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

-- Set 'spell' to true in normal buffers (see `:h 'buftype'`)
vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('config.spell', {}),
  callback = vim.schedule_wrap(function(args)
    if args.buf == vim.api.nvim_get_current_buf() then
      vim.wo.spell = vim.bo.buftype == ''
    end
  end),
})

-- Set spelling options
vim.opt.spelllang = 'en'
vim.opt.spelloptions:append('camel')
vim.opt.spellcapcheck = ''
