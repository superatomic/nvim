-- ------------ --
-- Setup Picker --
-- ------------ --

require 'util.pack' {
  'github:ibhagwan/fzf-lua',
}

local fzf = require('fzf-lua')
fzf.setup {
  files = {
    render_crlf = true,
  },
}

vim.api.nvim_create_autocmd('TermEnter', {
  group = vim.api.nvim_create_augroup('config.fzf_keymap', {}),
  callback = function(info)
    if vim.bo.filetype == 'fzf' then
      -- Doing this via the keymap field in FzfLua setup is not documented
      vim.keymap.set('t', '<S-Tab>', '<Up>', { bufnr = info.buffer })
      vim.keymap.set('t', '<Tab>', '<Down>', { bufnr = info.buffer })
    end
  end,
})

-- ------------ --
-- Set mappings --
-- ------------ --

local map = require('util.map')

map.leader_map('n', 'b', fzf.buffers, 'Buffers')

local filesystem_map = map.leader_group('f', 'Filesystem')
filesystem_map('n', 'f', fzf.files, 'Open Files')
filesystem_map('n', 'g', fzf.live_grep, 'Live Grep')
