-- -------------- --
-- Autocompletion --
-- -------------- --

vim.o.autocomplete = true
vim.o.complete = 'o'
vim.o.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }
vim.opt.shortmess:append('c')
vim.o.pumheight = 10

-- ------- --
-- Keymaps --
-- ------- --

local function pum(active, inactive)
  return function()
    if vim.fn.pumvisible() ~= 0 then
      return active
    else
      return inactive
    end
  end
end

map.expr('i', '<Tab>', pum('<Down>', '<Tab>'))
map.expr('i', '<S-Tab>', pum('<Up>', '<S-Tab>'))
