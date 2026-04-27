local map = require('util.map')

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

-- Hide search highlights with Escape
map('n', '<Esc>', '<Cmd>nohlsearch<Cr>', 'Hide search highlights')

-- Better terminal keymaps for <Esc>
map('t', '<Esc>', '<C-Bslash><C-n>')
map('t', '<C-Esc>', '<Esc>')

-- Ignore `q:` since I keep accidentally pressing it instead of `:q`
map('n', 'q:', '<Ignore>')
