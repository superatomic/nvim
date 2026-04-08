local M = {}

M.DEFAULT_OPTS = { remap = false, silent = true }

function M._map(mode, lhs, rhs, desc, opts)
  if type(lhs) == 'table' then
    vim.iter(lhs):each(function(lhs1) M._map(mode, lhs1, rhs, desc, opts) end)
    return
  end
  opts = vim.tbl_extend('keep', opts or {}, { desc = desc }, M.DEFAULT_OPTS)
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.expr(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_extend('keep', opts or {}, { expr = true })
  M._map(mode, lhs, rhs, desc, opts)
end

function M._buffer_mapper(buf)
  return function(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('keep', opts or {}, { buf = buf })
    M._map(mode, lhs, rhs, desc, opts)
  end
end

setmetatable(M, {
  __call = function(_, ...)
    M._map(...)
  end,
  __index = function(_, ...)
    return M._buffer_mapper(...)
  end,
})

return M
