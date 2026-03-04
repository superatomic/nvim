local M = vim.empty_dict()

M.DEFAULT_OPTS = { noremap = true, silent = true }

setmetatable(M, {
  __call = function(_, mode, lhs, rhs, desc, opts)
    if type(lhs) == 'table' then
      vim.iter(lhs):each(function(lhs1) M(mode, lhs1, rhs, desc, opts) end)
      return
    end
    opts = vim.tbl_extend('keep', opts or {}, { desc = desc }, M.DEFAULT_OPTS)
    vim.keymap.set(mode, lhs, rhs, opts)
  end
})

function M.leader_group(section, group_desc, global_opts)
  local modes = {} -- List of modes with `group_desc` added to them
  local prefix = '<Leader>' .. (section or '')
  return function(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('keep', opts or {}, global_opts or {})
    if group_desc ~= nil and not vim.list_contains(modes, mode) then
      -- Add description for prefix
      vim.keymap.set(mode, prefix, '<Nop>', { desc = group_desc })
      table.insert(modes, mode)
    end
    M(mode, prefix .. lhs, rhs, desc, opts)
  end
end

M.leader_map = M.leader_group('', 'Leader')

return M
