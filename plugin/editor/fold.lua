local function foldtext_default()
  local fold_start = vim.fn.getline(vim.v.foldstart)
  local fold_end = vim.fn.getline(vim.v.foldend)

  local dedented = vim.text.indent(0, fold_start .. '\n' .. fold_end)
  local dedented_end = vim.split(dedented, '\n')[2]

  -- Don't do anything smart if the start of the fold looks like an INI section
  local is_ini = fold_start:match('^%s*%[.+%]%s*$')

  if vim.v.foldstart == vim.v.foldend
      or dedented_end:match('^%s')
      or is_ini then
    return fold_start
  else
    return fold_start .. ' ... ' .. dedented_end
  end
end

local function foldtext_marker()
  local fold_end = vim.split(vim.wo.foldmarker, ',')[2]
  return vim.fn.getline(vim.v.foldstart) .. ' ... ' .. fold_end
end

function vim.g.foldtext()
  if vim.wo.foldmethod == 'marker' then
    return foldtext_marker()
  end
  return foldtext_default()
end

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = 'g:foldtext()'
vim.o.foldlevelstart = 99
