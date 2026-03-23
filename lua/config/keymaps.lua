local map = require('util.map')

-- Clipboard
map('v', '<C-S-x>', '"+d', 'Cut to Clipboard')
map('v', '<C-S-c>', '"+ygv', 'Copy to Clipboard')

-- Saner redo mapping
map('n', 'U', '<C-r>', 'Redo')

-- Visual movement
map({ 'n', 'v' }, { 'j', '<Down>' }, 'v:count == 0 ? "gj" : "j"', nil, { expr = true })
map({ 'n', 'v' }, { 'k', '<Up>' }, 'v:count == 0 ? "gk" : "k"', nil, { expr = true })
map('i', '<Down>', '<C-o>gj')
map('i', '<Up>', '<C-o>gk')

-- Ignore <CR> in normal buffers
map({ 'n', 'v' }, '<CR>', '&buftype == "" ? "<Ignore>" : "<CR>"', nil, { expr = true })

-- Map `gr` so it behaves only as a prefix
map('n', 'gr', '<Nop>', 'LSP Actions')

-- Goto Definition
map('n', 'grd', vim.lsp.buf.definition, 'vim.lsp.buf.definition()')
map({ 'n', 'i' }, '<C-LeftMouse>',
  '<LeftMouse><Cmd>lua vim.lsp.buf.definition()<Cr>')

map('v', '<BS>', '"_d', 'Delete to blackhole')

-- Hide search highlights with Escape
map('n', '<Esc>', '<Cmd>nohlsearch<Cr>', 'Hide search highlights')

-- Return to normal mode from terminal mode
map('t', '<C-Esc>', '<C-Bslash><C-n>')
