-- Clipboard
map('v', '<C-S-x>', '"+d', 'Cut to Clipboard')
map('v', '<C-S-c>', '"+ygv', 'Copy to Clipboard')

-- Saner redo mapping
map('n', 'U', '<C-r>', 'Redo')

-- Visual movement
map.expr({ 'n', 'x' }, { 'j', '<Down>' }, 'v:count == 0 ? "gj" : "j"')
map.expr({ 'n', 'x' }, { 'k', '<Up>' }, 'v:count == 0 ? "gk" : "k"')
map({ 'i', 's' }, '<Down>', '<C-o>gj')
map({ 'i', 's' }, '<Up>', '<C-o>gk')

-- Ignore <CR> in normal buffers
map.expr({ 'n', 'x' }, '<CR>', '&buftype == "" ? "<Ignore>" : "<CR>"')

--- <Leader> by itself does nothing
map({ 'n', 'x' }, { '<Leader>', '<Localleader>' }, '<Nop>')

-- Delete to black hole
map('x', '<BS>', '"_d', 'Delete to black hole')

-- Hide search highlights and extra cursors with Escape
local mcursor_ns = vim.api.nvim_create_namespace('nvim.multicursor')
map('n', '<Esc>', function()
  if vim.v.hlsearch ~= 0 then
    vim.cmd.nohlsearch()
  else
    vim.api.nvim_buf_clear_namespace(0, mcursor_ns, 0, -1)
  end
end)

-- Better terminal keymaps for <Esc>
map('t', '<Esc>', '<C-Bslash><C-n>')
map('t', '<C-Esc>', '<Esc>')

-- Ignore `q:` since I keep accidentally pressing it instead of `:q`
-- This keymap needs to be removed during macro recording, otherwise it breaks
-- `q`'s ability to end recordings.
on({ 'VimEnter', 'RecordingLeave' }, {}, function()
  map('n', 'q:', '<Ignore>')
end)
on('RecordingEnter', {}, function()
  vim.keymap.del('n', 'q:')
end)
